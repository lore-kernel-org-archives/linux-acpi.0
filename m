From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC PATCH v1 2/3] apei: add ghes param for
 arch_apei_report_mem_error
Date: Fri, 1 Sep 2017 13:15:26 +0200
Message-ID: <20170901111526.plpslddmrjerkxtv@pd.tnic>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
 <1504261921-39308-3-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58047 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751811AbdIALPf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Sep 2017 07:15:35 -0400
Content-Disposition: inline
In-Reply-To: <1504261921-39308-3-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, x86@kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com

n Fri, Sep 01, 2017 at 06:32:00PM +0800, Xie XiuQi wrote:
> Add ghes param for arch_apei_report_mem_error, with which
> we could do more arch-specific processing.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  arch/x86/kernel/acpi/apei.c   | 2 +-
>  drivers/acpi/apei/apei-base.c | 4 +++-
>  drivers/acpi/apei/ghes.c      | 2 +-
>  include/acpi/apei.h           | 4 +++-
>  include/acpi/ghes.h           | 3 ++-
>  5 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> index ea3046e..1bf1c9b 100644
> --- a/arch/x86/kernel/acpi/apei.c
> +++ b/arch/x86/kernel/acpi/apei.c
> @@ -46,7 +46,7 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
>  	return 1;
>  }
>  
> -void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
> +void arch_apei_report_mem_error(struct ghes *ghes, int sev, struct cper_sec_mem_err *mem_err)
>  {
>  #ifdef CONFIG_X86_MCE
>  	apei_mce_report_mem_error(sev, mem_err);
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index da370e1..317169b 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -38,6 +38,8 @@
>  #include <linux/debugfs.h>
>  #include <asm/unaligned.h>
>  
> +#include <acpi/ghes.h>
> +
>  #include "apei-internal.h"
>  
>  #define APEI_PFX "APEI: "
> @@ -770,7 +772,7 @@ int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
>  }
>  EXPORT_SYMBOL_GPL(arch_apei_enable_cmcff);
>  
> -void __weak arch_apei_report_mem_error(int sev,
> +void __weak arch_apei_report_mem_error(struct ghes *ghes, int sev,
>  				       struct cper_sec_mem_err *mem_err)
>  {
>  }
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fa9400d..996d16c4 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -483,7 +483,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			ghes_edac_report_mem_error(ghes, sev, mem_err);
>  
> -			arch_apei_report_mem_error(sev, mem_err);
> +			arch_apei_report_mem_error(ghes, sev, mem_err);

And next time you want to pass something else, you'll have to touch all
those files again...

Instead, make that a notifier to which consumers register and define
a separate struct mem_err or ghes_err or whatnot and populate it with
cper_sec_mem_err data and whatever else is needed by the consumers.
Instead of passing that struct ghes * which consumers don't need to
know.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
