import { NestFactory } from '@nestjs/core';
import { AppModule } from './modules/app.module';
import {ValidationPipe} from "@nestjs/common";
import { configSwagger } from './docs/Swagger.docs';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
    transform: true,
    forbidNonWhitelisted: false
  }));
  configSwagger(app);
  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
