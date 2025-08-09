import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello. This is the API Service for the Wagon Test APP.';
  }
}
