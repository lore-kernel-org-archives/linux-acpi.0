From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC PATCH v1 1/3] arm64/ras: support sea error recovery
Date: Fri, 1 Sep 2017 13:16:48 +0200
Message-ID: <20170901111648.jrb3picf5m4clu3s@pd.tnic>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
 <1504261921-39308-2-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58221 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751811AbdIALQv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Sep 2017 07:16:51 -0400
Content-Disposition: inline
In-Reply-To: <1504261921-39308-2-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, x86@kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com

On Fri, Sep 01, 2017 at 06:31:59PM +0800, Xie XiuQi wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..fa9400d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -52,6 +52,7 @@
>  #include <acpi/ghes.h>
>  #include <acpi/apei.h>
>  #include <asm/tlbflush.h>
> +#include <asm/ras.h>
>  #include <ras/ras_event.h>
>  
>  #include "apei-internal.h"
> @@ -520,6 +521,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  
> +			arm_proc_error_check(ghes, err);
>  			log_arm_hw_error(err);

Wrap those two in a single arm_process_error() which does everything
needed on ARM.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
