abstract class PostStates{}

class PostInitialState extends PostStates{}

class PostLoadingState extends PostStates{}

class PostSuccessState extends PostStates{
  final String uId;
  PostSuccessState(this.uId);
}

class PostErrorState extends PostStates{
  final String error;
  PostErrorState(this.error);
}

class PostImageLoadingState extends PostStates{}

class PostImageSuccessState extends PostStates{
  final String uId;
  PostImageSuccessState(this.uId);
}

class PostImageErrorState extends PostStates{
  final String error;
  PostImageErrorState(this.error);
}