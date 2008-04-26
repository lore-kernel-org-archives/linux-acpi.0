From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 26/54] PNP: factor pnp_init_resource_table() and pnp_clean_resource_table()
Date: Sat, 26 Apr 2008 23:33:16 +0200
Message-ID: <48139F9C.6050609@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183929.396758295@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:32829 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbYDZVdK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 17:33:10 -0400
In-Reply-To: <20080425183929.396758295@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 25-04-08 20:38, Bjorn Helgaas wrote:

>  void pnp_init_resources(struct pnp_dev *dev)
>  {
> -	struct pnp_resource_table *table = &dev->res;
> +	struct resource *res;
>  	int idx;
>  
>  	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
> -		table->irq_resource[idx].name = NULL;
> -		table->irq_resource[idx].start = -1;
> -		table->irq_resource[idx].end = -1;
> -		table->irq_resource[idx].flags =
> -		    IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
> +		res = &dev->res.irq_resource[idx];
> +		res->flags = IORESOURCE_IRQ;

ACK as commented earlier but pnp_clean_resource_table would seem to want the 
same treatment of setting the type, at least to again guarantee current 
behaviour:

>  static void pnp_clean_resource_table(struct pnp_dev *dev)
>  {
> -	struct pnp_resource_table *res = &dev->res;
> +	struct resource *res;
>  	int idx;
>  
>  	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
> -		if (!(res->irq_resource[idx].flags & IORESOURCE_AUTO))
> -			continue;
> -		res->irq_resource[idx].start = -1;
> -		res->irq_resource[idx].end = -1;
> -		res->irq_resource[idx].flags =
> -		    IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
> +		res = &dev->res.irq_resource[idx];
> +		if (res->flags & IORESOURCE_AUTO)
> +			pnp_init_resource(res);
>  	}

Rene.
