From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] acpi : move cpuidle_device field out of the acpi_processor_power structure
Date: Fri, 7 Sep 2012 23:54:28 +0200
Message-ID: <201209072354.28800.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <1347013172-12465-3-git-send-email-daniel.lezcano@linaro.org> <201209072340.33932.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42950 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab2IGVsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 17:48:10 -0400
In-Reply-To: <201209072340.33932.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Friday, September 07, 2012, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Daniel Lezcano wrote:
> > Currently we have the cpuidle_device field in the acpi_processor_power structure.
> > This adds a dependency in processor.h for cpuidle.h.
> > 
> > In order to be consistent with the rest of the drivers and for the per cpu states
> > coming right after this patch, this one move out of the acpi_processor_power
> > structure the cpuidle_device field.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/acpi/processor_idle.c |   25 ++++++++++++++++++-------
> >  include/acpi/processor.h      |    2 --
> >  2 files changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index de89624..084b1d2 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -79,6 +79,8 @@ module_param(bm_check_disable, uint, 0000);
> >  static unsigned int latency_factor __read_mostly = 2;
> >  module_param(latency_factor, uint, 0644);
> >  
> > +static DEFINE_PER_CPU(struct cpuidle_device, acpi_cpuidle_device);
> > +
> 
> Well.  Why are you moving that thing into the percpu memory?  It doesn't
> have to be per-CPU and storing it there just wastes the room.

Sorry, it is per-CPU already, scratch that.

Thanks,
Rafael
