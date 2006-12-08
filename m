From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Fri, 8 Dec 2006 05:29:55 -0500
Message-ID: <200612080529.56183.len.brown@intel.com>
References: <1165496170.11485.74.camel@localhost.localdomain> <200612070928.30460.bjorn.helgaas@hp.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42376 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425332AbWLHK0w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Dec 2006 05:26:52 -0500
In-Reply-To: <200612070928.30460.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 07 December 2006 11:28, Bjorn Helgaas wrote:
> On Thursday 07 December 2006 05:56, Zhang Rui wrote:
> > 1. ACPI driver model.  
> > ACPI driver are made to follow Linux driver model. 
> > The main work is to convert the registration interfaces,so that
> > ACPI devices are registered with the global device tree. 
> >         Note the new .uevent method mark ACPI drivers by PNPID  
> > instead of by name. Udev script needs to look for "HWID = " 
> > or "COMPTID = " to load the right ACPI driver.
> 
> I generally like the direction this is headed.
> 
> But I wonder whether it's right to expose the distinction between
> PNP devices and ACPI devices to userspace.
> 
> Assume you had a box where you can run either PNPBIOS firmware
> or ACPI firmware.  Since the box has exactly the same hardware
> in either case, it would be nice if everything in /sys and udev
> stayed the same. 
> 
> Is it possible to extend the PNP model to include ACPI, rather
> than introducing a new ACPI model alongside the PNP model?

Hmmm, well, I thought we were doing well to get ride of ACPI specific
devices names...

The PNPBIOS + ACPI  box will never run both PNPBIOS and ACPI at
the same time.

The academic answer to your question is no -- sysfs can't be identical
whether PNPBIOS or ACPI mode was taken -- because ACPI enumerates
devices that PNPBIOS doesn't know about.  But your question is valid.

My question is where the "cut point is".  At what point do we start
pushing this work upstream, and what parts of it?

-Len
