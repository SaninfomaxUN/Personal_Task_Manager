import { Entity, PrimaryKey, Property, OneToMany, Collection } from '@mikro-orm/core';
import { Task } from './Task.entity';

@Entity()
export class User {
  @PrimaryKey()
  username: string;

  @Property({ hidden: true })
  password: string;

  @OneToMany(() => Task, task => task.username, {
    mappedBy: 'username',
  })
  tasks = new Collection<Task>(this);
}