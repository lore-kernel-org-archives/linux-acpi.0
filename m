From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] acpi : move cpuidle_device field out of the acpi_processor_power structure
Date: Sat, 8 Sep 2012 00:06:11 +0200
Message-ID: <201209080006.11888.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209072340.33932.rjw@sisk.pl> <201209072354.28800.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42971 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab2IGV7x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 17:59:53 -0400
In-Reply-To: <201209072354.28800.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Friday, September 07, 2012, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Rafael J. Wysocki wrote:
> > On Friday, September 07, 2012, Daniel Lezcano wrote:
> > > Currently we have the cpuidle_device field in the acpi_processor_power structure.
> > > This adds a dependency in processor.h for cpuidle.h.
> > > 
> > > In order to be consistent with the rest of the drivers and for the per cpu states
> > > coming right after this patch, this one move out of the acpi_processor_power
> > > structure the cpuidle_device field.
> > > 
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > ---
> > >  drivers/acpi/processor_idle.c |   25 ++++++++++++++++++-------
> > >  include/acpi/processor.h      |    2 --
> > >  2 files changed, 18 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > > index de89624..084b1d2 100644
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -79,6 +79,8 @@ module_param(bm_check_disable, uint, 0000);
> > >  static unsigned int latency_factor __read_mostly = 2;
> > >  module_param(latency_factor, uint, 0644);
> > >  
> > > +static DEFINE_PER_CPU(struct cpuidle_device, acpi_cpuidle_device);
> > > +
> > 
> > Well.  Why are you moving that thing into the percpu memory?  It doesn't
> > have to be per-CPU and storing it there just wastes the room.
> 
> Sorry, it is per-CPU already, scratch that.

Well, no, it isn't.  So I was right originally (boy, that code _is_ confusing).

So originally you had per-CPU pointers called 'processors' that each pointed
to a struct acpi_processor object created by acpi_processor_add() in slab
memory.  Your patch doesn't touch those pointers, so they are still there.

In addition to them it creates a number of static per-CPU objects that
previously were stored in those struct acpi_processor object mentioned above.
These things need not be stored in percpu memory.

Thanks,
Rafael
