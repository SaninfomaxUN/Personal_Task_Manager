import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { TaskService } from '../services/task.service';
import { CreateTaskDto } from '../models/dtos/CreateTask.dto';
import { UpdateTaskDto } from '../models/dtos/UpdateTask.dto';

@Controller('tasks')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Get('all/:username')
  async getAll(@Param('username') username: string){
    return this.taskService.getAll(username);
  }

  @Get('completed/:username')
  async getCompleted(@Param('username') username: string) {
    return this.taskService.getCompleted(username);
  }

  @Get('pending/:username')
  async getPending(@Param('username') username: string) {
    return this.taskService.getPending(username);
  }

  @Get(':id')
  async get(@Param('id') id: number) {
    return this.taskService.get(+id);
  }

  @Post()
  async create(@Body() createTaskDto: CreateTaskDto) {
    return this.taskService.create(createTaskDto);
  }

  @Patch(':id')
  async update( @Param('id') id: number, @Body() updateTaskDto: UpdateTaskDto) {
    console.log(id);
    return this.taskService.update(+id, updateTaskDto);
  }


  @Patch('set-completed/:id')
  async setCompleted(@Param('id') id: number) {
    return this.taskService.setCompleted(+id);
  }

  @Patch('set-pending/:id')
  async setPending(@Param('id') id: number) {
    return this.taskService.setPending(+id);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.taskService.remove(+id);
  }

}