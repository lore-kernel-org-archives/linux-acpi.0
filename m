From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 22/53] PNP: factor pnp_init_resource_table() and pnp_clean_resource_table()
Date: Sat, 19 Apr 2008 00:29:15 +0200
Message-ID: <480920BB.9010506@keyaccess.nl>
References: <20080418204955.342963315@ldl.fc.hp.com> <20080418205051.704761191@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754367AbYDRW0Z@vger.kernel.org>
In-Reply-To: <20080418205051.704761191@ldl.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On 18-04-08 22:50, Bjorn Helgaas wrote:

> Move the common part of pnp_init_resource_table() and
> pnp_clean_resource_table() into a new pnp_init_resource().
> This reduces a little code duplication and will be
> useful later to initialize an individual resource.

This can't be right, can it? :

> +void pnp_init_resource(struct resource *res)
> +{
> +	unsigned long type;
> +
> +	type = res->flags & (IORESOURCE_IO  | IORESOURCE_MEM |
> +			     IORESOURCE_IRQ | IORESOURCE_DMA);
> +
> +	res->name = NULL;
> +	res->flags = type | IORESOURCE_AUTO | IORESOURCE_UNSET;
> +	if (type == IORESOURCE_IRQ || type == IORESOURCE_DMA) {
> +		res->start = -1;
> +		res->end = -1;
> +	} else {
> +		res->start = 0;
> +		res->end = 0;
> +	}
> +}

This depends on the type already being set in res->flags, yet:

>  /**
>   * pnp_init_resources - Resets a resource table to default values.
>   * @table: pointer to the desired resource table
> @@ -209,34 +227,14 @@
>  	struct pnp_resource_table *table = &dev->res;
>  	int idx;
>  
> -	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
> -		table->irq_resource[idx].name = NULL;
> -		table->irq_resource[idx].start = -1;
> -		table->irq_resource[idx].end = -1;
> -		table->irq_resource[idx].flags =
> -		    IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
> -	}
> -	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
> -		table->dma_resource[idx].name = NULL;
> -		table->dma_resource[idx].start = -1;
> -		table->dma_resource[idx].end = -1;
> -		table->dma_resource[idx].flags =
> -		    IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
> -	}
> -	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
> -		table->port_resource[idx].name = NULL;
> -		table->port_resource[idx].start = 0;
> -		table->port_resource[idx].end = 0;
> -		table->port_resource[idx].flags =
> -		    IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
> -	}
> -	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
> -		table->mem_resource[idx].name = NULL;
> -		table->mem_resource[idx].start = 0;
> -		table->mem_resource[idx].end = 0;
> -		table->mem_resource[idx].flags =
> -		    IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
> -	}
> +	for (idx = 0; idx < PNP_MAX_IRQ; idx++)
> +		pnp_init_resource(&table->irq_resource[idx]);
> +	for (idx = 0; idx < PNP_MAX_DMA; idx++)
> +		pnp_init_resource(&table->dma_resource[idx]);
> +	for (idx = 0; idx < PNP_MAX_PORT; idx++)
> +		pnp_init_resource(&table->port_resource[idx]);
> +	for (idx = 0; idx < PNP_MAX_MEM; idx++)
> +		pnp_init_resource(&table->mem_resource[idx]);
>  }

... it's not being set.

Rene.
