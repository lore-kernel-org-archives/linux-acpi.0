From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] ACPI: D3cold state is always valid
Date: Wed, 18 Apr 2012 23:13:59 +0200
Message-ID: <201204182313.59916.rjw@sisk.pl>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com> <1334641676-14566-2-git-send-email-ming.m.lin@intel.com> <CAC=cRTPkFM5=az2B0A22miqt_X+XxcWPLrqPfeeRabho9yx-1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51614 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab2DRVJX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2012 17:09:23 -0400
In-Reply-To: <CAC=cRTPkFM5=az2B0A22miqt_X+XxcWPLrqPfeeRabho9yx-1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.og>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Aaron Lu <aaron.lu@amd.com>

On Tuesday, April 17, 2012, huang ying wrote:
> On Tue, Apr 17, 2012 at 1:47 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> > ACPI_STATE_D3 actually means ACPI D3hot which is not always valid.
> > Instead, ACPI D3cold is always valid.
> >
> > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > ---
> >  drivers/acpi/scan.c |   11 ++---------
> >  1 files changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 767e2dc..fb56388 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -884,13 +884,6 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
> >                                acpi_bus_add_power_resource(ps->resources.handles[j]);
> >                }
> >
> > -               /* The exist of _PR3 indicates D3Cold support */
> > -               if (i == ACPI_STATE_D3) {
> > -                       status = acpi_get_handle(device->handle, object_name, &handle);
> > -                       if (ACPI_SUCCESS(status))
> > -                               device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
> > -               }
> > -
> >                /* Evaluate "_PSx" to see if we can do explicit sets */
> >                object_name[2] = 'S';
> >                status = acpi_get_handle(device->handle, object_name, &handle);
> > @@ -908,8 +901,8 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
> >        /* Set defaults for D0 and D3 states (always valid) */
> >        device->power.states[ACPI_STATE_D0].flags.valid = 1;
> >        device->power.states[ACPI_STATE_D0].power = 100;
> > -       device->power.states[ACPI_STATE_D3].flags.valid = 1;
> > -       device->power.states[ACPI_STATE_D3].power = 0;
> > +       device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
> > +       device->power.states[ACPI_STATE_D3_COLD].power = 0;
> >
> >        acpi_bus_init_power(device);
> 
> I think D3_HOT should be always valid, while D3_COLD should be valid
> for some situation.

This need not be PCI, mind you.

>  - has _PS3, no _PR3
>    - support D3_HOT, D3_COLD

Nope.  D3_HOT cannot be supported in that case at the ACPI level.

>    - set state
>      - D3_HOT: do nothing in ACPI

That is not D3_HOT, then, from the ACPI point of view.  It is a different
power state.

Suppose you have a non-PCI device that can be only power-manageable via ACPI
and that device has only _PS0 and _PS3.  How would you put it into D3_HOT,
in particular?

>      - D3_COLD: _PS3

Thanks,
Rafael
