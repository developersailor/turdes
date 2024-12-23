import { IsOptional, IsString, IsEmail, IsDate } from 'class-validator';

export class UpdateOrganizationDto {
  @IsOptional()
  @IsString()
  readonly name?: string;

  @IsOptional()
  @IsString()
  readonly type?: string;

  @IsOptional()
  @IsString()
  readonly mission?: string;

  @IsOptional()
  @IsString()
  readonly address?: string;

  @IsOptional()
  @IsString()
  readonly phone?: string;

  @IsOptional()
  @IsEmail()
  readonly email?: string;

  @IsOptional()
  @IsString()
  readonly website?: string;

  @IsOptional()
  @IsString()
  readonly socialMedia?: string;

  @IsOptional()
  @IsString()
  readonly contactName?: string;

  @IsOptional()
  @IsString()
  readonly contactPhone?: string;

  @IsOptional()
  @IsEmail()
  readonly contactEmail?: string;

  @IsOptional()
  @IsString()
  readonly donationAccount?: string;

  @IsOptional()
  @IsString()
  readonly iban?: string;

  @IsOptional()
  @IsString()
  readonly taxNumber?: string;

  @IsOptional()
  @IsString()
  readonly aidTypes?: string;

  @IsOptional()
  @IsString()
  readonly targetAudience?: string;

  @IsOptional()
  @IsString()
  readonly volunteerNeeds?: string;

  @IsOptional()
  @IsString()
  readonly activeProjects?: string;

  @IsOptional()
  @IsString()
  readonly events?: string;

  @IsOptional()
  @IsString()
  readonly logo?: string;

  @IsOptional()
  @IsDate()
  readonly establishedDate?: Date;
}