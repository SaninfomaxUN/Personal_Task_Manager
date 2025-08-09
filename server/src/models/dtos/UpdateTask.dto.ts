import {
  IsString,
  IsNotEmpty,
  MinLength,
  IsNumber,
  IsBoolean,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateTaskDto {

  @ApiProperty({ description: 'The username of the user.' })
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