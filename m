From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/3] gpio / ACPI: add ACPI support
Date: Fri, 16 Nov 2012 14:49:49 +0200
Message-ID: <20121116124949.GQ17774@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121116080549.GO17774@intel.com>
 <20121116081246.GP17774@intel.com>
 <2746620.3kEZE8KPDY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33674 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab2KPMqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Nov 2012 07:46:39 -0500
Content-Disposition: inline
In-Reply-To: <2746620.3kEZE8KPDY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Fri, Nov 16, 2012 at 11:02:05AM +0100, Rafael J. Wysocki wrote:
> On Friday, November 16, 2012 10:12:46 AM Mika Westerberg wrote:
> > On Fri, Nov 16, 2012 at 10:05:49AM +0200, Mika Westerberg wrote:
> > > 
> > > One more thing, sometimes we want to assign the handle like in the case of
> > > SPI controller driver we set the master->dev.acpi_handle. In that case we
> > > can't use DEVICE_ACPI_HANDLE() as is. Should we just do something like:
> > > 
> > > 	master->dev.acpi_handle = pdev->dev.acpi_handle;
> > > 
> > > or should we introduce some new macro that supports this?
> > 
> > Or we could just drop the cast from the macro and use the same.
> > 
> > 	#define DEVICE_ACPI_HANDLE(dev)	((dev)->acpi_handle)
> 
> Well, I'm not sure.  Perhaps it's better to add a new macro, like
> ACPI_HANDLE(dev), defined as above and use it going forward (we can then
> phase out the old one gradually).

Yeah, that sounds good.

> However, let's leave the patches in this series as they are for now, we can
> add that macro in a separate patch later.

OK.
