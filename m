From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 04/12] acpi, numa: introduce ACPI_HAS_NUMA_ARCH_FIXUP
Date: Sun, 24 Jan 2016 12:56:03 +0800
Message-ID: <56A45963.40105@linaro.org>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com> <1453541967-3744-5-git-send-email-guohanjun@huawei.com> <20160123102523.GC24726@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34505 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbcAXE4O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Jan 2016 23:56:14 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so65812719pfb.1
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2016 20:56:13 -0800 (PST)
In-Reply-To: <20160123102523.GC24726@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>

On 01/23/2016 06:25 PM, Robert Richter wrote:
> On 23.01.16 17:39:19, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> acpi_numa_arch_fixup() is only used for IA64, x86 introduce a dummy
>> function for it, when we came to a new architecture (such as ARM64),
>> we need to introduce another dummy one to make the code compile.
>>
>> That's pretty boring so introduce ACPI_HAS_NUMA_ARCH_FIXUP and
>> select it for IA64, introduce a stub function for acpi_numa_arch_fixup()
>> then it's pretty clean for x86 and ARM64.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/ia64/Kconfig    | 1 +
>
> I see an implementation of acpi_numa_arch_fixup() only for ia64. Why
> not move it to arch/ia64 then and call it from setup_arch() in
> arch/ia64/kernel/setup.c after acpi_numa_init()? It looks like we
> don't need a generic solution for this. This avoids any kconfig
> handling for this at all.

It's much simpler as you suggested, I will update it in next
version, thank you Robert :)

Hanjun
