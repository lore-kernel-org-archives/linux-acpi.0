From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: Fix resource allocation for fixed hardware in MMIO
Date: Thu, 20 Oct 2005 12:43:18 -0600
Message-ID: <200510201243.18443.bjorn.helgaas@hp.com>
References: <200509161134.24735.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509161134.24735.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 16 September 2005 11:34 am, Bjorn Helgaas wrote:
> ACPI supports fixed hardware (PM_TMR, GPE blocks, etc) in either
> I/O port or MMIO space, but used to always request the regions from
> I/O space, even for MMIO hardware.

<poke> any news on this or the following few patches?  Should I
resend them?

> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> Index: work-vga2/drivers/acpi/motherboard.c
> ===================================================================
> --- work-vga2.orig/drivers/acpi/motherboard.c	2005-09-14 09:28:10.000000000 -0600
> +++ work-vga2/drivers/acpi/motherboard.c	2005-09-14 10:39:05.000000000 -0600
> @@ -123,41 +123,46 @@
>  		},
>  };
>  
> +static void __init acpi_request_region (struct acpi_generic_address *addr,
> +	unsigned int length, char *desc)
> +{
> +	if (!addr->address || !length)
> +		return;
> +
> +	if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> +		request_region(addr->address, length, desc);
> +	else if (addr->address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		request_mem_region(addr->address, length, desc);
> +}
> +
>  static void __init acpi_reserve_resources(void)
>  {
> -	if (acpi_gbl_FADT->xpm1a_evt_blk.address && acpi_gbl_FADT->pm1_evt_len)
> -		request_region(acpi_gbl_FADT->xpm1a_evt_blk.address,
> +	acpi_request_region(&acpi_gbl_FADT->xpm1a_evt_blk,
>  			       acpi_gbl_FADT->pm1_evt_len, "PM1a_EVT_BLK");
>  
> -	if (acpi_gbl_FADT->xpm1b_evt_blk.address && acpi_gbl_FADT->pm1_evt_len)
> -		request_region(acpi_gbl_FADT->xpm1b_evt_blk.address,
> +	acpi_request_region(&acpi_gbl_FADT->xpm1b_evt_blk,
>  			       acpi_gbl_FADT->pm1_evt_len, "PM1b_EVT_BLK");
>  
> -	if (acpi_gbl_FADT->xpm1a_cnt_blk.address && acpi_gbl_FADT->pm1_cnt_len)
> -		request_region(acpi_gbl_FADT->xpm1a_cnt_blk.address,
> +	acpi_request_region(&acpi_gbl_FADT->xpm1a_cnt_blk,
>  			       acpi_gbl_FADT->pm1_cnt_len, "PM1a_CNT_BLK");
>  
> -	if (acpi_gbl_FADT->xpm1b_cnt_blk.address && acpi_gbl_FADT->pm1_cnt_len)
> -		request_region(acpi_gbl_FADT->xpm1b_cnt_blk.address,
> +	acpi_request_region(&acpi_gbl_FADT->xpm1b_cnt_blk,
>  			       acpi_gbl_FADT->pm1_cnt_len, "PM1b_CNT_BLK");
>  
> -	if (acpi_gbl_FADT->xpm_tmr_blk.address && acpi_gbl_FADT->pm_tm_len == 4)
> -		request_region(acpi_gbl_FADT->xpm_tmr_blk.address, 4, "PM_TMR");
> +	if (acpi_gbl_FADT->pm_tm_len == 4)
> +		acpi_request_region(&acpi_gbl_FADT->xpm_tmr_blk, 4, "PM_TMR");
>  
> -	if (acpi_gbl_FADT->xpm2_cnt_blk.address && acpi_gbl_FADT->pm2_cnt_len)
> -		request_region(acpi_gbl_FADT->xpm2_cnt_blk.address,
> +	acpi_request_region(&acpi_gbl_FADT->xpm2_cnt_blk,
>  			       acpi_gbl_FADT->pm2_cnt_len, "PM2_CNT_BLK");
>  
>  	/* Length of GPE blocks must be a non-negative multiple of 2 */
>  
> -	if (acpi_gbl_FADT->xgpe0_blk.address && acpi_gbl_FADT->gpe0_blk_len &&
> -	    !(acpi_gbl_FADT->gpe0_blk_len & 0x1))
> -		request_region(acpi_gbl_FADT->xgpe0_blk.address,
> +	if (!(acpi_gbl_FADT->gpe0_blk_len & 0x1))
> +		acpi_request_region(&acpi_gbl_FADT->xgpe0_blk,
>  			       acpi_gbl_FADT->gpe0_blk_len, "GPE0_BLK");
>  
> -	if (acpi_gbl_FADT->xgpe1_blk.address && acpi_gbl_FADT->gpe1_blk_len &&
> -	    !(acpi_gbl_FADT->gpe1_blk_len & 0x1))
> -		request_region(acpi_gbl_FADT->xgpe1_blk.address,
> +	if (!(acpi_gbl_FADT->gpe1_blk_len & 0x1))
> +		acpi_request_region(&acpi_gbl_FADT->xgpe1_blk,
>  			       acpi_gbl_FADT->gpe1_blk_len, "GPE1_BLK");
>  }
>  
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
