From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3] drivers/acpi/video: fix brightness allocation
Date: Fri, 27 Jun 2008 11:51:35 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806271151230.2988@localhost.localdomain>
References: <485CDEDB.3080101@gmail.com>
 <1214184121.3001.34.camel@rzhang-dt.sh.intel.com>  <48601AB2.30900@gmail.com>
 <1214274377.3001.52.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:37965 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYF0Pvy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2008 11:51:54 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3400L86PE1XGH5@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Jun 2008 10:51:38 -0500 (CDT)
In-reply-to: <1214274377.3001.52.camel@rzhang-dt.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Julia Jomantaite <julia.jomantaite@gmail.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org



On Tue, 24 Jun 2008, Zhang Rui wrote:

> 
> On Tue, 2008-06-24 at 05:50 +0800, Julia Jomantaite wrote:
> > Fix use of uninitialized device->brightness.
> > 
> > Signed-off-by: Julia Jomantaite <julia.jomantaite@gmail.com>

> Acked-by: Zhang Rui <rui.zhang@intel.com>

applied.
thanks,
-Len

> > ---
> > --- orig/drivers/acpi/video.c   2008-06-12 17:15:08.000000000 +0100
> > +++ linux-2.6/drivers/acpi/video.c      2008-06-23 08:44:35.000000000
> > +0100
> > @@ -631,6 +631,76 @@ acpi_video_bus_DOS(struct acpi_video_bus
> >   *     device  : video output device (LCD, CRT, ..)
> >   *
> >   *  Return Value:
> > + *     Maximum brightness level
> > + *
> > + *  Allocate and initialize device->brightness.
> > + */
> > +
> > +static int
> > +acpi_video_init_brightness(struct acpi_video_device *device)
> > +{
> > +       union acpi_object *obj = NULL;
> > +       int i, max_level = 0, count = 0;
> > +       union acpi_object *o;
> > +       struct acpi_video_device_brightness *br = NULL;
> > +
> > +       if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device,
> > &obj))) {
> > +               ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query
> > available "
> > +                                               "LCD brightness level
> > \n"));
> > +               goto out;
> > +       }
> > +
> > +       if (obj->package.count < 2)
> > +               goto out;
> > +
> > +       br = kzalloc(sizeof(*br), GFP_KERNEL);
> > +       if (!br) {
> > +               printk(KERN_ERR "can't allocate memory\n");
> > +               goto out;
> > +       }
> > +
> > +       br->levels = kmalloc(obj->package.count * sizeof
> > *(br->levels),
> > +                               GFP_KERNEL);
> > +       if (!br->levels)
> > +               goto out_free;
> > +
> > +       for (i = 0; i < obj->package.count; i++) {
> > +               o = (union acpi_object *)&obj->package.elements[i];
> > +               if (o->type != ACPI_TYPE_INTEGER) {
> > +                       printk(KERN_ERR PREFIX "Invalid data\n");
> > +                       continue;
> > +               }
> > +               br->levels[count] = (u32) o->integer.value;
> > +
> > +               if (br->levels[count] > max_level)
> > +                       max_level = br->levels[count];
> > +               count++;
> > +       }
> > +
> > +       if (count < 2)
> > +               goto out_free_levels;
> > +
> > +       br->count = count;
> > +       device->brightness = br;
> > +       ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found %d brightness levels
> > \n", count));
> > +       kfree(obj);
> > +       return max_level;
> > +
> > +out_free_levels:
> > +       kfree(br->levels);
> > +out_free:
> > +       kfree(br);
> > +out:
> > +       device->brightness = NULL;
> > +       kfree(obj);
> > +       return 0;
> > +}
> > +
> > +/*
> > + *  Arg:
> > + *     device  : video output device (LCD, CRT, ..)
> > + *
> > + *  Return Value:
> >   *     None
> >   *
> >   *  Find out all required AML methods defined under the output
> > @@ -640,10 +710,7 @@ acpi_video_bus_DOS(struct acpi_video_bus
> >  static void acpi_video_device_find_cap(struct acpi_video_device
> > *device)
> >  {
> >         acpi_handle h_dummy1;
> > -       int i;
> >         u32 max_level = 0;
> > -       union acpi_object *obj = NULL;
> > -       struct acpi_video_device_brightness *br = NULL;
> > 
> > 
> >         memset(&device->cap, 0, sizeof(device->cap));
> > @@ -672,53 +739,7 @@ static void acpi_video_device_find_cap(s
> >                 device->cap._DSS = 1;
> >         }
> > 
> > -       if (ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device,
> > &obj))) {
> > -
> > -               if (obj->package.count >= 2) {
> > -                       int count = 0;
> > -                       union acpi_object *o;
> > -
> > -                       br = kzalloc(sizeof(*br), GFP_KERNEL);
> > -                       if (!br) {
> > -                               printk(KERN_ERR "can't allocate memory
> > \n");
> > -                       } else {
> > -                               br->levels =
> > kmalloc(obj->package.count *
> > -                                                    sizeof
> > *(br->levels), GFP_KERNEL);
> > -                               if (!br->levels)
> > -                                       goto out;
> > -
> > -                               for (i = 0; i < obj->package.count; i
> > ++) {
> > -                                       o = (union acpi_object
> > *)&obj->package.
> > -                                           elements[i];
> > -                                       if (o->type !=
> > ACPI_TYPE_INTEGER) {
> > -                                               printk(KERN_ERR PREFIX
> > "Invalid data\n");
> > -                                               continue;
> > -                                       }
> > -                                       br->levels[count] = (u32)
> > o->integer.value;
> > -
> > -                                       if (br->levels[count] >
> > max_level)
> > -                                               max_level =
> > br->levels[count];
> > -                                       count++;
> > -                               }
> > -                             out:
> > -                               if (count < 2) {
> > -                                       kfree(br->levels);
> > -                                       kfree(br);
> > -                               } else {
> > -                                       br->count = count;
> > -                                       device->brightness = br;
> > -
> > ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > -                                                         "found %d
> > brightness levels\n",
> > -                                                         count));
> > -                               }
> > -                       }
> > -               }
> > -
> > -       } else {
> > -               ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query
> > available LCD brightness level\n"));
> > -       }
> > -
> > -       kfree(obj);
> > +       max_level = acpi_video_init_brightness(device);
> > 
> >         if (device->cap._BCL && device->cap._BCM && device->cap._BQC
> > && max_level > 0){
> >                 int result;
> > @@ -1695,6 +1716,8 @@ static void
> >  acpi_video_switch_brightness(struct acpi_video_device *device, int
> > event)
> >  {
> >         unsigned long level_current, level_next;
> > +       if (!device->brightness)
> > +               return;
> >         acpi_video_device_lcd_get_level_current(device,
> > &level_current);
> >         level_next = acpi_video_get_next_level(device, level_current,
> > event);
> >         acpi_video_device_lcd_set_level(device, level_next);
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
