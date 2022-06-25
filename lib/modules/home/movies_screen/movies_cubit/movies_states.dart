abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesSuccess extends MoviesState {}

class MoviesToggleFav extends MoviesState {}

class MoviesError extends MoviesState {}
