From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
Date: Sat, 25 Sep 2004 14:18:48 +0300 (EAT)
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>, tony.luck@intel.com, acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 25 Sep 2004, Zwane Mwaikambo wrote:

> Kenji Kaneshige wrote:
> 
> >     - Changed acpi_pci_irq_disable() to leave 'dev->irq' as it
> >       is. Clearing 'dev->irq' by some magic constant
> >       (e.g. PCI_UNDEFINED_IRQ) is TBD.
> 
> This may not be safe with CONFIG_PCI_MSI, you may want to verify against 
> that if you already haven't.
> 
> > +acpi_unregister_gsi (unsigned int irq)
> > +{
> > +}
> > +EXPORT_SYMBOL(acpi_unregister_gsi);
> 
> Why not just make these static inlines in header files? Since you're on 
> this, how about making irq_desc and friends dynamic too?

Sorry, i broke Cc.
