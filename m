From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] ACPI: Make acpi_dev_get_resources() method agnostic
Date: Wed, 26 Jul 2017 02:23:10 +0200
Message-ID: <3012251.02VKL2APyL@aspire.rjw.lan>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com> <24234737.CuhWYzNn5W@aspire.rjw.lan> <20170725091538.GB17133@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49434 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751080AbdGZAbJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jul 2017 20:31:09 -0400
In-Reply-To: <20170725091538.GB17133@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>

On Tuesday, July 25, 2017 10:15:38 AM Lorenzo Pieralisi wrote:
> On Sat, Jul 22, 2017 at 12:05:39AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 20, 2017 03:45:14 PM Lorenzo Pieralisi wrote:
> > > The function acpi_dev_get_resources() is completely generic and
> > > can be used to parse resource objects that are not necessarily
> > > coming from the _CRS method but also from other objects eg _DMA
> > > that have the same _CRS resource format.
> > > 
> > > Create an acpi_dev_get_resources() helper, internal to the ACPI
> > > resources parsing compilation unit, acpi_dev_get_resources_method(),
> > > that takes a char* parameter to detect which ACPI method should be
> > > called to retrieve the resources list and make acpi_dev_get_resources()
> > > call it with a method name _CRS leaving the API behaviour unchanged.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > ---
> > >  drivers/acpi/resource.c | 54 +++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 32 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > > index cd4c427..2b20a09 100644
> > > --- a/drivers/acpi/resource.c
> > > +++ b/drivers/acpi/resource.c
> > > @@ -573,6 +573,36 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
> > >  	return AE_OK;
> > >  }
> > >  
> > > +static
> > > +int acpi_dev_get_resources_method(struct acpi_device *adev,
> > 
> > Do not break lines like this, please.
> > 
> > It should be
> > 
> > static int acpi_dev_get...
> > 
> > Also I would call it differently, maybe simply __acpi_dev_get_resources()?
> > 
> > > +				  struct list_head *list,
> > > +				  int (*preproc)(struct acpi_resource *, void *),
> > > +				  void *preproc_data, char *method)
> > 
> > const char *method ?
> 
> drivers/acpi/resource.c: In function '__acpi_dev_get_resources':
> drivers/acpi/resource.c:587:37: warning: passing argument 2 of
> 'acpi_has_method' discards 'const' qualifier from pointer target type
> [-Wdiscarded-qualifiers]
>   if (!acpi_has_method(adev->handle, method))
>                                        ^~~~~~
> In file included from ./include/linux/acpi.h:44:0,
>                  from drivers/acpi/resource.c:21:
> 		 ./include/acpi/acpi_bus.h:55:6: note: expected 'char *'
> 		 but argument is of type 'const char *'
> 		  bool acpi_has_method(acpi_handle handle, char *name);
> 
> Same problem with acpi_walk_resources().
> 
> So either I fiddle (eg cast the const away) with the method string 
> in __acpi_dev_get_resources() or I can add an int/bool to detect
> which method to use ( _CRS or _DMA) instead of passing a const char *.

No, that'd be overkill.  Let's keep the (char *) in there.

Thanks,
Rafael

