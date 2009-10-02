From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: EC: Don't parse DSDT for EC early init on
 Compal
Date: Fri, 02 Oct 2009 22:41:59 +0200
Message-ID: <1254516119.19065.1.camel@maxim-laptop>
References: <20091002162133.14126.81642.stgit@thinkpad>
	 <20091002162140.14126.5393.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:62504 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757931AbZJBUmB (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 2 Oct 2009 16:42:01 -0400
Received: by fg-out-1718.google.com with SMTP id 22so6476fge.1
        for <Linux-acpi@vger.kernel.org>; Fri, 02 Oct 2009 13:42:04 -0700 (PDT)
In-Reply-To: <20091002162140.14126.5393.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Fri, 2009-10-02 at 20:21 +0400, Alexey Starikovskiy wrote: 
> Compal DSDT breaks if scanned early, while we need early scan
> for almost all ASUS machines. Safest workaround seems to be to
> continue do an early scan for all machines, but this Compal model.

Its not an option, to do a scan without calling _any_ function (even
_sta) to locate the EC, and then call _sta on the path ec was found to
verify?

Best regards,
Maxim Levitsky

> 
> References: http://bugzilla.kernel.org/show_bug.cgi?id=14086
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 3fcb913..2c790b5 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -120,6 +120,7 @@ static struct acpi_ec {
>  
>  static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
>  static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
> +static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
>  
>  /* --------------------------------------------------------------------------
>                               Transaction Management
> @@ -900,6 +901,13 @@ static const struct acpi_device_id ec_device_ids[] = {
>  	{"", 0},
>  };
>  
> +/* Some BIOS do not survive early DSDT scan, skip it */
> +static int ec_skip_dsdt_scan(const struct dmi_system_id *id)
> +{
> +	EC_FLAGS_SKIP_DSDT_SCAN = 1;
> +	return 0;
> +}
> +
>  /* ASUStek often supplies us with broken ECDT, validate it */
>  static int ec_validate_ecdt(const struct dmi_system_id *id)
>  {
> @@ -917,6 +925,10 @@ static int ec_flag_msi(const struct dmi_system_id *id)
>  
>  static struct dmi_system_id __initdata ec_dmi_table[] = {
>  	{
> +	ec_skip_dsdt_scan, "Compal JFL92", {
> +	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
> +	DMI_MATCH(DMI_BOARD_NAME, "JFL92") }, NULL},
> +	{
>  	ec_flag_msi, "MSI hardware", {
>  	DMI_MATCH(DMI_BIOS_VENDOR, "Micro-Star"),
>  	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-Star") }, NULL},
> @@ -959,6 +971,9 @@ int __init acpi_ec_ecdt_probe(void)
>  	/* fall through */
>  	}
>  
> +	if (EC_FLAGS_SKIP_DSDT_SCAN)
> +		return -ENODEV;
> +
>  	/* This workaround is needed only on some broken machines,
>  	 * which require early EC, but fail to provide ECDT */
>  	printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


