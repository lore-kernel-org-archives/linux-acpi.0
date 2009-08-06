From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC PATCH V2 2/2] introduce ACPI ALS device driver
Date: Thu, 06 Aug 2009 10:50:58 -0600
Message-ID: <1249577458.457.40.camel@dc7800.home>
References: <1249547500.2670.500.camel@rzhang-dt>
	 <1249571361.457.21.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:26270 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbZHFQvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 12:51:42 -0400
In-Reply-To: <1249571361.457.21.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, Richard Purdie <rpurdie@rpsys.net>, Matthew Wilcox <matthew@wil.cx>, Len Brown <lenb@kernel.org>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>

On Thu, 2009-08-06 at 09:09 -0600, Bjorn Helgaas wrote:

> > +	status = acpi_get_name(als->device->handle, ACPI_FULL_PATHNAME, &name);
> > +	if (ACPI_FAILURE(status)) {
> > +		result = -ENODEV;
> > +		goto end;
> > +	}
> > +
> > +	als->als_sys = als_device_register(&acpi_als_ops, name.pointer, als);
> 
> I don't think we should expose the ACPI pathname of the device here.
> If we really need something in sysfs, I think some kind of link to the
> underlying device would be better.

What I mean to say here is that if we need a connection to the ACPI
pathname (and we might, especially for debugging), I think the
connection should be between "ACPI0008:00" and the pathname, not between
something in /sys/class/als/... and the pathname.

Then you could have a link under /sys/class/als/... to the ACPI0008:00
stuff.

Bjorn


