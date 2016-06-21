From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 00/11] Enable PMUs in ACPI systems
Date: Tue, 21 Jun 2016 12:11:38 -0500
Message-ID: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Lorenzo.Pieralisi@arm.com, mlangsdorf@redhat.com, alexander.shishkin@linux.intel.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, acme@kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, Steve.Capper@arm.com
List-Id: linux-acpi@vger.kernel.org

v6:
Added cpu affinity sysfs entry
Converted pmu_types array, to linked list
Restrict use of the armv8_pmu_probe_table to ACPI systems
Rename MADT parsing routines in smp.c
Convert sysfs PMU name to use index rather than partnum
Remove pr_devel statements
Other Minor cleanups
Add Partial Ack-by Will Deacon

v5:
Remove list of CPU types for ACPI systems. We now match a generic
event list, and use the PMCIED[01] to select events which exist on
the given PMU. This avoids the need to update the kernel every time
a new CPU is released.
Update the maintainers list to include the new file.

v4:
Correct build issues with ARM (!ARM64) kernels.
Add ThunderX to list of PMU types.

v3:
Enable ARM performance monitoring units on ACPI/arm64 machines.

This patch expands and reworks the patches published by Mark Salter
in order to clean up a few of the previous review comments, as well as
add support for newer CPUs and big/little configurations.


Jeremy Linton (9):
  arm64: pmu: Probe default hw/cache counters
  arm64: pmu: Hoist pmu platform device name
  arm64: Rename the common MADT parse routine
  arm: arm64: Add routine to determine cpuid of other cpus
  arm: arm64: pmu: Assign platform PMU CPU affinity
  arm64: pmu: Provide cpumask attribute for PMU
  arm64: pmu: Add routines for detecting differing PMU types in the
    system
  arm64: pmu: Enable multiple PMUs in an ACPI system
  MAINTAINERS: Tweak ARM PMU maintainers

Mark Salter (2):
  arm64: pmu: add fallback probe table
  arm64: pmu: Add support for probing with ACPI

 MAINTAINERS                      |   3 +-
 arch/arm/include/asm/cputype.h   |   6 +-
 arch/arm64/include/asm/cputype.h |   4 +
 arch/arm64/kernel/perf_event.c   |  79 ++++++++++++++-
 arch/arm64/kernel/smp.c          |  18 ++--
 drivers/perf/Kconfig             |   4 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/arm_pmu.c           |  60 +++++++++---
 drivers/perf/arm_pmu_acpi.c      | 207 +++++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h     |  12 +++
 10 files changed, 370 insertions(+), 24 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_acpi.c

-- 
2.5.5
