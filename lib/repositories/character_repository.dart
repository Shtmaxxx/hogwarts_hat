import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hogwarts_hat/core/api_manager.dart';
import 'package:hogwarts_hat/models/character_model.dart';
import 'package:injectable/injectable.dart';
import 'package:hogwarts_hat/core/errors/failure.dart';

abstract class CharacterRepositoryI {
  Future<Either<Failure, CharacterModel>> getRandomCharacter();
  Future<Either<Failure, CharacterModel>> getCharacter(String id);
}

@Injectable(as: CharacterRepositoryI)
class CharacterRepositoryImpl implements CharacterRepositoryI {
  final ApiManager apiManager;

  CharacterRepositoryImpl(this.apiManager);

  @override
  Future<Either<Failure, CharacterModel>> getRandomCharacter() async {
    try {
      final response = await apiManager.get('character');

      if (response.statusCode == 200) {
        return Right(CharacterModel.fromJson(response.data.first));
      }

      return const Left(ServerFailure(message: 'Something went wrong.'));
    } on DioError catch (error) {
      return Left(
        ServerFailure(
          message: error.response?.data['error']['message'] ?? 'Server Error',
        ),
      );
    } catch (exception) {
      return Left(
        OtherFailure(message: exception.toString()),
      );
    }
  }
  
  @override
  Future<Either<Failure, CharacterModel>> getCharacter(String id) async {
    try {
      final response = await apiManager.get('character/$id');

      if (response.statusCode == 200) {
        return Right(CharacterModel.fromJson(response.data.first));
      }

      return const Left(ServerFailure(message: 'Something went wrong.'));
    } on DioError catch (error) {
      return Left(
        ServerFailure(
          message: error.response?.data['error']['message'] ?? 'Server Error',
        ),
      );
    } catch (exception) {
      return Left(
        OtherFailure(message: exception.toString()),
      );
    }
  }
}

