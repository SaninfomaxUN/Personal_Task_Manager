import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { TaskService } from '../services/task.service';
import { CreateTaskDto } from '../models/dtos/CreateTask.dto';
import { UpdateTaskDto } from '../models/dtos/UpdateTask.dto';
import { AuthGuard } from '../auth/auth.guard';

@Controller('tasks')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @UseGuards(AuthGuard)
  @Get('all/:username')
  async getAll(@Param('username') username: string){
    return this.taskService.getAll(username);
  }

  @UseGuards(AuthGuard)
  @Get('completed/:username')
  async getCompleted(@Param('username') username: string) {
    return this.taskService.getCompleted(username);
  }

  @UseGuards(AuthGuard)
  @Get('pending/:username')
  async getPending(@Param('username') username: string) {
    return this.taskService.getPending(username);
  }

  @UseGuards(AuthGuard)
  @Get(':id')
  async get(@Param('id') id: number) {
    return this.taskService.get(+id);
  }

  @UseGuards(AuthGuard)
  @Post()
  async create(@Body() createTaskDto: CreateTaskDto) {
    return this.taskService.create(createTaskDto);
  }

  @UseGuards(AuthGuard)
  @Patch(':id')
  async update( @Param('id') id: number, @Body() updateTaskDto: UpdateTaskDto) {
    console.log(id);
    return this.taskService.update(+id, updateTaskDto);
  }

  @UseGuards(AuthGuard)
  @Patch('set-completed/:id')
  async setCompleted(@Param('id') id: number) {
    return this.taskService.setCompleted(+id);
  }

  @UseGuards(AuthGuard)
  @Patch('set-pending/:id')
  async setPending(@Param('id') id: number) {
    return this.taskService.setPending(+id);
  }

  @UseGuards(AuthGuard)
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.taskService.remove(+id);
  }

}