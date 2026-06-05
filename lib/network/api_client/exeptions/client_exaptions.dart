import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Exception class for remote MQ (Message Queue) errors.
/// [failureType] indicates the type of failure.
/// Optional [error], [message], [stackTrace],
/// and [statusCode] provide additional details.
@immutable
final class RemoteException implements Exception {
  const RemoteException(
    this.failureType, {
    this.error,
    this.message,
    this.stackTrace,
    this.statusCode,
    this.dioException,
  });

  final dynamic error;
  final FailureType failureType;
  final StackTrace? stackTrace;
  final String? message;
  final int? statusCode;
  final DioException? dioException;
}

/// Enum representing different failure types.
enum FailureType {
  /// HTTP 400 error.
  badRequest('Represents http error '),

  /// HTTP 401 error.
  noAuthorization('Authentication error'),

  /// HTTP 403 error.
  forbidden('Forbidden http error'),

  /// HTTP 500 error.
  internalServer('Internal server http error'),

  /// JSON decoding error.
  decode('Json decode error'),

  /// JSON deserialization error.
  deserialization('Json deserialization error'),

  /// No internet connection error.
  connection('Device unconected internet'),

  /// Unknown error.
  unknown('Unknown error');

  const FailureType(this.message);

  final String message;
}