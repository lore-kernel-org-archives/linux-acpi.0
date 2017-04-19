From: Dmitry Frank <mail@dmitryfrank.com>
Subject: Re: [PATCH] acpi: video: get rid of magic numbers and use enum
 instead
Date: Wed, 19 Apr 2017 12:58:03 +0300
Message-ID: <20170419095803.GA9993@dimon-t520>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
 <CAJZ5v0jRJhhZehYFzb6LtaheGsgXUb6OCZvoCHraFgwx2M_GVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward4p.cmail.yandex.net ([77.88.31.19]:53899 "EHLO
        forward4p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760784AbdDSKFW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 06:05:22 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jRJhhZehYFzb6LtaheGsgXUb6OCZvoCHraFgwx2M_GVQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 04/19, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tue, Apr 18, 2017 at 2:35 PM, Dmitry Frank <mail@dmitryfrank.com> wrote:
> > The first two items in the _BCL method response are special:
> >
> >   - Level when machine has full power
> >   - Level when machine is on batteries
> >   - .... actual supported levels go there ....
> >
> > So this commits adds an enum and uses its descriptive elements
> > throughout the code, instead of magic numbers.
> >
> > Some subtle cases are commented additionally (the comment for
> > acpi_video_bqc_quirk is by Felipe Contreras, CCed)
> 
> So that should be a separate patch.  Please split.
> 

Sure, done; please see the "v2" patchset. (It contains one more change:
renaming of the global flag device_id_scheme, since the old name is
misleading)

> >
> > Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
> > ---
> >  drivers/acpi/acpi_video.c | 134 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 89 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index d00bc0ef87a6..856694e5f325 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -88,6 +88,18 @@ static int acpi_video_bus_remove(struct acpi_device *device);
> >  static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
> >  void acpi_video_detect_exit(void);
> >
> > +/*
> > + * Indices in the _BCL method response: the first two items are special,
> > + * the rest are all supported levels.
> > + *
> > + * See page 575 of the ACPI spec 3.0
> > + */
> > +enum lvl_idx {
> > +       LVL_IDX_AC,             /* level when machine has full power */
> > +       LVL_IDX_BATTERY,        /* level when machine is on batteries */
> > +       LVL_IDX_FIRST,          /* actual supported levels begin here */
> 
> What about using different symbol names, like ACPI_VIDEO_AC_LEVEL,
> ACPI_VIDEO_BATTERY_LEVEL and ACPI_VIDEO_FIRST_LEVEL, respectively?
> 

Honestly, I find ACPI_VIDEO_..._LEVEL a bit misleading, because these
values are not levels, they are indices of levels. So I'd probably
prefer ..._LEVEL_INDEX, or ..._LEVEL_IDX, but it probably gets too long,
so...

Anyway, the patchset v2 contains the names you proposed; if you agree
that LEVEL_INDEX or LEVEL_IDX would be better, please let me know, and
I'll be happy to craft v3. Otherwise, I'm fine with these names too.

> > +};
> > +
> >  static const struct acpi_device_id video_device_ids[] = {
> >         {ACPI_VIDEO_HID, 0},
> >         {"", 0},
> > @@ -132,7 +144,7 @@ struct acpi_video_device_attrib {
> >                                    the VGA device. */
> >         u32 pipe_id:3;          /* For VGA multiple-head devices. */
> >         u32 reserved:10;        /* Must be 0 */
> > -       u32 device_id_scheme:1; /* Device ID Scheme */
> > +       u32 device_id_scheme:1; /* Whether the device ID follows this scheme above */
> 
> That still is not particularly clear (although admittedly it is better
> than what we have).
> 

Ok, I added a descriptive comment above the field.

> Thanks,
> Rafael
