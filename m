From: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Tue, 15 Mar 2005 16:02:20 -0700 (MST)
Message-ID: <Pine.LNX.4.61.0503151543420.23036@montezuma.fsmlabs.com>
References: <20050304234622.63e8a335.akpm@osdl.org>
 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>  <1110559685.4822.15.camel@eeyore>
  <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>  <1110574599.4822.54.camel@eeyore>
  <Pine.LNX.4.62.0503112239580.25254@alpha.polcom.net>  <1110580150.4822.75.camel@eeyore>
  <Pine.LNX.4.62.0503131607330.23588@alpha.polcom.net> <1110915355.5917.41.camel@eeyore>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110915355.5917.41.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

On Tue, 15 Mar 2005, Bjorn Helgaas wrote:

> That seems awfully suspicious to me.  So the following is
> probably safe as far as it goes, but not sufficient for all
> cases.

VIA bridges allow for IRQ routing updates by programming 
PCI_INTERRUPT_LINE, so it is supposed to work even if we do it for all the 
devices, so it appears to be a board/bios specific problem.

> Shaohua, Len, Zwane?  This is related to 
>     http://bugzilla.kernel.org/show_bug.cgi?id=3319
> 
> ===== arch/i386/pci/irq.c 1.55 vs edited =====
> --- 1.55/arch/i386/pci/irq.c	2005-02-07 22:39:15 -07:00
> +++ edited/arch/i386/pci/irq.c	2005-03-15 10:11:44 -07:00
> @@ -1026,7 +1026,6 @@
>  static int pirq_enable_irq(struct pci_dev *dev)
>  {
>  	u8 pin;
> -	extern int via_interrupt_line_quirk;
>  	struct pci_dev *temp_dev;
>  
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> @@ -1081,10 +1080,6 @@
>  		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
>  		       'A' + pin, pci_name(dev), msg);
>  	}
> -	/* VIA bridges use interrupt line for apic/pci steering across
> -	   the V-Link */
> -	else if (via_interrupt_line_quirk)
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
>  	return 0;
>  }
>  
> ===== drivers/acpi/pci_irq.c 1.37 vs edited =====
> --- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
> +++ edited/drivers/acpi/pci_irq.c	2005-03-15 10:10:57 -07:00
> @@ -388,7 +388,6 @@
>  	u8			pin = 0;
>  	int			edge_level = ACPI_LEVEL_SENSITIVE;
>  	int			active_high_low = ACPI_ACTIVE_LOW;
> -	extern int		via_interrupt_line_quirk;
>  
>  	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
>  
> @@ -437,9 +436,6 @@
>  			return_VALUE(0);
>  		}
>   	}
> -
> -	if (via_interrupt_line_quirk)
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
>  
>  	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
>  
> ===== drivers/pci/quirks.c 1.72 vs edited =====
> --- 1.72/drivers/pci/quirks.c	2005-03-10 01:38:25 -07:00
> +++ edited/drivers/pci/quirks.c	2005-03-15 12:15:00 -07:00
> @@ -683,19 +683,23 @@
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
>  
> -/*
> - *	VIA northbridges care about PCI_INTERRUPT_LINE
> - */
> -int via_interrupt_line_quirk;
> -
> -static void __devinit quirk_via_bridge(struct pci_dev *pdev)
> +static void __devinit quirk_via_irqpic(struct pci_dev *dev)
>  {
> -	if(pdev->devfn == 0) {
> -		printk(KERN_INFO "PCI: Via IRQ fixup\n");
> -		via_interrupt_line_quirk = 1;
> +	u8 irq, new_irq = dev->irq & 0xf;
> +
> +	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> +	if (new_irq != irq) {
> +		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
> +			pci_name(dev), irq, new_irq);
> +		udelay(15);
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irqpic);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irqpic);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_6, quirk_via_irqpic);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,   quirk_via_irqpic);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_7,   quirk_via_irqpic);

This looks like it'll only affect the PCI device associated with the 
listed south bridges, which might break systems which relied on the per 
device setting. Your 'debug' patch actually made sense to me, that is, 
moving the PCI_INTERRUPT_LINE fixup at gsi register.

Thanks,
	Zwane


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
