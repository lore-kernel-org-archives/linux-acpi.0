From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 06/12] ACPI: ensure several FADT fields are only used in
 HW reduced mode
Date: Fri, 22 Nov 2013 06:05:34 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880248C923@SHSMSX101.ccr.corp.intel.com>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
 <1384047382-20623-7-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1335 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3KVGFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 01:05:39 -0500
In-Reply-To: <1384047382-20623-7-git-send-email-al.stone@linaro.org>
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
> In acpi_os_terminate(), it was assumed that several FADT entries were
> mapped into memory.  For HW reduced mode, that will not be the case.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/osl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 017b85c..075545e 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1812,10 +1812,12 @@ acpi_status acpi_os_terminate(void)
>  						 acpi_irq_handler);
>  	}
> 
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> -	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +	if (!acpi_gbl_reduced_hardware) {
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
> +		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> +	}
> 
>  	destroy_workqueue(kacpid_wq);
>  	destroy_workqueue(kacpi_notify_wq);

Is that possible to make stubs for acpi_os_map_generic_address and acpi_os_unmap_generic_address when CONFIG_ACPI_REDUCED_HARDWARE is enabled?
So that this patch and some logics in the PATCH 07 can be removed.

Thanks
-Lv

> --
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
