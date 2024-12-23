import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCampaignDto } from './dto/create-campaign.dto';
import { CreateEventDto } from './dto/create-event.dto';

@Injectable()
export class CampaignsService {
  constructor(private readonly prisma: PrismaService) {}

  async createCampaign(createCampaignDto: CreateCampaignDto) {
    return this.prisma.campaign.create({
      data: createCampaignDto,
    });
  }

  async findAllCampaigns() {
    return this.prisma.campaign.findMany();
  }

  async findCampaignById(id: number) {
    return this.prisma.campaign.findUnique({
      where: { id: Number(id) },
    });
  }

  async updateCampaign(id: number, updateCampaignDto: CreateCampaignDto) {
    return this.prisma.campaign.update({
      where: { id: Number(id) },
      data: updateCampaignDto,
    });
  }

  async deleteCampaign(id: number) {
    return this.prisma.campaign.delete({
      where: { id: Number(id) },
    });
  }

  async createEvent(campaignId: number, createEventDto: CreateEventDto) {
    return this.prisma.event.create({
      data: {
        ...createEventDto,
        campaign: {
          connect: { id: campaignId },
        },
      },
    });
  }

  async findAllEvents(campaignId: number) {
    return this.prisma.event.findMany({
      where: { campaignId: campaignId },
    });
  }

  async findEventById(campaignId: number, eventId: number) {
    return this.prisma.event.findUnique({
      where: { id: eventId, campaignId: campaignId },
    });
  }

  async updateEvent(campaignId: number, eventId: number, updateEventDto: CreateEventDto) {
    return this.prisma.event.update({
      where: { id: eventId, campaignId: campaignId },
      data: updateEventDto,
    });
  }

  async deleteEvent(campaignId: number, eventId: number) {
    return this.prisma.event.delete({
      where: { id: eventId, campaignId: campaignId },
    });
  }
}