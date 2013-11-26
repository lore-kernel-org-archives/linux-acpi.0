From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Tue, 26 Nov 2013 14:34:51 +0530
Message-ID: <52946433.1010403@linux.vnet.ibm.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com> <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:50251 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3KZJGT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Nov 2013 04:06:19 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 26 Nov 2013 19:06:17 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 483AA2CE8052
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 20:06:15 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAQ962UY4063596
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 20:06:02 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAQ96DiP020441
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 20:06:14 +1100
In-Reply-To: <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org

On 11/25/2013 12:45 PM, Chen, Gong wrote:
> Cleanup the logic for function ghes_handle_memory_failure. Just
> make it simpler and cleaner.
>
> v2 -> v1: fix a compile error & some minor changes.
>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
>   drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ce3683d..46766ef 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -413,27 +413,31 @@ static void ghes_handle_memory_failure(struct acpi_generic_data *gdata, int sev)
>   {
>   #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>   	unsigned long pfn;
> +	int flags = -1;
>   	int sec_sev = ghes_severity(gdata->error_severity);
>   	struct cper_sec_mem_err *mem_err;
>   	mem_err = (struct cper_sec_mem_err *)(gdata + 1);
>
> -	if (sec_sev == GHES_SEV_CORRECTED &&
> -	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
> -	    (mem_err->validation_bits & CPER_MEM_VALID_PA)) {
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
> -	    mem_err->validation_bits & CPER_MEM_VALID_PA) {
> -		pfn = mem_err->physical_addr >> PAGE_SHIFT;
> -		memory_failure_queue(pfn, 0, 0);
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +		return;
> +
> +	pfn = mem_err->physical_addr >> PAGE_SHIFT;
> +	if (!pfn_valid(pfn)) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX
> +		"Invalid address in generic error data: %#llx\n",
> +		mem_err->physical_addr);
> +		return;
>   	}
> +
> +	/* iff following two events can be handled properly by now */
> +	if (sec_sev == GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags = MF_SOFT_OFFLINE;
> +	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> +		flags = 0;
> +
> +	if (flags != -1)
> +		memory_failure_queue(pfn, 0, flags);
>   #endif
>   }
>

