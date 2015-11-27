From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 0/4] ACPI based NUMA support for ARM64
Date: Fri, 27 Nov 2015 21:28:31 +0800
Message-ID: <56585A7F.3010505@linaro.org>
References: <1447784733-10419-1-git-send-email-gkulkarni@caviumnetworks.com> <56582195.80306@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34508 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbK0N2f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2015 08:28:35 -0500
Received: by padhx2 with SMTP id hx2so115517555pad.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2015 05:28:34 -0800 (PST)
In-Reply-To: <56582195.80306@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shannon Zhao <zhaoshenglong@huawei.com>, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Will.Deacon@arm.com, catalin.marinas@arm.com, grant.likely@linaro.org, leif.lindholm@linaro.org, rfranz@cavium.com, ard.biesheuvel@linaro.org, msalter@redhat.com, robh+dt@kernel.org, steve.capper@linaro.org, al.stone@linaro.org, arnd@arndb.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tn@semihalf.com, rrichter@cavium.com, Prasun.Kapoor@caviumnetworks.com
Cc: gpkulkarni@gmail.com

On 11/27/2015 05:25 PM, Shannon Zhao wrote:
>
>
> On 2015/11/18 2:25, Ganapatrao Kulkarni wrote:
>>   -v2 rebased on arm64-numa v7 patches.
>>   http://www.spinics.net/lists/arm-kernel/msg460813.html
>>
>>   -v1 initial patches from Hanjun Guo
>>
>> Hanjun Guo (4):
>>    acpi, numa: Use pr_fmt() instead of printk
>>    acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
>>    arm64, acpi, numa: NUMA support based on SRAT and SLIT
>>    acpi, numa: Enable ACPI based NUMA on ARM64
>>
>>   arch/arm64/include/asm/acpi.h |   4 +
>>   arch/arm64/kernel/Makefile    |   1 +
>>   arch/arm64/kernel/acpi_numa.c | 215 ++++++++++++++++++++++++++++++++++++++++++
>>   arch/arm64/mm/numa.c          |   7 +-
>>   drivers/acpi/Kconfig          |   4 +-
>>   drivers/acpi/numa.c           | 106 ++++++++++++---------
>>   include/linux/acpi.h          |  15 +++
>>   7 files changed, 306 insertions(+), 46 deletions(-)
>>   create mode 100644 arch/arm64/kernel/acpi_numa.c
>>
>
> I've tested this patch set on QEMU VM and guest prints below log:
>
> ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x0 -> Node 0 cpu 1
> ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1 -> Node 0 cpu 2
> ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x2 -> Node 1 cpu 3
> ACPI: NUMA: SRAT: PXM 1 -> MPIDR 0x3 -> Node 1 cpu 4
> ACPI: NUMA: SRAT: Node 0 PXM 0 [mem 0x40000000-0x5fffffff]
> NUMA: Adding memblock [0x40000000 - 0x5fffffff] on node 0
> ACPI: NUMA: SRAT: Node 1 PXM 1 [mem 0x60000000-0x7fffffff]
> NUMA: Adding memblock [0x60000000 - 0x7fffffff] on node 1
> Initmem setup node 0 [mem 0x40000000-0x5fffffff]
>    NODE_DATA [mem 0x5fffe400-0x5fffffff]
> Initmem setup node 1 [mem 0x60000000-0x7fffffff]
>    NODE_DATA [mem 0x7effd400-0x7effefff]
> Zone ranges:
>    DMA      [mem 0x0000000040000000-0x000000007fffffff]
>    Normal   empty
> Movable zone start for each node
> Early memory node ranges
>    node   0: [mem 0x0000000040000000-0x000000005fffffff]
>    node   1: [mem 0x0000000060000000-0x000000007fffffff]
> Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
> Initmem setup node 1 [mem 0x0000000060000000-0x000000007fffffff]
>
> So, Tested-by: Shannon Zhao <shannon.zhao@linaro.org>

Hi Shannon, thanks a lot!

Thanks
Hanjun
