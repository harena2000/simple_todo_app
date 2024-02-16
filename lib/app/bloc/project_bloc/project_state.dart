part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {
  const ProjectState();
  
  @override
  List<Object> get props => [];
}

final class ProjectInitial extends ProjectState {}
