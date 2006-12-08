From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Fri, 08 Dec 2006 09:34:03 +0800
Message-ID: <1165541643.1369.2.camel@sli10-conroe.sh.intel.com>
References: <1165496170.11485.74.camel@localhost.localdomain>
	 <200612070928.30460.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3468 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164362AbWLHBfi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 20:35:38 -0500
In-Reply-To: <200612070928.30460.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Fri, 2006-12-08 at 00:28 +0800, Bjorn Helgaas wrote:
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
Don't think it's easy. ACPI driver uses some acpi helpers and handle
some ACPI specific event like notification/gpe ...

Thanks,
Shaohua
