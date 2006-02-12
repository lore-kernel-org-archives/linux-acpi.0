From: "Bob Picco" <bob.picco@hp.com>
Subject: Re: [PATCH] HPET: handle multiple ACPI EXTENDED_IRQ resources
Date: Sun, 12 Feb 2006 17:55:28 -0500
Message-ID: <20060212225528.GC21804@localhost>
References: <200602071650.27379.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:63667 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751059AbWBLW5c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Feb 2006 17:57:32 -0500
Content-Disposition: inline
In-Reply-To: <200602071650.27379.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Bob Picco <robert.picco@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>

Bjorn Helgaas wrote:	[Tue Feb 07 2006, 06:50:27PM EST]
> When the _CRS for a single HPET contains multiple EXTENDED_IRQ
> resources, we overwrote hdp->hd_nirqs every time we found one.
> 
> So the driver worked when all the IRQs were described in a
> single EXTENDED_IRQ resource, but failed when multiple resources
> were used.  (Strictly speaking, I think the latter is actually
> more correct, but both styles have been used.)
> 
> Someday we should remove all the ACPI stuff from hpet.c and use
> PNP driver registration instead.  But currently PNP_MAX_IRQ is 2,
> and HPETs often have more IRQs.  Hint, hint, Adam :-)
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work-mm4/drivers/char/hpet.c
> ===================================================================
> --- work-mm4.orig/drivers/char/hpet.c	2006-02-07 16:18:46.000000000 -0700
> +++ work-mm4/drivers/char/hpet.c	2006-02-07 16:29:00.000000000 -0700
> @@ -953,22 +953,18 @@
>  		}
>  	} else if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
>  		struct acpi_resource_extended_irq *irqp;
> -		int i;
> +		int i, irq;
>  
>  		irqp = &res->data.extended_irq;
>  
> -		if (irqp->interrupt_count > 0) {
> -			hdp->hd_nirqs = irqp->interrupt_count;
> +		for (i = 0; i < irqp->interrupt_count; i++) {
> +			irq = acpi_register_gsi(irqp->interrupts[i],
> +				      irqp->triggering, irqp->polarity);
> +			if (irq < 0)
> +				return AE_ERROR;
>  
> -			for (i = 0; i < hdp->hd_nirqs; i++) {
> -				int rc =
> -				    acpi_register_gsi(irqp->interrupts[i],
> -						      irqp->triggering,
> -						      irqp->polarity);
> -				if (rc < 0)
> -					return AE_ERROR;
> -				hdp->hd_irq[i] = rc;
> -			}
> +			hdp->hd_irq[hdp->hd_nirqs] = irq;
> +			hdp->hd_nirqs++;
>  		}
>  	}
>  

Acked-by: Bob Picco <bob.picco@hp.com>

