From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/4] ACPI: Make acpi_dev_get_resources() method agnostic
Date: Mon, 24 Jul 2017 10:22:39 +0100
Message-ID: <20170724092239.GC13145@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <20170720144517.32529-3-lorenzo.pieralisi@arm.com>
 <24234737.CuhWYzNn5W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdGXJUu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 05:20:50 -0400
Content-Disposition: inline
In-Reply-To: <24234737.CuhWYzNn5W@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>

On Sat, Jul 22, 2017 at 12:05:39AM +0200, Rafael J. Wysocki wrote:
> On Thursday, July 20, 2017 03:45:14 PM Lorenzo Pieralisi wrote:
> > The function acpi_dev_get_resources() is completely generic and
> > can be used to parse resource objects that are not necessarily
> > coming from the _CRS method but also from other objects eg _DMA
> > that have the same _CRS resource format.
> > 
> > Create an acpi_dev_get_resources() helper, internal to the ACPI
> > resources parsing compilation unit, acpi_dev_get_resources_method(),
> > that takes a char* parameter to detect which ACPI method should be
> > called to retrieve the resources list and make acpi_dev_get_resources()
> > call it with a method name _CRS leaving the API behaviour unchanged.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  drivers/acpi/resource.c | 54 +++++++++++++++++++++++++++++--------------------
> >  1 file changed, 32 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index cd4c427..2b20a09 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -573,6 +573,36 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
> >  	return AE_OK;
> >  }
> >  
> > +static
> > +int acpi_dev_get_resources_method(struct acpi_device *adev,
> 
> Do not break lines like this, please.
> 
> It should be
> 
> static int acpi_dev_get...
> 
> Also I would call it differently, maybe simply __acpi_dev_get_resources()?

Ok, it was how I wanted to call it but was not sure you would be happy
with it, I will rename it.

> > +				  struct list_head *list,
> > +				  int (*preproc)(struct acpi_resource *, void *),
> > +				  void *preproc_data, char *method)
> 
> const char *method ?

Yes, will update.

Thanks !
Lorenzo
