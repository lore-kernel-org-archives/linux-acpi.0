From: David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
Date: Thu, 11 Sep 2003 11:02:41 -0400 (EDT)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0309111101580.1410-100000@sol.cobite.com>
References: <p734qzlkcn3.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <p734qzlkcn3.fsf-G4cFiJVhTpkYitT5tn2FcQ@public.gmane.org>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org> writes:
> 
> > at acpi_pci_link_calc_penalties
> 
> Try this (untested) patch

Sorry for the delay.  This patch fixes my problems.  I can now boot 
without any command line options.

David


> 
> (2.6 version untested, I tested a similar patch on the 2.4 backport of
> ACPI):
> 
> --- linux-2.6.0test5-work/arch/i386/pci/acpi.c-o	2003-08-23 13:03:09.000000000 +0200
> +++ linux-2.6.0test5-work/arch/i386/pci/acpi.c	2003-09-09 21:01:49.000000000 +0200
> @@ -15,10 +15,11 @@
>  
>  static int __init pci_acpi_init(void)
>  {
> +	extern int acpi_disabled;
>  	if (pcibios_scanned)
>  		return 0;
>  
> -	if (!(pci_probe & PCI_NO_ACPI_ROUTING)) {
> +	if (!(pci_probe & PCI_NO_ACPI_ROUTING) && !acpi_disabled) {
>  		if (!acpi_pci_irq_init()) {
>  			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
>  			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'\n");
> 
> 
> -Andi
> 

-- 
/==============================\
| David Mansfield              |
| lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org           |
\==============================/
