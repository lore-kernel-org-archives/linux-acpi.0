From: Adam M Belay <abelay@MIT.EDU>
Subject: Re: [patch 4/4] PNP: dont sort by type in /sys/.../resources
Date: Mon, 19 May 2008 18:42:28 -0400
Message-ID: <20080519184228.2mbxt2meths8cg0c@webmail.mit.edu>
References: <20080515220726.029505668@ldl.fc.hp.com>
	<20080515220755.127620227@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765480AbYESWpE@vger.kernel.org>
In-Reply-To: <20080515220755.127620227@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

Does this fix a bug or is it just a more convenient representation?  
Perhaps, if
we're going to change the interface we could switch to PCI style sysfs
resources.

Thanks,
Adam

Quoting Bjorn Helgaas <bjorn.helgaas@hp.com>:

> Rather than stepping through all IO resources, then stepping through
> all MMIO resources, etc., we can just iterate over the resource list
> once directly.
>
> This can change the order in /sys, e.g.,
>
>    # cat /sys/devices/pnp0/00:07/resources     # OLD
>    state = active
>    io 0x3f8-0x3ff
>    irq 4
>
>    # cat /sys/devices/pnp0/00:07/resources     # NEW
>    state = active
>    irq 4
>    io 0x3f8-0x3ff
>
> The old code artificially sorted resources by type; the new code
> just lists them in the order we read them from the ISAPNP hardware
> or the BIOS.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> Index: work10/drivers/pnp/interface.c
> ===================================================================
> --- work10.orig/drivers/pnp/interface.c	2008-05-05 11:54:26.000000000 -0600
> +++ work10/drivers/pnp/interface.c	2008-05-05 11:59:53.000000000 -0600
> @@ -248,8 +248,9 @@ static ssize_t pnp_show_current_resource
> 					  char *buf)
> {
> 	struct pnp_dev *dev = to_pnp_dev(dmdev);
> +	struct pnp_resource *pnp_res;
> 	struct resource *res;
> -	int i, ret;
> +	int ret;
> 	pnp_info_buffer_t *buffer;
>
> 	if (!dev)
> @@ -262,46 +263,33 @@ static ssize_t pnp_show_current_resource
> 	buffer->buffer = buf;
> 	buffer->curr = buffer->buffer;
>
> -	pnp_printf(buffer, "state = ");
> -	if (dev->active)
> -		pnp_printf(buffer, "active\n");
> -	else
> -		pnp_printf(buffer, "disabled\n");
> -
> -	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
> -		pnp_printf(buffer, "io");
> -		if (res->flags & IORESOURCE_DISABLED)
> -			pnp_printf(buffer, " disabled\n");
> -		else
> -			pnp_printf(buffer, " 0x%llx-0x%llx\n",
> -				   (unsigned long long) res->start,
> -				   (unsigned long long) res->end);
> -	}
> -	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_MEM, i)); i++) {
> -		pnp_printf(buffer, "mem");
> -		if (res->flags & IORESOURCE_DISABLED)
> +	pnp_printf(buffer, "state = %s\n", dev->active ? "active" : "disabled");
> +
> +	list_for_each_entry(pnp_res, &dev->resources, list) {
> +		res = &pnp_res->res;
> +
> +		pnp_printf(buffer, pnp_resource_type_name(res));
> +
> +		if (res->flags & IORESOURCE_DISABLED) {
> 			pnp_printf(buffer, " disabled\n");
> -		else
> -			pnp_printf(buffer, " 0x%llx-0x%llx\n",
> +			continue;
> +		}
> +
> +		switch (pnp_resource_type(res)) {
> +		case IORESOURCE_IO:
> +		case IORESOURCE_MEM:
> +			pnp_printf(buffer, " %#llx-%#llx\n",
> 				   (unsigned long long) res->start,
> 				   (unsigned long long) res->end);
> -	}
> -	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IRQ, i)); i++) {
> -		pnp_printf(buffer, "irq");
> -		if (res->flags & IORESOURCE_DISABLED)
> -			pnp_printf(buffer, " disabled\n");
> -		else
> -			pnp_printf(buffer, " %lld\n",
> -				   (unsigned long long) res->start);
> -	}
> -	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_DMA, i)); i++) {
> -		pnp_printf(buffer, "dma");
> -		if (res->flags & IORESOURCE_DISABLED)
> -			pnp_printf(buffer, " disabled\n");
> -		else
> +			break;
> +		case IORESOURCE_IRQ:
> +		case IORESOURCE_DMA:
> 			pnp_printf(buffer, " %lld\n",
> 				   (unsigned long long) res->start);
> +			break;
> +		}
> 	}
> +
> 	ret = (buffer->curr - buf);
> 	kfree(buffer);
> 	return ret;
>
> --
>
