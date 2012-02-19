From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [v2 PATCH 1/2] ACPI, APEI, EINJ, new parameter to control trigger
 action
Date: Mon, 20 Feb 2012 00:21:14 +0800
Message-ID: <4F41217A.7040909@gmail.com>
References: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39216 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab2BSQV1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Feb 2012 11:21:27 -0500
Received: by pbcun15 with SMTP id un15so5467929pbc.19
        for <linux-acpi@vger.kernel.org>; Sun, 19 Feb 2012 08:21:27 -0800 (PST)
In-Reply-To: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On 02/17/2012 03:11 PM, Chen Gong wrote:
> Some APEI firmware implementation will access injected address
> specified in param1 to trigger the error when injecting memory
> error, which means if one SRAR error is injected, the crash
> always happens because it is executed in kernel context. This
> new parameter can disable trigger action and control is taken
> over by the user. In this way, an SRAR error can happen in user
> context instead of crashing the system. This function is highly
> depended on BIOS implementation so please ensure you know the
> BIOS trigger procedure before you enable this switch.
> 
> v2:
>   notrigger should be created together with param1/param2
> 
> Tested-by: Tony Luck <tony.luck@lintel.com>
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/einj.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 4ca087d..afc380c 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -74,6 +74,8 @@ struct vendor_error_type_extension {
>  	u8	reserved[3];
>  };
>  
> +static u32 notrigger;
> +
>  static u32 vendor_flags;
>  static struct debugfs_blob_wrapper vendor_blob;
>  static char vendor_dev[64];
> @@ -496,9 +498,11 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
>  	if (rc)
>  		return rc;
>  	trigger_paddr = apei_exec_ctx_get_output(&ctx);
> -	rc = __einj_error_trigger(trigger_paddr, type, param1, param2);
> -	if (rc)
> -		return rc;
> +	if (notrigger == 0) {
> +		rc = __einj_error_trigger(trigger_paddr, type, param1, param2);
> +		if (rc)
> +			return rc;
> +	}
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
Suggest to reset the notrigger flag to default value (zero) after the injection
operation, so the test script doesn't need to explicitly set the notrigger flag
for each injection operation and it's backward compatible with existing scripts.
It would be better to reset the param2 too for the same reason.

>  
>  	return rc;
> @@ -700,6 +704,11 @@ static int __init einj_init(void)
>  					    einj_debug_dir, &error_param2);
>  		if (!fentry)
>  			goto err_unmap;
> +
> +		fentry = debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
> +					    einj_debug_dir, &notrigger);
> +		if (!fentry)
> +			goto err_unmap;
>  	}
>  
>  	if (vendor_dev[0]) {

