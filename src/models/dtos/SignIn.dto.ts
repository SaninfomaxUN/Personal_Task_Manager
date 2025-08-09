import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';


export class SignInDto {

  @ApiProperty({ description: 'The username of the user.' })
  @IsString()
  @IsNotEmpty()
  username: string;

  @ApiProperty({ description: 'The password of the user.' })
  @IsString()
  @IsNotEmpty()
  password: string;
}