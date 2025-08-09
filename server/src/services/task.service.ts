import { Injectable } from '@nestjs/common';
import { CreateTaskDto } from '../models/dtos/CreateTask.dto';
import { UpdateTaskDto } from '../models/dtos/UpdateTask.dto';
import { EntityManager } from '@mikro-orm/core';
import { Task } from '../models/entites/Task.entity';

@Injectable()
export class TaskService {
  constructor(
    private readonly entityManager: EntityManager,
  ) {}

  async get(id: number) {
    return await this.entityManager.findOne(Task, { id });
  }
  async getAll(username: string) {
    return await this.entityManager.find(Task, {'username': username});
  }

  async getCompleted(username: string) {
    return await this.entityManager.find(Task, { 'username': username, 'is_completed': true });
  }

  async getPending(username: string) {
    return await this.entityManager.find(Task, { 'username': username, 'is_completed': false });
  }

  async create(createTaskDto: CreateTaskDto) {
    const task = this.entityManager.create(Task, createTaskDto);
    await this.entityManager.persistAndFlush(task)
    return task;
  }

  async update(id: number, updateTaskDto: UpdateTaskDto) {
    console.log(id, updateTaskDto);
    const task = await this.entityManager.findOne(Task, { id });
    if (!task) {
      throw new Error('Task not found');
    }
    this.entityManager.assign(task, updateTaskDto);
    await this.entityManager.flush();
    return task;
  }

  async setCompleted(id: number) {
    const task = await this.entityManager.findOne(Task, { id });
    if (task) {
      task.is_completed = true;
      await this.entityManager.flush();
    }
  }

  async setPending(id: number) {
    const task = await this.entityManager.findOne(Task, { id });
    if (task) {
      task.is_completed = false;
      await this.entityManager.flush();
    }
  }

  async remove(id: number) {
    const task = await this.entityManager.findOne(Task, { id });
    if (task) {
      await this.entityManager.removeAndFlush(task);
    }
  }
}
