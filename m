From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Thu, 29 Apr 2010 09:56:26 -0600
Message-ID: <201004290956.26922.bjorn.helgaas@hp.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:9289 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab0D3RMM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2010 13:12:12 -0400
In-Reply-To: <1272505354.9950.16.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, tony.luck@intel.com, linux-acpi <linux-acpi@vger.kernel.org>

On Wednesday 28 April 2010 07:42:34 pm Lin Ming wrote:
> From: Lin Ming <ming.m.lin@intel.com>
> Subject: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
> 
> Tony Luck saw a lot of warning messages on ia64:
> WARNING: at drivers/firmware/dmi_scan.c:423 dmi_matches+0x70/0x160()
> dmi check: not initialized yet.
> 
> This is caused by commit aa2110c(ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT).
> DMI is not initialized yet in acpi_early_init.
> This patch checks the availability of DMI to avoid the warnings.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/bus.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 49af19b..047de07 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -847,8 +847,10 @@ void __init acpi_early_init(void)
>  	/*
>  	 * If the machine falls into the DMI check table,
>  	 * DSDT will be copied to memory
> +	 * Only check x86, it's too early to check dmi for ia64

I can't remember why this is different between x86 and ia64.  If
it's reasonable to do, I think it'd be nicer to make DMI available
earlier on ia64 so we don't have to add checks like this.  Did you
investigate that?

Bjorn

>  	 */
> -	dmi_check_system(dsdt_dmi_table);
> +	if (dmi_available)
> +		dmi_check_system(dsdt_dmi_table);
>  
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


