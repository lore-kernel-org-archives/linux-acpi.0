From: Len Brown <lenb@kernel.org>
Subject: Re: controlling ACPI IRQ routing
Date: Sat, 5 Jan 2008 00:48:29 -0500
Message-ID: <200801050048.29908.lenb@kernel.org>
References: <47742083.5060903@howardsilvan.com> <1198821979.20548.9.camel@sli10-desk.sh.intel.com> <477C269B.4080407@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43926 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbYAEFsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 00:48:45 -0500
In-Reply-To: <477C269B.4080407@howardsilvan.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Wednesday 02 January 2008 19:04, Lee Howard wrote:
> Shaohua Li wrote:
> > Currently vector is allocated when pci_enable_device is called. So which
> > vector is allocated depends on how many drivers already called the
> > routine. The first vector is 0x31, later higher priority (higher) vector
> > will be allocated. In latest kernel, a vector of a irq could be variable
> > when irq affinity is set, so it's much complex. There is no existing
> > method to reserve a vector for a device.
> 
> The systems I've been using are all single-processor AMD x86 or x86_64 
> systems.  So I doubt that IRQ affinity applies in these cases.
> 
> I've made the driver get "preloaded" through mkinitrd/initrd on 
> boot-time, but that doesn't seem to make a difference in device performance.
> 
> Is it possible to see in 'dmesg' output which vector was allocated to 
> which IRQ/device?

no.  the vectors are chosesn when the IOAPIC is programmed
and today, linux just prints out the GSI (which is the IOAPIC pin #)
and the IRQ, which is a corresponding data structure.

>> In IOAPIC mode, interrupt priority isn't related with the pin (in your
>> case, irq 16 or 19), but the vector of the pin.

>Just to help my understanding a bit... does the Linux ACPI driver 
>determine which IRQ numbers are given to certain devices?  And if so, 
>how does it make those assignments?

Yes.  It uses a PCI Routing Table (_PRT) in the DSDT.
The _PRT may either hard-code the relationship between
PCI interrupt pin (as is typical in IOAPIC mode)
or use a PCI Interrupt Link Device (as is common in PIC mode)
that can be programmed to a number of differet input pins.

This is used to minimize interrupt line sharing.
But on your system, you have no interrupt line sharing,
so that isnt' the problem.

-Len
