From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v3 12/12] acpi, numa: reuse
 acpi_numa_memory_affinity_init()
Date: Mon, 25 Jan 2016 11:26:43 +0100
Message-ID: <20160125102643.GF24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453541967-3744-13-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 23.01.16 17:39:27, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> After the cleanup for acpi_numa_memory_affinity_init(),
> it can be used for architetures both x86 and arm64, since
> CONFIG_MEMORY_HOTPLUG is not enabled for arm64, so no
> worry about that.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/acpi_numa.c | 42 -------------------------------
>  arch/x86/mm/srat.c            | 54 ----------------------------------------
>  drivers/acpi/numa.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 96 deletions(-)

This one reverts acpi_numa_memory_affinity_init() to the x86 version.
I rather would prefer the arm64 version for the generic code. We could
keep the x86 implementation until x86 maintainers agree to remove them
and use the generic one (implemented in a separate patch).

Doing so we can move acpi_numa_memory_affinity_init() from the
beginning to generic code (used for arm64) and have this last patch to
remove the x86 version.

-Robert
