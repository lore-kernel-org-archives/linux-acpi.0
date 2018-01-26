From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH v4 0/4] arm64/ras: support sea error recovery
Date: Fri, 26 Jan 2018 10:09:23 +0800
Message-ID: <7a14f1fb-6176-1033-8121-87c872c99c8c@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
 <d6fb667b-402c-00df-fc56-1252261fbbe1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6fb667b-402c-00df-fc56-1252261fbbe1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, stephen.boyd@linaro.org, bp@suse.de, julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org, cj.chengjian@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hi Tyler,

On 2018/1/26 1:11, Tyler Baicar wrote:
> For this series - Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> Note that this will probably need to be rebased on top of these patches:

Thank you for your testing, I'll rebase then.

> 
> https://patchwork.codeaurora.org/patch/415877/
> https://patchwork.codeaurora.org/patch/415879/
> 
> With that, the first patch should be able to be removed because the above patches already define the ARM error types:
> 
> +#define CPER_ARM_CACHE_ERROR            0
> +#define CPER_ARM_TLB_ERROR            1
> +#define CPER_ARM_BUS_ERROR            2
> +#define CPER_ARM_VENDOR_ERROR            3

-- 
Thanks,
Xie XiuQi
