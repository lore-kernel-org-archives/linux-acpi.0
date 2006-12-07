From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Thu, 7 Dec 2006 09:28:30 -0700
Message-ID: <200612070928.30460.bjorn.helgaas@hp.com>
References: <1165496170.11485.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:46842 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032387AbWLGQ2h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 11:28:37 -0500
In-Reply-To: <1165496170.11485.74.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 07 December 2006 05:56, Zhang Rui wrote:
> 1. ACPI driver model.  
> ACPI driver are made to follow Linux driver model. 
> The main work is to convert the registration interfaces,so that
> ACPI devices are registered with the global device tree. 
>         Note the new .uevent method mark ACPI drivers by PNPID  
> instead of by name. Udev script needs to look for "HWID = " 
> or "COMPTID = " to load the right ACPI driver.

I generally like the direction this is headed.

But I wonder whether it's right to expose the distinction between
PNP devices and ACPI devices to userspace.

Assume you had a box where you can run either PNPBIOS firmware
or ACPI firmware.  Since the box has exactly the same hardware
in either case, it would be nice if everything in /sys and udev
stayed the same. 

Is it possible to extend the PNP model to include ACPI, rather
than introducing a new ACPI model alongside the PNP model?

Bjorn
