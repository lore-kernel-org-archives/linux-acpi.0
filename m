From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error injection
Date: Thu, 16 May 2013 13:05:03 +0200
Message-ID: <20130516110503.GB31373@pd.tnic>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56899 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab3EPLFL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 May 2013 07:05:11 -0400
Content-Disposition: inline
In-Reply-To: <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Wed, May 15, 2013 at 10:29:06PM -0400, Chen Gong wrote:
> When param1 is enabled in EINJ but not assigned with a valid
> value, sometimes it will cause the error like below:
> 
> APEI: Can not request [mem 0x7aaa7000-0x7aaa7007] for APEI EINJ Trigger
> registers
> 
> It is because some firmware will access target address specified in
> param1 to trigger the error when injecting memory error. This will
> cause resource conflict with regular memory. So It must be removed
> from trigger table resources, but uncorrected param1/param2
> combination will stop this action. Add extra check to avoid
> happening this error.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/einj.c |   29 +++++++++++++++++++++++++----
>  kernel/resource.c        |    1 +
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 8d457b5..015546e 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -32,6 +32,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
> +#include <linux/mm.h>
>  #include <acpi/acpi.h>
>  
>  #include "apei-internal.h"
> @@ -511,11 +512,31 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
>  /* Inject the specified hardware error */
>  static int einj_error_inject(u32 type, u64 param1, u64 param2)
>  {
> -	int rc;
> +	int rc = 0;
> +	unsigned long pfn;
> +	bool checkparam = false;
> +	u64 param2_mask = 0xfffffffffffff000;
>  
> -	mutex_lock(&einj_mutex);
> -	rc = __einj_error_inject(type, param1, param2);
> -	mutex_unlock(&einj_mutex);
> +	/* ensure param1/param2 existed & injection is memory related */
> +	if (param_extension || acpi5) {
> +		if (type & 0x80000000) {

		if (type & BIT(31)) {

better readable.

even better if you define what bit 31 is

#define INJ_TYPE BIT(31)

> +			if (vendor_flags == SETWA_FLAGS_MEM)
> +				checkparam = true;
> +		} else if (type & 0x38)

what is 0x38? Also a macro define with readable name pls.

> +			checkparam = true;
> +	}
> +	if (checkparam) {
> +		pfn = PFN_DOWN(param1 & param2);
> +		if (!page_is_ram(pfn) ||
> +			((param2 & param2_mask) != param2_mask))

Hmm, shouldn't this be:

			(param2 & param2_mask) != param2

?

> +			rc = -EINVAL;
> +	}

This checkparam variable looks unneeded to me:

		if (type & INJ_TYPE) {
			if (vendor_flags == SETWA_FLAGS_MEM || type & 0x38) {
				...

Ok, I went and rewrote the function to show you what I mean. I've
also reversed the logic to flatten the indentation level (completely
untested, of course):

static int einj_error_inject(u32 type, u64 param1, u64 param2)
{
       int rc;
       unsigned long pfn;

       /* ensure param1/param2 exist and we inject to real memory */
       if (!(param_extension || acpi5))
	       goto inject;

	if (type & INJ_TYPE)
		if (vendor_flags != SETWA_FLAGS_MEM)
			goto inject;
	else if (!(type & THREE_BIT_MASK))
		goto inject;

	pfn = PFN_DOWN(param1 & param2);
	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != param2))
		return -EINVAL;

 inject:
	mutex_lock(&einj_mutex);
	rc = __einj_error_inject(type, param1, param2);
	mutex_unlock(&einj_mutex);

	return rc;
}

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
