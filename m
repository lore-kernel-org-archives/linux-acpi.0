From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v4 0/4] arm64/ras: support sea error recovery
Date: Thu, 25 Jan 2018 12:11:09 -0500
Message-ID: <d6fb667b-402c-00df-fc56-1252261fbbe1@codeaurora.org>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>, catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, stephen.boyd@linaro.org, bp@suse.de, julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org, cj.chengjian@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hello Xie,


On 9/27/2017 8:50 AM, Xie XiuQi wrote:
> With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
> are consumed. According to the existing process, errors occurred in the
> kernel, leading to direct panic, if it occurred the user-space, we should
> just kill process.
>
> But there is a class of error, in fact, is not necessary to kill
> process, you can recover and continue to run the process. Such as
> the instruction data corrupted, where the memory page might be
> read-only, which is has not been modified, the disk might have the
> correct data, so you can directly drop the page, ant reload it when
> necessary.
>
> So this patchset is just try to solve such problem: if the error is
> consumed in user-space and the error occurs on a clean page, you can
> directly drop the memory page without killing process.
>
> If the corrupted page is clean, just dropped it and return to user-space
> without side effects. And if corrupted page is dirty, memory_failure()
> will send SIGBUS with code=BUS_MCEERR_AR. While without this patchset,
> do_sea() will just send SIGBUS, so the process was killed in the same place.
>
> Because memory_failure() may sleep, we can not call it directly in SEA
> exception context. So we saved faulting physical address associated with
> a process in the ghes handler and set __TIF_SEA_NOTIFY. When we return
> from SEA exception context and get into do_notify_resume() before the
> process running, we could check it and call memory_failure() to do
> recovery. It's safe, because we are in process context.
>
> In some platform, when SEA triggerred, physical address could be reported
> by memory section or by processor section, so we save address at this two
> place.
For this series - Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Note that this will probably need to be rebased on top of these patches:

https://patchwork.codeaurora.org/patch/415877/
https://patchwork.codeaurora.org/patch/415879/

With that, the first patch should be able to be removed because the above 
patches already define the ARM error types:

+#define CPER_ARM_CACHE_ERROR            0
+#define CPER_ARM_TLB_ERROR            1
+#define CPER_ARM_BUS_ERROR            2
+#define CPER_ARM_VENDOR_ERROR            3

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
