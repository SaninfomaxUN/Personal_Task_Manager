import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UserService } from './user.service';
import { SignInDto } from '../models/dtos/SignIn.dto';
import { JwtService } from '@nestjs/jwt';
import { PasswordUtils } from '../auth/password.utils';

@Injectable()
export class AuthService {
  constructor(
    private userService: UserService,
    private jwtService: JwtService
  ) {}

  async signIn(signInDto: SignInDto): Promise<any> {
    const user = await this.userService.get(signInDto.username);

    if (user) {
      if (await PasswordUtils.comparePasswords(signInDto.password, user.password)) {
        const payload = {username: user.username };
        return {
          access_token: await this.jwtService.signAsync(payload),
        };
      }
    }
    throw new UnauthorizedException();
  }




}
