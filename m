From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
Date: Tue, 19 May 2015 10:08:38 -0500
Message-ID: <20150519150838.GQ31666@google.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
 <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35373 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbbESPIm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2015 11:08:42 -0400
Received: by obcus9 with SMTP id us9so14456671obc.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2015 08:08:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

[+cc Michael]

On Thu, May 07, 2015 at 11:12:52AM +0800, Jiang Liu wrote:
> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
> when disabling MSI/MSI-X.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pci/msi.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index c3e7dfcf9ff5..47cf72c669f0 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -686,6 +686,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>  	msi_set_enable(dev, 1);
>  	dev->msi_enabled = 1;
>  
> +	pcibios_free_irq(dev);

>From the recent discussion about disabling MSI at shutdown, I seem to
recall that turning off bus mastering also effectively disables MSI and
causes at least some devices to revert to using INTx.

So with this patch, do we now have a problem in the following scenario?

    pci_enable_msi(dev);	/* now frees INTx IRQ */
    pci_clear_master(dev);
    <device interrupts>		/* uses INTx since bus mastering disabled */

>  	dev->irq = entry->irq;
>  	return 0;
>  }
> @@ -813,9 +814,10 @@ static int msix_capability_init(struct pci_dev *dev,
>  	/* Set MSI-X enabled bits and unmask the function */
>  	pci_intx_for_msi(dev, 0);
>  	dev->msix_enabled = 1;
> -
>  	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  
> +	pcibios_free_irq(dev);
> +
>  	return 0;
>  
>  out_avail:
> @@ -930,6 +932,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
>  
>  	/* Restore dev->irq to its default pin-assertion irq */
>  	dev->irq = desc->msi_attrib.default_irq;
> +	pcibios_alloc_irq(dev);
>  }
>  
>  void pci_disable_msi(struct pci_dev *dev)
> @@ -1030,6 +1033,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>  	pci_intx_for_msi(dev, 1);
>  	dev->msix_enabled = 0;
> +	pcibios_alloc_irq(dev);
>  }
>  
>  void pci_disable_msix(struct pci_dev *dev)
> -- 
> 1.7.10.4
> 
