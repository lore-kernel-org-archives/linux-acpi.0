From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 05/12] ACPI: ARM: exclude calls on ARM platforms, not
 include them on x86
Date: Fri, 22 Nov 2013 06:19:06 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880248C975@SHSMSX101.ccr.corp.intel.com>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
 <1384047382-20623-6-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28593 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3KVGTM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 01:19:12 -0500
In-Reply-To: <1384047382-20623-6-git-send-email-al.stone@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "al.stone@linaro.org" <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of al.stone@linaro.org
> Sent: Sunday, November 10, 2013 9:36 AM
> 
> From: Al Stone <ahs3@redhat.com>
> 
> Corrected #ifdef so that DMI is not used on ARM platforms which are
> currently implementing reduced HW mode.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 6a54dd5..f41949a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -513,11 +513,15 @@ void __init acpi_early_init(void)
> 
>  	acpi_gbl_permanent_mmap = 1;
> 
> +#if !(CONFIG_ARM || CONFIG_ARM64)
>  	/*
> +	 * NB: ARM does not use DMI at present.
> +	 *
>  	 * If the machine falls into the DMI check table,
>  	 * DSDT will be copied to memory
>  	 */
>  	dmi_check_system(dsdt_dmi_table);
> +#endif

I can see dsdt_dmi_table is well protected in this file.  So is that possible to introduce dmi_check_system() stub for non DMI systems?

Thanks
-Lv

> 
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> --
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
