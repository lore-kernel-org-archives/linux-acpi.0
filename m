From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 02 Dec 2009 15:34:38 -0600
Message-ID: <4B16DD6E.90101@acm.org>
References: <20091118000427.14214.14043.stgit@bob.kio>
 <20091118000524.14214.41587.stgit@bob.kio>
 <20091201231841.GA7903@minyard.local> <200912021253.00726.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:42986 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbZLBVez (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 16:34:55 -0500
Received: from wf-rch.minyard.local ([173.57.145.237])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KU1006LKNXTM994@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 02 Dec 2009 15:34:42 -0600 (CST)
In-reply-to: <200912021253.00726.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

Bjorn Helgaas wrote:
> I guess you're referring to b0defcdbd2b7d?
>
> Prior to that commit, we did this:
>
> 	int              fe_rmc = 0;
> 	...
>               if (pci_dev && (pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID))
>                       fe_rmc = 1;
> 	...
>         if (! fe_rmc)
>               /* Data register starts at base address + 1 in eRMC */
>               ++base_addr;
> 	...
> 	if (! is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {
>
> Your patch above reverses the sense of this adjustment -- the old code
> increments the base for everything *except* HP, while the new code
> increments the base for *only* HP.
>   
You are correct.

> The original 5-patch series leaves the PCI base address alone.  That's
> the same as the old behavior for HP devices, and we verified that it
> works on an HP DL380G6 by disabling SMBIOS/SMPI/PNP detection.  (We
> also verified that, as you would expect, it did NOT work if we increment
> the base address).
>   
Ok, then your patch is fine as stands.

> Using the address straight from the PCI BAR, we located the IPMI interface
> correctly, and we were able to exercise it with ipmitool:
>
>     ipmi message handler version 39.2
>     ipmi device interface
>     IPMI System Interface driver.
>     ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
>     PCI: setting IRQ 10 as level-triggered
>     ipmi_si 0000:01:04.6: PCI INT A -> Link[LNKF] -> GSI 10 (level, low) -> IRQ 10
>     ipmi_si: Trying PCI-specified kcs state machine at mem address 0xf1ef0000, slave address 0x0, irq 10
>     IRQ 10/ipmi_si: IRQF_DISABLED is not guaranteed on shared IRQs
>       Using irq 10
>     ipmi: Found new BMC (man_id: 0x00000b,  prod_id: 0x0000, dev_id: 0x11)
>     IPMI kcs interface initialized
>
>     dl380g6a:~# ipmitool sensor
>     UID Light        | 0x0        | discrete   | 0x0080| na        | na        | na        | na        | na        | na
>     Sys. Health LED  | 0x0        | discrete   | 0x0080| na        | na        | na        | na        | na        | na
>     ...
>
> So the question is what to do about non-HP PCI IPMI interfaces.  The
> pre-b0defcdbd2b7d code increments the base address, but that's been
> gone for several years.  Since we've had no complaints, and we don't
> know about any non-HP PCI interfaces, I propose that we just remove
> that HP-specific adjustment completely, i.e., use this series as-is.
>   
To tell you the truth, I don't think there are any.  If there are, no 
one has complained.

So I'm happy with your original patch.

-corey
