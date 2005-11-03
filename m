From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Date: Wed, 02 Nov 2005 16:14:55 -0800
Message-ID: <1130976895.8321.35.camel@whizzy>
References: <20051027192603.488616000@whizzy>
	 <1130441409.5996.24.camel@whizzy>
	 <20051027160658.A9674@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030217AbVKCAPG@vger.kernel.org>
In-Reply-To: <20051027160658.A9674@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-10-27 at 16:06 -0700, Rajesh Shah wrote:
> On Thu, Oct 27, 2005 at 12:30:09PM -0700, Kristen Accardi wrote:
> > --- linux-2.6.13.orig/drivers/pci/probe.c
> > +++ linux-2.6.13/drivers/pci/probe.c
> > @@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
> >  	unsigned char irq;
> >  
> >  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> > +	dev->pin = irq;
> 
> pci_read_irq() is not called for PCI bridges, but some of them
> may need an interrupt (e.g. for shpchp, pciehp). Did you check
> if this patchset broke such bridges? You should call this
> function for PCI bridges too.
> 
> Rajesh
> 

You are correct, this does break for bridges on certain architectures.
Some archs seem to re-read the interrupt pin value in
pcibios_enable_device, but others don't.  Adding pci_read_irq to the
bridge patch in this function does seem to fix the problem, and arch
specific code can still override this.  I'll send a new patch for that.
thanks,
Kristen
