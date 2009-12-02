From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 2 Dec 2009 12:53:00 -0700
Message-ID: <200912021253.00726.bjorn.helgaas@hp.com>
References: <20091118000427.14214.14043.stgit@bob.kio> <20091118000524.14214.41587.stgit@bob.kio> <20091201231841.GA7903@minyard.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:8629 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbZLBTxL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 14:53:11 -0500
In-Reply-To: <20091201231841.GA7903@minyard.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Tuesday 01 December 2009 04:18:41 pm Corey Minyard wrote:
> On Tue, Nov 17, 2009 at 05:05:24PM -0700, Bjorn Helgaas wrote:
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -2202,7 +2202,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
> >  	int rv;
> >  	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
> >  	struct smi_info *info;
> > -	int first_reg_offset = 0;
> >  
> >  	info = kzalloc(sizeof(*info), GFP_KERNEL);
> >  	if (!info)
> > @@ -2241,9 +2240,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
> >  	info->addr_source_cleanup = ipmi_pci_cleanup;
> >  	info->addr_source_data = pdev;
> >  
> > -	if (pdev->subsystem_vendor == PCI_HP_VENDOR_ID)
> > -		first_reg_offset = 1;
> > -
> >  	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
> >  		info->io_setup = port_setup;
> >  		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> > 
> 
> Unfortunately, the above patch points to some missing code later, not dead
> code.  The patch that follows will set it back to the original function.
> Since no one has noticed, it may be best to remove the code, but as far
> as I know, that HP system is the only one that uses PCI.

That's what we get for sticking an unrelated cleanup in the middle
of this series :-).

> I looked over the other patches in this series and they look fine.

Great, thanks!

> On a PCI update, the offset for HP PCI interfaces to the IPMI controller
> was left off.  Add the offset back in.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> 
> Index: linux-2.6.30/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.30.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux-2.6.30/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2293,7 +2293,7 @@ static int __devinit ipmi_pci_probe(stru
>  		info->io_setup = mem_setup;
>  		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
>  	}
> -	info->io.addr_data = pci_resource_start(pdev, 0);
> +	info->io.addr_data = pci_resource_start(pdev, 0) + first_reg_offset;
>  
>  	info->io.regspacing = DEFAULT_REGSPACING;
>  	info->io.regsize = DEFAULT_REGSPACING;
> 

I guess you're referring to b0defcdbd2b7d?

Prior to that commit, we did this:

	int              fe_rmc = 0;
	...
              if (pci_dev && (pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID))
                      fe_rmc = 1;
	...
        if (! fe_rmc)
              /* Data register starts at base address + 1 in eRMC */
              ++base_addr;
	...
	if (! is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {

Your patch above reverses the sense of this adjustment -- the old code
increments the base for everything *except* HP, while the new code
increments the base for *only* HP.

The original 5-patch series leaves the PCI base address alone.  That's
the same as the old behavior for HP devices, and we verified that it
works on an HP DL380G6 by disabling SMBIOS/SMPI/PNP detection.  (We
also verified that, as you would expect, it did NOT work if we increment
the base address).

Using the address straight from the PCI BAR, we located the IPMI interface
correctly, and we were able to exercise it with ipmitool:

    ipmi message handler version 39.2
    ipmi device interface
    IPMI System Interface driver.
    ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
    PCI: setting IRQ 10 as level-triggered
    ipmi_si 0000:01:04.6: PCI INT A -> Link[LNKF] -> GSI 10 (level, low) -> IRQ 10
    ipmi_si: Trying PCI-specified kcs state machine at mem address 0xf1ef0000, slave address 0x0, irq 10
    IRQ 10/ipmi_si: IRQF_DISABLED is not guaranteed on shared IRQs
      Using irq 10
    ipmi: Found new BMC (man_id: 0x00000b,  prod_id: 0x0000, dev_id: 0x11)
    IPMI kcs interface initialized

    dl380g6a:~# ipmitool sensor
    UID Light        | 0x0        | discrete   | 0x0080| na        | na        | na        | na        | na        | na
    Sys. Health LED  | 0x0        | discrete   | 0x0080| na        | na        | na        | na        | na        | na
    ...

So the question is what to do about non-HP PCI IPMI interfaces.  The
pre-b0defcdbd2b7d code increments the base address, but that's been
gone for several years.  Since we've had no complaints, and we don't
know about any non-HP PCI interfaces, I propose that we just remove
that HP-specific adjustment completely, i.e., use this series as-is.

Bjorn
