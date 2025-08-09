import { ConfigService } from '@nestjs/config';
import { PostgreSqlDriver } from '@mikro-orm/postgresql';
import { Options } from '@mikro-orm/core';

export const getDatabaseConfig  = (configService: ConfigService): Options<PostgreSqlDriver> => ({
  driver: PostgreSqlDriver,
  entities: ['dist/**/*.entity.js'],
  entitiesTs: ['src/**/*.entity.ts'],
  host: configService.get('DB_HOST'),
  port: configService.get('DB_PORT'),
  user: configService.get('DB_USER'),
  password: configService.get('DB_PASSWORD'),
  dbName: configService.get('DB_NAME'),
  debug: true,
  logger: (message: string) => console.log(message)
});