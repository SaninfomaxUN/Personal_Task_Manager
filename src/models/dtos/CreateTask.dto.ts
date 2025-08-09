import { IsString, IsNotEmpty, MinLength, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateTaskDto {
  @ApiProperty({ description: 'The username of the user.' })
  @IsString()
  @IsNotEmpty()
  username: string;

  @ApiProperty({ description: 'The title of the task.' })
  @IsString()
  @IsNotEmpty()
  title: string;

  @ApiProperty({ description: 'The description of the task.' })
  @IsString()
  description: string;

  @ApiProperty({ description: 'The status of the task.' })
  @IsBoolean()
  @IsNotEmpty()
  is_completed: boolean;
}