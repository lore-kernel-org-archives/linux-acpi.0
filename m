From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Tue, 26 Nov 2013 14:32:53 +0530
Message-ID: <529463BD.3070305@linux.vnet.ibm.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37245 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab3KZJER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Nov 2013 04:04:17 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Tue, 26 Nov 2013 19:04:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9C8B63578054
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 20:04:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAQ8kIx940239338
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 19:46:18 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAQ94BMi017165
	for <linux-acpi@vger.kernel.org>; Tue, 26 Nov 2013 20:04:12 +1100
In-Reply-To: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org

On 11/25/2013 12:45 PM, Chen, Gong wrote:
> Usually SCI is employed to handle corrected error, especially
> for memory corrected error but in fact SCI still can be used
> to handle any error like memory uncorrected error even fatal
> error if BIOS enable it. For this kind of situation, it
> should be logged, too.
>
> v2 -> v1: make the event record more precisely
>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/mcheck/mce-apei.c | 10 +++++++---
>   drivers/acpi/apei/ghes.c              |  3 +--
>   2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> index de8b60a..d137ab8 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> @@ -33,6 +33,7 @@
>   #include <linux/acpi.h>
>   #include <linux/cper.h>
>   #include <acpi/apei.h>
> +#include <acpi/ghes.h>
>   #include <asm/mce.h>
>
>   #include "mce-internal.h"
> @@ -41,14 +42,17 @@ void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
>   {
>   	struct mce m;
>
> -	/* Only corrected MC is reported */
> -	if (!corrected || !(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>   		return;
>
>   	mce_setup(&m);
>   	m.bank = 1;
> -	/* Fake a memory read corrected error with unknown channel */
> +	/* Fake a memory read error with unknown channel */
>   	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
> +	if (corrected >= GHES_SEV_RECOVERABLE)
> +		m.status |= MCI_STATUS_UC;
> +	if (corrected >= GHES_SEV_PANIC)
> +		m.status |= MCI_STATUS_PCC;

Hmm... so you only fill up the most basic information from the cper 
record. In the absence of 'S', 'AR' bits, I am not sure how useful this 
is - except for logging the error through /dev/mcelog for legacy users. 
If that is the intent, you have my

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen

>   	m.addr = mem_err->physical_addr;
>   	mce_log(&m);
>   	mce_notify_irq();
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a30bc31..ce3683d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -453,8 +453,7 @@ static void ghes_do_proc(struct ghes *ghes,
>   			ghes_edac_report_mem_error(ghes, sev, mem_err);
>
>   #ifdef CONFIG_X86_MCE
> -			apei_mce_report_mem_error(sev == GHES_SEV_CORRECTED,
> -						  mem_err);
> +			apei_mce_report_mem_error(sev, mem_err);
>   #endif
>   			ghes_handle_memory_failure(gdata, sev);
>   		}
>

