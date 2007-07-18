From: <Jordan_Hargrave@Dell.com>
Subject: RE: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Wed, 18 Jul 2007 11:49:58 -0500
Message-ID: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE53C94B@ausx3mpc102.aus.amer.dell.com>
References: <200702102327.28312.lenb@kernel.org> <200702152103.54960.bjorn.helgaas@hp.com> <45D53DDE.5000300@acm.org> <200702192131.52947.bjorn.helgaas@hp.com> <45DA9931.80605@linux.intel.com> <45DAFDD8.909@acm.org> <20070225215922.GA28931@lists.us.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:63583 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758068AbXGRQuA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 12:50:00 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt_Domsch@dell.com, minyard@acm.org
Cc: alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org, bjorn.helgaas@hp.com

I've done some more investigating on this and found why this works in RHEL5 but not other releases (RHEL4/SLES9/SLES10).

The acpi motherboard driver is claiming all devices with _HID or _CID of PNP0C01.  Our BIOS declares the IPI0001 with a _CID of PNP0C01, so the acpi motherboard driver normally claims it.  When the IPMI driver loads it can't find the IPI0001 device as it is already claimed.

In RHEL5 there was a change made to the acpi motherboard driver to not attach if any of the _CRS values are not I/O ports.  Well, the end-of-list (79 00) marker is passed into the _CRS iterator, so the acpi motherboard driver is not attaching for ANY PNP0C01 devices.  This is why the IPI0001 driver is allowed to attach in RHEL5 but none of the other OS's.

Technically the only reason it is working in RHEL5 is due to the bug of the motherboard driver not attaching.

So using acpi_bus_register_driver looks like it won't work as a general solution.
I'm investigating walking the whole namespace to detect the IPI0001 device.

--jordan hargrave
Dell Enterprise Linux Engineering



-----Original Message-----
From: Hargrave, Jordan
Sent: Mon 2/26/2007 12:30 PM
To: Matt Domsch; Corey Minyard
Cc: Alexey Starikovskiy; linux-acpi@vger.kernel.org; openipmi; Len Brown; Bjorn Helgaas
Subject: RE: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
 
Corey,

  Here is the patch (RHEL5 base code) I've been testing that detects the ACPI namespace object.
The IPI0001 device doesn't contain the register spacing directly; it has a _CRS resource object that
(for KCS) has two I/O port entries.  I save the first port in io.addr_data, then calculate the register spacing based on subtracting the 2nd port address and the 1st.

I'm thinking of changing the register spacing to using an array of port/memory addresses to make calculating interface addresses more generic.

eg.
static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
{
        unsigned int addr = io->addr_data;

        return inb(addr + (offset * io->regspacing));
}

would become something like:
static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
{
        unsigned int addr = io->addr_data[offset];

        return inb(addr);
}

--jordan hargrave
Dell Enterprise Linux Engineering



-----Original Message-----
From: Matt Domsch [mailto:Matt_Domsch@dell.com]
Sent: Sun 2/25/2007 3:59 PM
To: Corey Minyard; Hargrave, Jordan
Cc: Alexey Starikovskiy; linux-acpi@vger.kernel.org; openipmi; Len Brown; Bjorn Helgaas
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
 
On Tue, Feb 20, 2007 at 07:55:36AM -0600, Corey Minyard wrote:
> Alexey Starikovskiy wrote:
> > Bjorn Helgaas wrote:
> >> On Thursday 15 February 2007 22:15, Corey Minyard wrote:
> >>  
> >>> Bjorn Helgaas wrote:
> >>>    
> >>>> On Saturday 10 February 2007 21:27, Len Brown wrote:
> >>>>        
> >>>>> acpi_find_bmc() appears to be searching for multiple SPMI tables 
> >>>>> in the RSDT and running
> >>>>> try_init_acpi() on each of them
> >>>>> until it doesn't find any more.
> >>>>>             
> >>>> I can't remember why we look at the SPMI table(s) rather than
> >>>> registering a normal ACPI (or even PNP) driver.  Unless we
> >>>> need to poke the BMC very early, wouldn't it be better to
> >>>> rely on the device description in the namespace?
> >>>>         
> >>> For some strange reason the normal ACPI information does not
> >>> have all the information needed by the driver.  It doesn't have
> >>> register size or spacing information.
> >>>     
> >>
> >> I guess that would be a defect in the way ACPI is being used,
> >> wouldn't it?  A PNP ID should define the device programming
> >> model, including things like register size and spacing.  It
> >> sounds like somebody didn't define a new PNP ID when he should
> >> have.  I wonder whether it's worth trying to fix this.
> >>
> >>   
> > Yes, it is considered an ACPI fault. Could you please describe in 
> > detail, which registers miss the information? And probably your 
> > acpidump will help as well.
> I don't have a machine with an ACPI description of the BMC.  I'll copy 
> the mailing list to see if anyone has an ACPI-described BMC.
> 
> I don't know that much about ACPI, so maybe that information is 
> described somehow in a way the IPMI spec doesn't talk about directly, 
> like in the _CRS object.

Let me copy my teammate Jordan Hargrave in on this, as he's been
working with our BIOS team to implement discovery through an IPI0
object in the namespace, and thinks he can derive the register spacing
and interrupt assignment (if any).

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com




