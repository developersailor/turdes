import { ApiProperty } from '@nestjs/swagger';
import { IsArray, IsNumber, IsString } from 'class-validator';

export class DonationHistoryDto {
  @ApiProperty()
  @IsNumber()
  readonly donorId: number;

  @ApiProperty()
  @IsArray()
  readonly donations: string[];
}