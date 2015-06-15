From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] apei/erst-dbg: Define pr_fmt macro to avoid the
 duplication of ERST_DBG_PFX
Date: Mon, 15 Jun 2015 07:42:33 -0700
Message-ID: <1434379353.2507.52.camel@perches.com>
References: <1434362250-217135-1-git-send-email-long.wanglong@huawei.com>
	 <1434362250-217135-2-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434362250-217135-2-git-send-email-long.wanglong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Long <long.wanglong@huawei.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, tony.luck@intel.com, bp@suse.de, gong.chen@linux.intel.com, tomasz.nowicki@linaro.org, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, wanglong@laoqinren.net, peifeiyue@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Mon, 2015-06-15 at 09:57 +0000, Wang Long wrote:
> Define pr_fmt macro with {ERST DBG: } prefix, then remove all use
> of ERST_DBG_PFXin the pr_* functions.
[]
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
[]
> @@ -31,7 +31,8 @@
>  
>  #include "apei-internal.h"
>  
> -#define ERST_DBG_PFX			"ERST DBG: "
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ERST DBG: " fmt

Moving this #define above the first #include is what's
generally done and doesn't require an #undef
