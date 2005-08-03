From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
Date: Wed, 03 Aug 2005 10:05:30 +0900
Message-ID: <42F0185A.7060901@jp.fujitsu.com>
References: <200508020955.54844.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508020955.54844.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

>  static void
> -pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
> +pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
>  {
>  	int i = 0;
>  	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -85,13 +85,13 @@
>  			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->irq_resource[i].start =(unsigned long) irq;
> -		res->irq_resource[i].end = (unsigned long) irq;
> +		res->irq_resource[i].start = irq;
> +		res->irq_resource[i].end = irq;
>  	}
>  }

This breaks the following patch that is already included into -mm
tree.

http://sourceforge.net/mailarchive/forum.php?thread_id=7844247&forum_id=6102

I think we need to check if acpi_register_gsi() succeeded or not.

Thanks,
Kenji Kaneshige



Bjorn Helgaas wrote:
> Any objections to the patch below?  I posted it last Wednesday,
> but haven't heard anything.  Once we have this fix, 8250_pnp
> should have sufficient functionality that we can get rid of
> 8250_acpi.
> 
> 
> 
> Use types that match the ACPI resource structures.  Previously
> the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> which corrupts the value.
> 
> This is one of the things that prevents 8250_pnp from working
> on HP ia64 boxes.  After 8250_pnp works, we will be able to
> remove 8250_acpi.c.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> Index: work/drivers/pnp/pnpacpi/rsparser.c
> ===================================================================
> --- work.orig/drivers/pnp/pnpacpi/rsparser.c	2005-07-25 15:04:26.000000000 -0600
> +++ work/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:02:19.000000000 -0600
> @@ -73,7 +73,7 @@
>  }
>  
>  static void
> -pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
> +pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
>  {
>  	int i = 0;
>  	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -85,13 +85,13 @@
>  			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->irq_resource[i].start =(unsigned long) irq;
> -		res->irq_resource[i].end = (unsigned long) irq;
> +		res->irq_resource[i].start = irq;
> +		res->irq_resource[i].end = irq;
>  	}
>  }
>  
>  static void
> -pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
> +pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
>  {
>  	int i = 0;
>  	while (i < PNP_MAX_DMA &&
> @@ -103,14 +103,14 @@
>  			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->dma_resource[i].start =(unsigned long) dma;
> -		res->dma_resource[i].end = (unsigned long) dma;
> +		res->dma_resource[i].start = dma;
> +		res->dma_resource[i].end = dma;
>  	}
>  }
>  
>  static void
>  pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
> -	int io, int len)
> +	u32 io, u32 len)
>  {
>  	int i = 0;
>  	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -122,14 +122,14 @@
>  			res->port_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->port_resource[i].start = (unsigned long) io;
> -		res->port_resource[i].end = (unsigned long)(io + len - 1);
> +		res->port_resource[i].start = io;
> +		res->port_resource[i].end = io + len - 1;
>  	}
>  }
>  
>  static void
>  pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
> -	int mem, int len)
> +	u64 mem, u64 len)
>  {
>  	int i = 0;
>  	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
> @@ -141,8 +141,8 @@
>  			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
>  			return;
>  		}
> -		res->mem_resource[i].start = (unsigned long) mem;
> -		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
> +		res->mem_resource[i].start = mem;
> +		res->mem_resource[i].end = mem + len - 1;
>  	}
>  }
>  
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
