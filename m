From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: ACPI/PCI _PS3 slot power management
Date: Thu, 11 May 2006 10:11:04 +0800
Message-ID: <1147313464.2760.130.camel@sli10-desk.sh.intel.com>
References: <200605101708.57416.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:133 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751405AbWEKCMU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 May 2006 22:12:20 -0400
In-Reply-To: <200605101708.57416.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Nguyen, Tom L" <tom.l.nguyen@intel.com>

On Thu, 2006-05-11 at 07:08 +0800, Bjorn Helgaas wrote:
> pci_set_power_state() is a per-PCI-function interface, just like 
> most of the other PCI interfaces.  On ACPI systems, it ultimately 
> calls acpi_bus_set_power(), which evaluates the _PSx method of the 
> ACPI function object.
> 
> This:
> http://www.microsoft.com/whdc/system/pnppwr/hotadd/hotplugpci.mspx 
> suggests that a system that supports ACPI hotplug and power control 
> should supply an ACPI device for each PCI function that might exist 
> in the slot.  The _PSx methods exist under one or more of these
> devices 
> (the document above suggests that it's under each device; the HP
> systems 
> I've seen have _PSx only under the device for function 0).
> 
> In any case, the _PSx methods control power to the whole *slot*, not 
> just a single function.  The result is that calling
> pci_set_power_state() 
> on one PCI function turns off power to the entire slot, even though
> there 
> may be other independent functions that shouldn't be turned off.
> 
> Do we need to be smarter in acpi_pci_set_power_state(), and collect 
> up all the PCI per-function power requests, and only pass those 
> down to acpi_bus_set_power() when all the functions agree?
> 
> Other than the Microsoft document above, I haven't seen a good spec 
> that clarifies this issue.
The purpose of the callback is to allow architecture handle specific
power management staff. But I didn't realize the _PSx method is for the
whole slot. I checked some DSDT, you might be right. If this really
breaks a system, please fix it.

Thanks,
Shaohua
