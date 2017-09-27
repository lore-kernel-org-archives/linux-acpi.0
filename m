From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 27 Sep 2017 20:05:31 +0800
Message-ID: <8a622b5b-bcf1-3906-a4be-c3c86b0876fe@huawei.com>
References: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
 <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7447 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdI0MGQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 08:06:16 -0400
In-Reply-To: <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, Stephen Boyd <sboyd@codeaurora.org>
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com

Tyler, Stephen

On 2017/9/27 3:23, Tyler Baicar wrote:
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> Tested this functionality using SEA support.
> 
> ++Stephen,
> 
> Something to be aware of, this patch will conflict with https://lkml.org/lkml/2017/9/14/663
> It may make sense to just remove the conditions for the NMI configs as part of this patch or in a series with this patch to avoid merge conflicts.

In your patch, you only remove ACPI_APEI_SEA for the ARCH_HAVE_NMI_SAFE_CMPXCHG, do you need to remove it for the HAVE_NMI?


diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec..8055997 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
@@ -92,6 +93,7 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
+	select HAVE_NMI if ACPI_APEI_SEA
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS

> 
> Thanks,
> Tyler
>> --- 

