From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] acpi: make message more descriptive/meaningful
Date: Tue, 7 Feb 2006 10:18:01 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602071017430.12589@shark.he.net>
References: <20060206192910.66cb9c86.rdunlap@xenotime.net>
 <20060207181809.GA3692@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:40641 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750792AbWBGSSD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2006 13:18:03 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 7 Feb 2006 10:18:01 -0800
In-Reply-To: <20060207181809.GA3692@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Patrick Mochel <mochel@linux.intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-acpi@vger.kernel.org, len.brown@intel.com

On Tue, 7 Feb 2006, Patrick Mochel wrote:

> On Mon, Feb 06, 2006 at 07:29:10PM -0800, Randy.Dunlap wrote:
>
> > Identify which device is not power-manageable to make
> > the message more useful.
>
>
> > --- linux-2615-rc6g4.orig/drivers/acpi/bus.c
> > +++ linux-2615-rc6g4/drivers/acpi/bus.c
> > @@ -198,7 +198,8 @@ int acpi_bus_set_power(acpi_handle handl
> >
> >  	if (!device->flags.power_manageable) {
> >  		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
> > -				  "Device is not power manageable\n"));
> > +				  "Device '%s' is not power manageable\n",
> > +					device->kobj.name));
>
>
> This is good information, but does it have to come in such a scary message?
> It appears that something is wrong with the device, when in fact, it just
> doesn't support an optional capability.
>
> Could we demote the message to e.g. ACPI_DB_INFO?

Sure, fine with me.

-- 
~Randy
