From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [patch 1/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Date: Thu, 27 Oct 2005 16:06:59 -0700
Message-ID: <20051027160658.A9674@unix-os.sc.intel.com>
References: <20051027192603.488616000@whizzy> <1130441409.5996.24.camel@whizzy>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932681AbVJ0XHQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1130441409.5996.24.camel@whizzy>; from kristen.c.accardi@intel.com on Thu, Oct 27, 2005 at 12:30:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 27, 2005 at 12:30:09PM -0700, Kristen Accardi wrote:
> --- linux-2.6.13.orig/drivers/pci/probe.c
> +++ linux-2.6.13/drivers/pci/probe.c
> @@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
>  	unsigned char irq;
>  
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> +	dev->pin = irq;

pci_read_irq() is not called for PCI bridges, but some of them
may need an interrupt (e.g. for shpchp, pciehp). Did you check
if this patchset broke such bridges? You should call this
function for PCI bridges too.

Rajesh
