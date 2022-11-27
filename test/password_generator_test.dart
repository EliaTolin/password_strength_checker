import 'package:flutter_test/flutter_test.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  test('Default password length is 16', () {
    final password = PasswordGenerator().generate();
    expect(password.length, 16);
  });

  test('Generate secure password', () {
    final password = PasswordGenerator().generate();
    expect(PasswordStrength.secure, PasswordStrength.calculate(text: password));
  });

  test('Generate secure password with length 8', () {
    const config = PasswordGeneratorConfiguration(length: 8);
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.length, 8);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.secure);
  });

  test('Generate strong password without uppercase', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useUppercase: false,
    );
    final password =
        PasswordGenerator.fromConfig(configuration: config).generate();

    expect(password.contains(RegExp(r'[A-Z]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.strong);
  });

  test('Generate strong password without lowercase', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useLowercase: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[a-z]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.strong);
  });

  test('Generate strong password without digits', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useDigits: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[0-9]')), false);
    expect(PasswordStrength.strong, PasswordStrength.calculate(text: password));
  });

  test('Generate weak password only digits', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useLowercase: false,
      useUppercase: false,
      useSpecialChars: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[0-9]')), true);
    expect(password.contains(RegExp(r'[a-z]')), false);
    expect(password.contains(RegExp(r'[A-Z]')), false);
    expect(password.contains(RegExp(r'[!@#\$%^&*(){}?£~\-_+=]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.weak);
  });

  test('Generate weak password only lowercase', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useDigits: false,
      useUppercase: false,
      useSpecialChars: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[a-z]')), true);
    expect(password.contains(RegExp(r'[0-9]')), false);
    expect(password.contains(RegExp(r'[A-Z]')), false);
    expect(password.contains(RegExp(r'[!@#\$%^&*(){}?£~\-_+=]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.weak);
  });

  test('Generate weak password only uppercase', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useDigits: false,
      useLowercase: false,
      useSpecialChars: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[A-Z]')), true);
    expect(password.contains(RegExp(r'[0-9]')), false);
    expect(password.contains(RegExp(r'[a-z]')), false);
    expect(password.contains(RegExp(r'[!@#\$%^&*(){}?£~\-_+=]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.weak);
  });

  test('Generate weak password only special chars', () {
    const config = PasswordGeneratorConfiguration(
      length: 8,
      useDigits: false,
      useLowercase: false,
      useUppercase: false,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'[!@#\$%^&*(){}?£~\-_+=]')), true);
    expect(password.contains(RegExp(r'[0-9]')), false);
    expect(password.contains(RegExp(r'[a-z]')), false);
    expect(password.contains(RegExp(r'[A-Z]')), false);
    expect(PasswordStrength.calculate(text: password), PasswordStrength.weak);
  });

  test('Generate password with minUppercase = 8', () {
    const config = PasswordGeneratorConfiguration(
      minUppercase: 8,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'(.*[A-Z]){8}')), true);
  });

  test('Generate password with minLowercase = 8', () {
    const config = PasswordGeneratorConfiguration(
      minLowercase: 8,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'(.*[a-z]){8}')), true);
  });

  test('Generate password with minDigits = 8', () {
    const config = PasswordGeneratorConfiguration(
      minDigits: 8,
    );
    final password = PasswordGenerator.fromConfig(
      configuration: config,
    ).generate();

    expect(password.contains(RegExp(r'(.*[0-9]){8}')), true);
  });
}
