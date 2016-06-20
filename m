From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 0/8] arm64: pmu: Detect multiple PMU types in an ACPI
 system
Date: Mon, 20 Jun 2016 17:47:48 +0100
Message-ID: <87eg7r6c3v.fsf@e105922-lin.cambridge.arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com> (Jeremy
 Linton's message of "Thu, 9 Jun 2016 17:23:25 -0500")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-acpi@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, acme@kernel.org, mlangsdorf@redhat.com, alexander.shishkin@linux.intel.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> v5:
> Remove list of CPU types for ACPI systems. We now match a generic
> event list, and use the PMCIED[01] to select events which exist on
> the given PMU. This avoids the need to update the kernel every-time
> a new CPU is released.
> Update the maintainers list to include the new file.
>
> v4:
> Correct build issues with ARM (!ARM64) kernels.
> Add ThunderX to list of PMU types.
>
> v3:
> Enable ARM performance monitoring units on ACPI/arm64 machines.
>
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>

Hi Jeremy,

I have a few comments on the individual patches but overall I found the
patches a bit confusing due to introduction of functionality and then
changing them in later patches.

IMHO, some patch re-organisation to make the series better as a whole will
help in review (even though it may lead to more invasive changes
to Mark's patches).

Thanks,
Punit


> Jeremy Linton (6):
>   arm64: pmu: Probe default hw/cache counters
>   arm: arm64: Add routine to determine cpuid of other cpus
>   arm: arm64: pmu: Assign platform PMU CPU affinity
>   arm64: pmu: Add routines for detecting differing PMU types in the
>   arm64: pmu: Enable multiple PMUs in an ACPI system
>   MAINTAINERS: Tweak ARM PMU maintainers
>
> Mark Salter (2):
>   arm64: pmu: add fallback probe table
>   arm64: pmu: Add support for probing with ACPI
>
>  MAINTAINERS                      |   3 +-
>  arch/arm/include/asm/cputype.h   |   6 +-
>  arch/arm64/include/asm/cputype.h |   4 +
>  arch/arm64/kernel/perf_event.c   |  51 ++++++++-
>  arch/arm64/kernel/smp.c          |   5 +
>  drivers/perf/Kconfig             |   4 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/arm_pmu.c           |  57 +++++++++--
>  drivers/perf/arm_pmu_acpi.c      | 216 +++++++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h     |  10 ++
>  10 files changed, 341 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/perf/arm_pmu_acpi.c
