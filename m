From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 21/98] ACPICA: Check for non-zero address before being converted to GAS
Date: Thu, 2 Apr 2009 13:59:00 +0200
Message-ID: <200904021359.01408.trenn@suse.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <5e053e77f233342b56fda419d347fd2c958b9849.1238214618.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44077 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbZDBL7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 07:59:04 -0400
In-Reply-To: <5e053e77f233342b56fda419d347fd2c958b9849.1238214618.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 05:30:56 Len Brown wrote:
> From: Lin Ming <ming.m.lin@intel.com>
> 
> Reported-by: FreeBSD community
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
Does this fix something for real?
If yes, please add:
CC: stable@kernel.org
not sure if not.
> ---
>  drivers/acpi/acpica/tbfadt.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbfadt.c 
b/drivers/acpi/acpica/tbfadt.c
> index a8191ef..43fe886 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -618,12 +618,14 @@ static void acpi_tb_setup_fadt_registers(void)
>  		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
>  				 fadt_pm_info_table[i].source);
>  
> -		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
> -					     source64->space_id,
> -					     pm1_register_byte_width,
> -					     source64->address +
> -					     (fadt_pm_info_table[i].
> -					      register_num *
> -					      pm1_register_byte_width));
> +		if (source64->address) {
> +			acpi_tb_init_generic_address(fadt_pm_info_table[i].
> +						     target, source64->space_id,
> +						     pm1_register_byte_width,
> +						     source64->address +
> +						     (fadt_pm_info_table[i].
> +						      register_num *
> +						      pm1_register_byte_width));
> +		}
>  	}
>  }
> -- 

