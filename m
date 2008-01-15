From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible ACPI or PCI involvement?
Date: Tue, 15 Jan 2008 15:02:07 -0700
Message-ID: <200801151502.08102.bjorn.helgaas@hp.com>
References: <20080112205939.GA5291@mhcomputing.net> <200801141702.26914.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:44822 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926AbYAOWBp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jan 2008 17:01:45 -0500
In-Reply-To: <200801141702.26914.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Matthew Hall <mhall@mhcomputing.net>, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>

On Monday 14 January 2008 05:02:26 pm Bjorn Helgaas wrote:
> This looks like the same problem reported here:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=313491
>   https://bugzilla.redhat.com/show_bug.cgi?id=280641
> 
> > PCI: Unable to reserve mem region #6:1000@dfefe000 for device 0000:80:07.0
> > PCI: Unable to reserve mem region #6:1000@dfefd000 for device 0000:80:08.0
> 
> Your 2.6.23.12 /proc/iomem shows this:
> 
>   dfefd000-dfefdfff : 0000:80:08.0
>     dfefd000-dfefd3ff : pnp 00:07
>   dfefe000-dfefefff : 0000:80:07.0
>     dfefe000-dfefe3ff : pnp 00:07
> 
> That means the dfefd000-dfefd3ff range is mentioned both as a
> resource of an ACPI motherboard device (we call it "pnp 00:07"
> above) and as a BAR of the SATA PCI device 0000:80:08.0.

Hmm...  The PNP quirk below is appealingly simple, and Matthew
confirmed that it fixes the problem on his box.

But now I'm a little hesitant.  It relies on the fact that we've
discovered the SATA PCI device before running the quirks for the
PNP system device.  That happens to be the case now, but I don't
think we should rely on it.

The ACPI root bridge device and the PNP system device are both
discovered via the ACPI namespace.  We currently treat them
differently -- one is treated as an ACPI device, and the other
is treated as a PNP device via the PNPACPI backend.  But that
distinction seems artificial to me, and I can imagine that the
ACPI PCI root bridge driver could someday be integrated into PNP.

In that case, the PNP system device might be discovered and have
its quirks run before the PCI root bridge is discovered and scanned.

As much as I'd like to have a generic quirk that would work around
this defect and others like it, I think the safest thing would be
to do something specific to the Supermicro H8DCE BIOS, since all
the reports I've seen are on that box:

    https://bugzilla.redhat.com/show_bug.cgi?id=280641
    https://bugzilla.redhat.com/show_bug.cgi?id=313491
    http://lkml.org/lkml/2008/1/9/449

Matthew, could you collect the dmidecode output?

Bjorn


> Index: w/drivers/pnp/quirks.c
> ===================================================================
> --- w.orig/drivers/pnp/quirks.c	2007-10-11 15:36:12.000000000 -0600
> +++ w/drivers/pnp/quirks.c	2007-10-11 16:35:49.000000000 -0600
> @@ -108,6 +108,47 @@
>  		       "pnp: SB audio device quirk - increasing port range\n");
>  }
>  
> +static int overlaps(resource_size_t start1, resource_size_t end1,
> +		    resource_size_t start2, resource_size_t end2)
> +{
> +	if (start2 <= start1 && start1 < end2)
> +		return 1;
> +	if (start2 <= end1 && end1 < end2)
> +		return 1;
> +	return 0;
> +}
> +
> +
> +#include <linux/pci.h>
> +
> +static void quirk_supermicro_motherboard(struct pnp_dev *dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +	int i, j;
> +
> +	for_each_pci_dev(pdev) {
> +		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM) ||
> +			    pci_resource_len(pdev, i) == 0)
> +				continue;
> +
> +			for (j = 0; j < PNP_MAX_MEM; j++) {
> +				if (!pnp_mem_valid(dev, j) ||
> +				    pnp_mem_len(dev, j) == 0)
> +					continue;
> +
> +				if (overlaps(pnp_mem_start(dev, j),
> +					     pnp_mem_end(dev, j),
> +					     pci_resource_start(pdev, i),
> +					     pci_resource_end(pdev, i))) {
> +					dev_warn(&dev->dev, "mem resource overlaps %s BAR %d, disabling\n", pci_name(pdev), i);
> +					pnp_mem_flags(dev, j) = 0;
> +				}
> +			}
> +		}
> +	}
> +}
> +
>  /*
>   *  PnP Quirks
>   *  Cards or devices that need some tweaking due to incomplete resource info
> @@ -128,6 +169,8 @@
>  	{"CTL0043", quirk_sb16audio_resources},
>  	{"CTL0044", quirk_sb16audio_resources},
>  	{"CTL0045", quirk_sb16audio_resources},
> +	{"PNP0c01", quirk_supermicro_motherboard},
> +	{"PNP0c02", quirk_supermicro_motherboard},
>  	{""}
>  };
>  
> 
> 
> 


