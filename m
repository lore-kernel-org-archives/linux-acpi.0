From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/2] acpi: apei: remove the unused dead-code for SEA
 notification type
Date: Fri, 13 Oct 2017 15:21:35 +0200
Message-ID: <20171013132135.ahumafo2grbkiqss@pd.tnic>
References: <1506602498-25752-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52513 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753394AbdJMNVo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Oct 2017 09:21:44 -0400
Content-Disposition: inline
In-Reply-To: <1506602498-25752-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

On Thu, Sep 28, 2017 at 08:41:37PM +0800, Dongjiu Geng wrote:
> In current code logic, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called. Hence, remove the unnecessary
> handling when CONFIG_ACPI_APEI_SEA is not defined.
> 
> In the firmware-first RAS solution, the IPA fault address recorded
> by hpfar_el2 may be UNKNOWN, and also current code does not use it,
> so remove it.

...

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..c15a08d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -813,7 +813,6 @@ static struct notifier_block ghes_notifier_hed = {
>  	.notifier_call = ghes_notify_hed,
>  };
>  
> -#ifdef CONFIG_ACPI_APEI_SEA
>  static LIST_HEAD(ghes_sea);

But now those get compiled in on x86 where there's no SEA and where we
don't need them. So no, I don't think this patch is correct.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
