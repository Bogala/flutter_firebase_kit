// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignUpRequested value)?  signUpRequested,TResult Function( SignInRequested value)?  signInRequested,TResult Function( SignOutRequested value)?  signOutRequested,TResult Function( ResetPasswordRequested value)?  resetPasswordRequested,TResult Function( AuthStateChanged value)?  authStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case SignInRequested() when signInRequested != null:
return signInRequested(_that);case SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignUpRequested value)  signUpRequested,required TResult Function( SignInRequested value)  signInRequested,required TResult Function( SignOutRequested value)  signOutRequested,required TResult Function( ResetPasswordRequested value)  resetPasswordRequested,required TResult Function( AuthStateChanged value)  authStateChanged,}){
final _that = this;
switch (_that) {
case SignUpRequested():
return signUpRequested(_that);case SignInRequested():
return signInRequested(_that);case SignOutRequested():
return signOutRequested(_that);case ResetPasswordRequested():
return resetPasswordRequested(_that);case AuthStateChanged():
return authStateChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignUpRequested value)?  signUpRequested,TResult? Function( SignInRequested value)?  signInRequested,TResult? Function( SignOutRequested value)?  signOutRequested,TResult? Function( ResetPasswordRequested value)?  resetPasswordRequested,TResult? Function( AuthStateChanged value)?  authStateChanged,}){
final _that = this;
switch (_that) {
case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that);case SignInRequested() when signInRequested != null:
return signInRequested(_that);case SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password)?  signUpRequested,TResult Function( String email,  String password)?  signInRequested,TResult Function()?  signOutRequested,TResult Function( String email)?  resetPasswordRequested,TResult Function( AuthUser? user)?  authStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.email,_that.password);case SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case SignOutRequested() when signOutRequested != null:
return signOutRequested();case ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password)  signUpRequested,required TResult Function( String email,  String password)  signInRequested,required TResult Function()  signOutRequested,required TResult Function( String email)  resetPasswordRequested,required TResult Function( AuthUser? user)  authStateChanged,}) {final _that = this;
switch (_that) {
case SignUpRequested():
return signUpRequested(_that.email,_that.password);case SignInRequested():
return signInRequested(_that.email,_that.password);case SignOutRequested():
return signOutRequested();case ResetPasswordRequested():
return resetPasswordRequested(_that.email);case AuthStateChanged():
return authStateChanged(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password)?  signUpRequested,TResult? Function( String email,  String password)?  signInRequested,TResult? Function()?  signOutRequested,TResult? Function( String email)?  resetPasswordRequested,TResult? Function( AuthUser? user)?  authStateChanged,}) {final _that = this;
switch (_that) {
case SignUpRequested() when signUpRequested != null:
return signUpRequested(_that.email,_that.password);case SignInRequested() when signInRequested != null:
return signInRequested(_that.email,_that.password);case SignOutRequested() when signOutRequested != null:
return signOutRequested();case ResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class SignUpRequested implements AuthEvent {
  const SignUpRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpRequestedCopyWith<SignUpRequested> get copyWith => _$SignUpRequestedCopyWithImpl<SignUpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signUpRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignUpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignUpRequestedCopyWith(SignUpRequested value, $Res Function(SignUpRequested) _then) = _$SignUpRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$SignUpRequestedCopyWithImpl<$Res>
    implements $SignUpRequestedCopyWith<$Res> {
  _$SignUpRequestedCopyWithImpl(this._self, this._then);

  final SignUpRequested _self;
  final $Res Function(SignUpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SignUpRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignInRequested implements AuthEvent {
  const SignInRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInRequestedCopyWith<SignInRequested> get copyWith => _$SignInRequestedCopyWithImpl<SignInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signInRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignInRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $SignInRequestedCopyWith(SignInRequested value, $Res Function(SignInRequested) _then) = _$SignInRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$SignInRequestedCopyWithImpl<$Res>
    implements $SignInRequestedCopyWith<$Res> {
  _$SignInRequestedCopyWithImpl(this._self, this._then);

  final SignInRequested _self;
  final $Res Function(SignInRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SignInRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignOutRequested implements AuthEvent {
  const SignOutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOutRequested()';
}


}




/// @nodoc


class ResetPasswordRequested implements AuthEvent {
  const ResetPasswordRequested({required this.email});
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordRequestedCopyWith<ResetPasswordRequested> get copyWith => _$ResetPasswordRequestedCopyWithImpl<ResetPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.resetPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ResetPasswordRequestedCopyWith(ResetPasswordRequested value, $Res Function(ResetPasswordRequested) _then) = _$ResetPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ResetPasswordRequestedCopyWithImpl<$Res>
    implements $ResetPasswordRequestedCopyWith<$Res> {
  _$ResetPasswordRequestedCopyWithImpl(this._self, this._then);

  final ResetPasswordRequested _self;
  final $Res Function(ResetPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ResetPasswordRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthStateChanged implements AuthEvent {
  const AuthStateChanged({this.user});
  

 final  AuthUser? user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateChangedCopyWith<AuthStateChanged> get copyWith => _$AuthStateChangedCopyWithImpl<AuthStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateChanged&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.authStateChanged(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthStateChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthStateChangedCopyWith(AuthStateChanged value, $Res Function(AuthStateChanged) _then) = _$AuthStateChangedCopyWithImpl;
@useResult
$Res call({
 AuthUser? user
});


$AuthUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthStateChangedCopyWithImpl<$Res>
    implements $AuthStateChangedCopyWith<$Res> {
  _$AuthStateChangedCopyWithImpl(this._self, this._then);

  final AuthStateChanged _self;
  final $Res Function(AuthStateChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(AuthStateChanged(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser?,
  ));
}

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AuthUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
