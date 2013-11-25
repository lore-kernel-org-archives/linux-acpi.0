From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Mon, 25 Nov 2013 11:38:23 +0530
Message-ID: <20131125060823.GA2233@naverao1-tp.in.ibm.com>
References: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:37815 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab3KYGKD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 01:10:03 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Mon, 25 Nov 2013 16:10:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id C92EE2CE8052
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 17:09:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAP5ptv69634170
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 16:51:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAP69u9q012387
	for <linux-acpi@vger.kernel.org>; Mon, 25 Nov 2013 17:09:57 +1100
Content-Disposition: inline
In-Reply-To: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org

On 2013/11/22 12:57AM, Chen Gong wrote:
> Usually SCI is employed to handle corrected error, especially
> for memory corrected error but in fact SCI still can be used
> to handle any error like memory uncorrected error if BIOS
> enable it. For this situation, memory uncorrected error
> should be logged as corrected error does, too.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  arch/x86/include/asm/mce.h            | 3 +--
>  arch/x86/kernel/cpu/mcheck/mce-apei.c | 6 ++----
>  drivers/acpi/apei/ghes.c              | 3 +--
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cbe6b9e..94b263f 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -244,7 +244,6 @@ static inline void mcheck_intel_therm_init(void) { }
>   */
>  
>  struct cper_sec_mem_err;
> -extern void apei_mce_report_mem_error(int corrected,
> -				      struct cper_sec_mem_err *mem_err);
> +extern void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err);
>  
>  #endif /* _ASM_X86_MCE_H */
> diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> index cd8b166..f09da48 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> @@ -37,13 +37,11 @@
>  
>  #include "mce-internal.h"
>  
> -void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
> +void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
>  
> -	/* Only corrected MC is reported */
> -	if (!corrected || !(mem_err->validation_bits &
> -				CPER_MEM_VALID_PHYSICAL_ADDRESS))
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS))
>  		return;

This won't be enough. Further down, you'll see that all memory errors
get logged as corrected errors due to the hardcoded MCE status. A lot
more work will be needed if we have to log GHES errors through mcelog
properly.

- Naveen

>  
>  	mce_setup(&m);
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8ec37bb..039c23c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -453,8 +453,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			ghes_edac_report_mem_error(ghes, sev, mem_err);
>  
>  #ifdef CONFIG_X86_MCE
> -			apei_mce_report_mem_error(sev == GHES_SEV_CORRECTED,
> -						  mem_err);
> +			apei_mce_report_mem_error(mem_err);
>  #endif
>  			ghes_handle_memory_failure(gdata, sev);
>  		}
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

