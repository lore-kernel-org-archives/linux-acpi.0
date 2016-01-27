From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3 12/12] acpi, numa: reuse
 acpi_numa_memory_affinity_init()
Date: Wed, 27 Jan 2016 14:15:06 +0800
Message-ID: <56A8606A.8080407@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
 <20160125102643.GF24726@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:22463 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcA0GRc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2016 01:17:32 -0500
In-Reply-To: <20160125102643.GF24726@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>

Hi Robert,

On 2016/1/25 18:26, Robert Richter wrote:
> On 23.01.16 17:39:27, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> After the cleanup for acpi_numa_memory_affinity_init(),
>> it can be used for architetures both x86 and arm64, since
>> CONFIG_MEMORY_HOTPLUG is not enabled for arm64, so no
>> worry about that.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi_numa.c | 42 -------------------------------
>>  arch/x86/mm/srat.c            | 54 ----------------------------------------
>>  drivers/acpi/numa.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+), 96 deletions(-)
> This one reverts acpi_numa_memory_affinity_init() to the x86 version.
> I rather would prefer the arm64 version for the generic code. We could
> keep the x86 implementation until x86 maintainers agree to remove them
> and use the generic one (implemented in a separate patch).
>
> Doing so we can move acpi_numa_memory_affinity_init() from the
> beginning to generic code (used for arm64) and have this last patch to
> remove the x86 version.

I think the x86 version is the generic one, all the flags (ACPI_SRAT_MEM_HOT_PLUGGABLE and
etc) are defined in the ACPI spec, x86 just use all the flags because it support such features.
For ARM64, firmware should be careful and represent the true platform configuration to
OS, such as on ARM64, we can't set hotpluggable flag as the ARM64 arch don't support
memory hot-plug yet (also the firmware don't support it too), if firmware do things right,
it will be not worries for the kernel.

Thanks
Hanjun

