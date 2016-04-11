From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3] device property: don't bother the drivers with struct
 property_set
Date: Mon, 11 Apr 2016 12:52:34 +0300
Message-ID: <20160411095234.GA26606@kuha.fi.intel.com>
References: <1459252343-105426-1-git-send-email-heikki.krogerus@linux.intel.com>
 <20160411082027.GF4592@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45664 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbcDKJwk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Apr 2016 05:52:40 -0400
Content-Disposition: inline
In-Reply-To: <20160411082027.GF4592@x1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 11, 2016 at 09:20:27AM +0100, Lee Jones wrote:
> On Tue, 29 Mar 2016, Heikki Krogerus wrote:
> 
> > Since device_add_property_set() now always takes a copy of
> > the property_set, and also since the fwnode type is always
> > hard coded to be FWNODE_PDATA, there is no need for the
> > drivers to deliver the entire struct property_set. The
> > function can just create the instance of it on its own and
> > bind the properties from the drivers to it on the spot.
> > 
> > This renames device_add_property_set() to
> > device_add_properties(). The function now takes struct
> > property_entry as its parameter instead of struct
> > property_set.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  arch/arm/mach-pxa/raumfeld.c      | 12 ++++--------

Daniel, I think we just need your ACK for this one.

Otherwise I think we are covered.

> >  arch/arm/mach-tegra/board-paz00.c |  6 +-----
> >  drivers/base/platform.c           | 19 ++++++++++---------
> >  drivers/base/property.c           | 34 +++++++++++++++++++++-------------
> >  drivers/mfd/intel-lpss-acpi.c     | 12 ++----------
> >  drivers/mfd/intel-lpss-pci.c      | 20 ++++----------------
> >  drivers/mfd/intel-lpss.c          |  2 +-
> >  drivers/mfd/intel-lpss.h          |  4 ++--
> >  drivers/mfd/mfd-core.c            |  4 ++--
> >  include/linux/mfd/core.h          |  4 ++--
> >  include/linux/platform_device.h   |  6 +++---
> >  include/linux/property.h          | 15 +++------------
> >  12 files changed, 55 insertions(+), 83 deletions(-)
> 
> What's happening with this patch?  I believe we're still missing
> Acks.  Once they are collected someone needs to create an immutable
> branch and send out a pull-request.

Rafael, have you had time to take a look at this?


Thanks,

-- 
heikki
