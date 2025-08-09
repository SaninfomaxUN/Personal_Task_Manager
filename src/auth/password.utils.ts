import * as bcrypt from 'bcrypt';

export class PasswordUtils {
  private static readonly SALT_OR_ROUNDS = 10;
  private static readonly PASSWORD_SECRET = process.env.PASSWORD_SECRET;

  static async hashPassword(password: string): Promise<string> {
    const saltedPassword = password + this.PASSWORD_SECRET;
    return await bcrypt.hash(saltedPassword, this.SALT_OR_ROUNDS);
  }

  static async comparePasswords(plainPassword: string, hashedPassword: string): Promise<boolean> {
    return await bcrypt.compare(plainPassword, hashedPassword);
  }
}
