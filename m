From: Dmitry Frank <mail@dmitryfrank.com>
Subject: Re: [PATCH v2 2/3] ACPI: video: rename the global flag
 device_id_scheme
Date: Wed, 19 Apr 2017 13:40:05 +0300
Message-ID: <20170419104004.GA17642@dimon-t520>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
 <20170419094809.12895-1-mail@dmitryfrank.com>
 <20170419094809.12895-3-mail@dmitryfrank.com>
 <CAJZ5v0h+UXc5Ty5eXw1=oc7g2cdgnUeXLApdC38M2mEx6hsk5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward13j.cmail.yandex.net ([5.255.227.177]:54256 "EHLO
        forward13j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762289AbdDSKkZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 06:40:25 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h+UXc5Ty5eXw1=oc7g2cdgnUeXLApdC38M2mEx6hsk5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Rafael,

On 04/19, Rafael J. Wysocki wrote:
> On Wed, Apr 19, 2017 at 11:48 AM, Dmitry Frank <mail@dmitryfrank.com> wrote:
> > This flag forces device_id_scheme bit in the struct
> > acpi_video_device_attrib to be assumed even if not actually set, so a
> > better name for the global flag would be "force_device_id_scheme".
> >
> > Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
> > ---
> >  drivers/acpi/acpi_video.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 9a607af971e7..cfd3bed57bed 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -73,8 +73,12 @@ module_param(report_key_events, int, 0644);
> >  MODULE_PARM_DESC(report_key_events,
> >         "0: none, 1: output changes, 2: brightness changes, 3: all");
> >
> > -static bool device_id_scheme = false;
> > -module_param(device_id_scheme, bool, 0444);
> > +/*
> > + * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
> > + * assumed even if not actually set.
> > + */
> > +static bool force_device_id_scheme = false;
> > +module_param(force_device_id_scheme, bool, 0444);
> 
> The concern here is that if somebody uses that module parameter with
> current (or previous) kernels, your change will break their setups.
> 
> It is better to simply add a comment clarifying the meaning of this flag IMO.
> 

Ah, true, sorry for overlooking that. Fixed in v3.

Thanks,
Dmitry
