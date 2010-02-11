From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] drivers/acpi/processor_thermal.c
Date: Thu, 11 Feb 2010 12:04:50 +0100
Message-ID: <201002111204.50843.trenn@suse.de>
References: <1265882211.27789.1.camel@ICE-BOX> <201002111124.51070.trenn@suse.de> <Pine.LNX.4.64.1002111150510.2412@ask.diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56878 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306Ab0BKLEx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Feb 2010 06:04:53 -0500
In-Reply-To: <Pine.LNX.4.64.1002111150510.2412@ask.diku.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Janitors <kernel-janitors@vger.kernel.org>

On Thursday 11 February 2010 11:52:20 Julia Lawall wrote:
> On Thu, 11 Feb 2010, Thomas Renninger wrote:
> 
> > Eh, 
> > 
> > what is this for?:
> > static inline void *acpi_driver_data(struct acpi_device *d)
> > {
> >         return d->driver_data;
> > }
...
> 
> A potential patch that gets rid of the uses is below.  I don't have time 
> to look at this in more detail at the moment, but perhaps someone else 
> would like to do so.  The semantic patch (http://coccinelle.lip6.fr) 
> involved is:
> 
> @@
> struct acpi_device *d;
> @@
> 
> - acpi_driver_data(d)
> + d->driver_data
Len, do you mind adding this to your test branch, please.
I can grep over it afterwards (somewhen...) and void out
acpi_driver_data(..)
declaration in acpi_bus.h.

I expect also Darren has to rebase his fixes on top of this
one then.

Thanks,

     Thomas
