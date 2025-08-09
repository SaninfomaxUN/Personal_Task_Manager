import { Entity, PrimaryKey, ManyToOne, Property } from '@mikro-orm/core';
import { User } from './User.entity';

@Entity()
export class Task {
  @PrimaryKey()
  id: number;

  @ManyToOne(() => User, {
    mapToPk: true,
    joinColumn: 'username',
  })
  username: string;

  @Property()
  title: string;

  @Property({ columnType: 'text', nullable: true })
  description?: string;

  @Property({ default: false })
  is_completed: boolean = false;
}