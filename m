From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 41/54] PNP: remove pnp_resource_table references from
 resource decoders
Date: Sun, 27 Apr 2008 00:28:13 +0200
Message-ID: <4813AC7D.9000006@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183932.457629051@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:49553 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683AbYDZW2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 18:28:09 -0400
In-Reply-To: <20080425183932.457629051@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 25-04-08 20:38, Bjorn Helgaas wrote:

> Index: work10/drivers/pnp/pnpacpi/rsparser.c
> ===================================================================
> --- work10.orig/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:15:08.000000000 -0600
> +++ work10/drivers/pnp/pnpacpi/rsparser.c	2008-04-25 11:15:09.000000000 -0600
> @@ -82,8 +82,8 @@
>  						u32 gsi, int triggering,
>  						int polarity, int shareable)
>  {
> -	struct pnp_resource_table *res = dev->res;
> -	int i = 0;
> +	struct resource *res;
> +	int i;
>  	int irq;
>  	int p, t;
>  	static unsigned char warned;
> @@ -91,9 +91,11 @@
>  	if (!valid_IRQ(gsi))
>  		return;
>  
> -	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
> -	       i < PNP_MAX_IRQ)
> -		i++;
> +	for (i = 0; i < PNP_MAX_IRQ; i++) {
> +		res = &dev->res->irq_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

Another possible user of pnp_resource_valid.

> +	for (i = 0; i < PNP_MAX_DMA; i++) {
> +		res = &dev->res->dma_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> +	for (i = 0; i < PNP_MAX_PORT; i++) {
> +		res = &dev->res->port_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> +	for (i = 0; i < PNP_MAX_MEM; i++) {
> +		res = &dev->res->mem_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> Index: work10/drivers/pnp/pnpbios/rsparser.c
> ===================================================================
> --- work10.orig/drivers/pnp/pnpbios/rsparser.c	2008-04-25 11:15:08.000000000 -0600
> +++ work10/drivers/pnp/pnpbios/rsparser.c	2008-04-25 11:15:09.000000000 -0600
> @@ -56,80 +56,90 @@
>  
>  static void pnpbios_parse_allocated_irqresource(struct pnp_dev *dev, int irq)
>  {
> -	struct pnp_resource_table *res = dev->res;
> -	int i = 0;
> +	struct resource *res;
> +	int i;
> +
> +	for (i = 0; i < PNP_MAX_IRQ; i++) {
> +		res = &dev->res->irq_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> +	for (i = 0; i < PNP_MAX_DMA; i++) {
> +		res = &dev->res->dma_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> +	for (i = 0; i < PNP_MAX_PORT; i++) {
> +		res = &dev->res->port_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

> +	for (i = 0; i < PNP_MAX_MEM; i++) {
> +		res = &dev->res->mem_resource[i];
> +		if (res->flags & IORESOURCE_UNSET)
> +			break;
> +	}

.

Rene

