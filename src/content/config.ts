import { defineCollection, z } from "astro:content";

export const collections = {
  tech: defineCollection({
    type: "content",
    schema: z.object({
      title: z.string(),
      description: z.string(),
      tags: z.array(z.string()),
      img: z.string(),
      img_alt: z.string().optional(),
    }),
  }),
  about: defineCollection({
    type: "content",
    schema: z.object({
      title: z.string(),
    }),
  }),
};
