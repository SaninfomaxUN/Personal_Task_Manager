import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { User } from '../models/entites/User.entity';

@Injectable()
export class UserService {
  constructor(
    private readonly entityManager: EntityManager,
  ) {}

  async get(username: string) {
    return await this.entityManager.findOne(User, { username });
  }

}