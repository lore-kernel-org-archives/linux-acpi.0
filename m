From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: don't complain about vendor-defined resources
Date: 09 Mar 2005 00:09:40 -0500
Message-ID: <1110344980.9332.0.camel@d845pe>
References: <1108160048.31877.75.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108160048.31877.75.camel@eeyore>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Fri, 2005-02-11 at 17:14, Bjorn Helgaas wrote:
> Don't complain about vendor-defined resources, just ignore them.
> And make warning messages a little more consistent.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> ===== drivers/pnp/pnpacpi/rsparser.c 1.2 vs edited =====
> --- 1.2/drivers/pnp/pnpacpi/rsparser.c  2004-10-31 18:21:10 -07:00
> +++ edited/drivers/pnp/pnpacpi/rsparser.c       2005-02-11 12:43:12
> -07:00
> @@ -219,9 +219,10 @@
>                 res->data.address64.min_address_range,
>                 res->data.address64.address_length);
>                 break;
> +       case ACPI_RSTYPE_VENDOR:
> +               break;
>         default:
> -               pnp_warn("PnPACPI: Alloc type : %d not handle",
> -                               res->id);
> +               pnp_warn("PnPACPI: unknown resource type %d",
> res->id);
>                 return AE_ERROR;
>         }
>                        
> @@ -508,7 +509,7 @@
>                 case ACPI_RSTYPE_END_DPF:
>                         return AE_CTRL_TERMINATE;
>                 default:
> -                       pnp_warn("PnPACPI:Option type: %d not handle",
> res->id);
> +                       pnp_warn("PnPACPI: unknown resource type %d",
> res->id);
>                         return AE_ERROR;
>         }
>                        
> @@ -810,7 +811,7 @@
>                         mem ++;
>                         break;
>                 default: /* other type */
> -                       pnp_warn("Invalid type");
> +                       pnp_warn("unknown resource type %d",
> resource->id);
>                         return -EINVAL;
>                 }
>                 resource ++;
> 
> 
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
