From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V3 2/4] ACPI / bus: introduce
 acpi_device_get_match_data() function
Date: Wed, 29 Nov 2017 19:25:36 +0530
Message-ID: <20171129135536.GD32417@localhost>
References: <1510281175-27173-1-git-send-email-okaya@codeaurora.org>
 <1510281175-27173-2-git-send-email-okaya@codeaurora.org>
 <31ef1ea5-ddb6-1a24-980b-7986627cfeca@codeaurora.org>
 <1605519.pfaIp4IsxJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdK2NwF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Nov 2017 08:52:05 -0500
Content-Disposition: inline
In-Reply-To: <1605519.pfaIp4IsxJ@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sinan Kaya <okaya@codeaurora.org>, dmaengine@vger.kernel.org, timur@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, Nov 12, 2017 at 01:14:12AM +0100, Rafael J. Wysocki wrote:
> On Friday, November 10, 2017 3:35:41 AM CET Sinan Kaya wrote:
> > +linux-acpi@vger.kernel.org, +Rafael
> 
> Thanks!
> 
> > On 11/9/2017 9:32 PM, Sinan Kaya wrote:
> > > OF has of_device_get_match_data() function to extract driver specific data
> > > structure. Add a similar function for ACPI.
> > > 
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > > ---
> > >  drivers/acpi/bus.c   | 12 ++++++++++++
> > >  include/linux/acpi.h |  6 ++++++
> > >  2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 4d0979e..da29c10 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
> > >  }
> > >  EXPORT_SYMBOL_GPL(acpi_match_device);
> > >  
> > > +void *acpi_device_get_match_data(const struct device *dev)
> > > +{
> > > +	const struct acpi_device_id *match;
> > > +
> > > +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
> > > +	if (!match)
> > > +		return NULL;
> > > +
> > > +	return (void *)match->driver_data;
> > > +}
> > > +EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
> 
> While I understand that the name follows the OF convention, I have some
> doubts on whether it is the best one.

Perhpas acpi_get_match_data() ?

-- 
~Vinod
