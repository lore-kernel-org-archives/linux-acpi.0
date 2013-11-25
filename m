From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Mon, 25 Nov 2013 11:42:09 +0530
Message-ID: <20131125061209.GB2233@naverao1-tp.in.ibm.com>
References: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
 <1385099825-31765-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:42870 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab3KYGN2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 01:13:28 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Mon, 25 Nov 2013 11:43:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 91873394004E
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 11:43:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAP6DJkU66781260
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 11:43:20 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAP6DMvX030836
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 11:43:22 +0530
Content-Disposition: inline
In-Reply-To: <1385099825-31765-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org

On 2013/11/22 12:57AM, Chen Gong wrote:
> Cleanup the logic for function ghes_handle_memory_failure. Just
> make it simpler and cleaner.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 039c23c..121462b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -413,27 +413,31 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>  {
>  #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>  	unsigned long pfn;
> +	int flags = -1;
>  	int sec_sev = ghes_severity(gdata->error_severity);
>  	struct cper_sec_mem_err *mem_err;
>  	mem_err = (struct cper_sec_mem_err *)(gdata + 1);
>  
> -	if (sec_sev == GHES_SEV_CORRECTED &&
> -	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
> -	    (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)) {
> -		pfn = mem_err->physical_addr >> PAGE_SHIFT;
> -		if (pfn_valid(pfn))
> -			memory_failure_queue(pfn, 0, MF_SOFT_OFFLINE);
> -		else if (printk_ratelimit())
> -			pr_warn(FW_WARN GHES_PFX
> -			"Invalid address in generic error data: %#llx\n",
> -			mem_err->physical_addr);
> -	}
> -	if (sev == GHES_SEV_RECOVERABLE &&
> -	    sec_sev == GHES_SEV_RECOVERABLE &&
> -	    mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS) {
> -		pfn = mem_err->physical_addr >> PAGE_SHIFT;
> -		memory_failure_queue(pfn, 0, 0);
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS))
> +		return;
> +
> +	pfn = mem_err->physical_addr >> PAGE_SHIFT;
> +	if (!pfn_valid(pfn)) {
> +		pr_warn_ratelimited(GHES_PFX

You also need FW_WARN so we point to the right source of the error.

> +		"Invalid address in generic error data: %#llx\n",
> +		mem_err->physical_addr);
> +		return;
>  	}
> +
> +	/* ensure iff events by strictly check can be handled */

Comment can probably be removed - not sure it conveys anything useful.

> +	if (sec_sev == GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags = MF_SOFT_OFFLINE;
> +	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> +		flags = 0;
> +
> +	if (flag != -1)

Wonder if this even compiles! That should be 'flags'.


- Naveen

> +		memory_failure_queue(pfn, 0, flags);
>  #endif
>  }
>  
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

