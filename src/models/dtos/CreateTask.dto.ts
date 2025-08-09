import { IsString, IsNotEmpty, MinLength, IsBoolean } from 'class-validator';

export class CreateTaskDto {
  @IsString()
  @IsNotEmpty()
  username: string;

  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  description: string;

  @IsBoolean()
  @IsNotEmpty()
  is_completed: boolean;
}