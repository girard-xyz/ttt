// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameEvent()';
}


}

/// @nodoc
class $GameEventCopyWith<$Res>  {
$GameEventCopyWith(GameEvent _, $Res Function(GameEvent) __);
}


/// Adds pattern-matching-related methods to [GameEvent].
extension GameEventPatterns on GameEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CellTapped value)?  cellTapped,TResult Function( NewGame value)?  newGame,TResult Function( LoadGame value)?  loadGame,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CellTapped() when cellTapped != null:
return cellTapped(_that);case NewGame() when newGame != null:
return newGame(_that);case LoadGame() when loadGame != null:
return loadGame(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CellTapped value)  cellTapped,required TResult Function( NewGame value)  newGame,required TResult Function( LoadGame value)  loadGame,}){
final _that = this;
switch (_that) {
case CellTapped():
return cellTapped(_that);case NewGame():
return newGame(_that);case LoadGame():
return loadGame(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CellTapped value)?  cellTapped,TResult? Function( NewGame value)?  newGame,TResult? Function( LoadGame value)?  loadGame,}){
final _that = this;
switch (_that) {
case CellTapped() when cellTapped != null:
return cellTapped(_that);case NewGame() when newGame != null:
return newGame(_that);case LoadGame() when loadGame != null:
return loadGame(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int index)?  cellTapped,TResult Function( GameMode mode,  Player humanPlayer)?  newGame,TResult Function()?  loadGame,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CellTapped() when cellTapped != null:
return cellTapped(_that.index);case NewGame() when newGame != null:
return newGame(_that.mode,_that.humanPlayer);case LoadGame() when loadGame != null:
return loadGame();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int index)  cellTapped,required TResult Function( GameMode mode,  Player humanPlayer)  newGame,required TResult Function()  loadGame,}) {final _that = this;
switch (_that) {
case CellTapped():
return cellTapped(_that.index);case NewGame():
return newGame(_that.mode,_that.humanPlayer);case LoadGame():
return loadGame();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int index)?  cellTapped,TResult? Function( GameMode mode,  Player humanPlayer)?  newGame,TResult? Function()?  loadGame,}) {final _that = this;
switch (_that) {
case CellTapped() when cellTapped != null:
return cellTapped(_that.index);case NewGame() when newGame != null:
return newGame(_that.mode,_that.humanPlayer);case LoadGame() when loadGame != null:
return loadGame();case _:
  return null;

}
}

}

/// @nodoc


class CellTapped implements GameEvent {
  const CellTapped(this.index);
  

 final  int index;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellTappedCopyWith<CellTapped> get copyWith => _$CellTappedCopyWithImpl<CellTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellTapped&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'GameEvent.cellTapped(index: $index)';
}


}

/// @nodoc
abstract mixin class $CellTappedCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $CellTappedCopyWith(CellTapped value, $Res Function(CellTapped) _then) = _$CellTappedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$CellTappedCopyWithImpl<$Res>
    implements $CellTappedCopyWith<$Res> {
  _$CellTappedCopyWithImpl(this._self, this._then);

  final CellTapped _self;
  final $Res Function(CellTapped) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(CellTapped(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class NewGame implements GameEvent {
  const NewGame(this.mode, {this.humanPlayer = Player.x});
  

 final  GameMode mode;
@JsonKey() final  Player humanPlayer;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewGameCopyWith<NewGame> get copyWith => _$NewGameCopyWithImpl<NewGame>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewGame&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.humanPlayer, humanPlayer) || other.humanPlayer == humanPlayer));
}


@override
int get hashCode => Object.hash(runtimeType,mode,humanPlayer);

@override
String toString() {
  return 'GameEvent.newGame(mode: $mode, humanPlayer: $humanPlayer)';
}


}

/// @nodoc
abstract mixin class $NewGameCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $NewGameCopyWith(NewGame value, $Res Function(NewGame) _then) = _$NewGameCopyWithImpl;
@useResult
$Res call({
 GameMode mode, Player humanPlayer
});




}
/// @nodoc
class _$NewGameCopyWithImpl<$Res>
    implements $NewGameCopyWith<$Res> {
  _$NewGameCopyWithImpl(this._self, this._then);

  final NewGame _self;
  final $Res Function(NewGame) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? humanPlayer = null,}) {
  return _then(NewGame(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,humanPlayer: null == humanPlayer ? _self.humanPlayer : humanPlayer // ignore: cast_nullable_to_non_nullable
as Player,
  ));
}


}

/// @nodoc


class LoadGame implements GameEvent {
  const LoadGame();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadGame);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameEvent.loadGame()';
}


}




// dart format on
