From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 27/28] PNP: avoid legacy IDE IRQs
Date: Wed, 18 Jun 2008 23:34:06 +0200
Message-ID: <200806182334.07049.bzolnier@gmail.com>
References: <20080617225823.045233728@ldl.fc.hp.com> <20080617225913.281681169@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:37557 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYFRVeB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2008 17:34:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so256765ywe.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2008 14:34:00 -0700 (PDT)
In-Reply-To: <20080617225913.281681169@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>


Hi,

On Wednesday 18 June 2008, Bjorn Helgaas wrote:
> If an IDE controller is in compatibility mode, it expects to use
> IRQs 14 and 15, so PNP should avoid them.
> 
> This patch should resolve this problem report:
>   parallel driver grabs IRQ14 preventing legacy SFF ATA controller from working
>   https://bugzilla.novell.com/show_bug.cgi?id=375836
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work14/drivers/pnp/resource.c
> ===================================================================
> --- work14.orig/drivers/pnp/resource.c	2008-06-17 15:52:36.000000000 -0600
> +++ work14/drivers/pnp/resource.c	2008-06-17 16:14:18.000000000 -0600
> @@ -17,6 +17,7 @@
>  #include <linux/pci.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> +#include <linux/libata.h>

this include is for libata only AFAIK

[ I added Jeff to cc: ]

>  #include <linux/pnp.h>
>  #include "base.h"
> @@ -286,6 +287,61 @@ static irqreturn_t pnp_test_handler(int 
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_PCI
> +static int pci_dev_uses_irq(struct pnp_dev *pnp, struct pci_dev *pci,
> +			    unsigned int irq)
> +{
> +	u32 class;
> +	u8 progif;
> +
> +	if (pci->irq == irq) {
> +		dev_dbg(&pnp->dev, "device %s using irq %d\n",
> +			pci_name(pci), irq);
> +		return 1;
> +	}
> +
> +	/*
> +	 * See pci_setup_device() and ata_pci_sff_activate_host() for
> +	 * similar IDE legacy detection.
> +	 */
> +	pci_read_config_dword(pci, PCI_CLASS_REVISION, &class);
> +	class >>= 8;		/* discard revision ID */
> +	progif = class & 0xff;
> +	class >>= 8;
> +
> +	if (class == PCI_CLASS_STORAGE_IDE) {
> +		/*
> +		 * Unless both channels are native-PCI mode only,
> +		 * treat the compatibility IRQs as busy.
> +		 */
> +		if ((progif & 0x5) != 0x5)
> +			if (ATA_PRIMARY_IRQ(pci) == irq ||
> +			    ATA_SECONDARY_IRQ(pci) == irq) {

ATA_*_IRQ are libata specific (+ it looks like they should be removed),
please use pci_get_legacy_ide_irq(dev, channel) instead.

Thanks,
Bart
