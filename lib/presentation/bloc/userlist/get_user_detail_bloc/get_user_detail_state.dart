part of 'get_user_detail_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  final UserEntity? userDetailEntity;
  final List<XFile>? imageFiles;
  final bool? isZoomed;
  final String? imageUrl;

  const _ViewModel(
      {this.userDetailEntity, this.imageFiles, this.isZoomed, this.imageUrl});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    UserEntity? userDetailEntity,
    List<XFile>? imageFiles,
    bool? isZoomed,
    String? imageUrl,
  }) {
    return _ViewModel(
      userDetailEntity: userDetailEntity ?? this.userDetailEntity,
      imageFiles: imageFiles ?? this.imageFiles,
      isZoomed: isZoomed ?? this.isZoomed,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

// Abstract class
abstract class GetUserDetailState {
  final _ViewModel viewModel;
  // Status of the state. GetUserDetail "success" "failed" "loading"
  final BlocStatusState status;

  GetUserDetailState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of GetUserDetailState (abstract class)
  T copyWith<T extends GetUserDetailState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == GetUserDetailState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class DeleteImageState extends GetDetailUserState {
  DeleteImageState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel: viewModel, status: status);
}

class PickImageState extends GetDetailUserState {
  PickImageState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel: viewModel, status: status);
}

class LoadImageState extends GetDetailUserState {
  LoadImageState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel: viewModel, status: status);
}

class GetUserDetailInitialState extends GetUserDetailState {
  GetUserDetailInitialState({
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetDetailUserState extends GetUserDetailState {
  GetDetailUserState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UpdateUserState extends GetUserDetailState {
  UpdateUserState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class DeleteUserState extends GetUserDetailState {
  DeleteUserState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  GetUserDetailInitialState: (viewModel, status) => GetUserDetailInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetDetailUserState: (viewModel, status) => GetDetailUserState(
        viewModel: viewModel,
        status: status,
      ),
  UpdateUserState: (viewModel, status) => UpdateUserState(
        viewModel: viewModel,
        status: status,
      ),
  DeleteUserState: (viewModel, status) => DeleteUserState(
        viewModel: viewModel,
        status: status,
      ),
  PickImageState: (viewModel, status) => PickImageState(
        viewModel: viewModel,
        status: status,
      ),
  LoadImageState: (viewModel, status) => LoadImageState(
        viewModel: viewModel,
        status: status,
      ),
  DeleteImageState: (viewModel, status) => DeleteImageState(
        viewModel: viewModel,
        status: status,
      ),
};
