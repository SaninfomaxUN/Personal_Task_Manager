import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { INestApplication } from '@nestjs/common';


export const configSwagger = (app:  INestApplication) => {
    const config = new DocumentBuilder()
        .setTitle('Personal Task Manager')
        .setDescription('The Personal Task Manager API description')
        .setVersion('1.0')
        .addTag('to-do-list')
        .build();

    const documentFactory = () => SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('docs', app, documentFactory);
};