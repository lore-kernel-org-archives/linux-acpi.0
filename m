From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/4] arm64: SPE ACPI enablement
Date: Tue, 26 Mar 2019 17:39:34 -0500
Message-ID: <20190326223938.5365-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-acpi@vger.kernel.org

This patch series enables the Arm Statistical Profiling
Extension (SPE) on ACPI platforms.

This is possible because ACPI 6.3 uses a previously
reserved field in the MADT to store the SPE interrupt
number, similarly to how the normal PMU is described.
If a consistent valid interrupt exists across all the
cores in the system, a platform device is registered.
That then triggers the SPE module, which runs as normal.

This version also adds the ability to parse the PPTT for
IDENTICAL cores. We then use this to sanity check the
single SPE device we create. This creates a bit of a
problem with respect to the specification though. The
specification says that its legal for multiple tree's
to exist in the PPTT. We handle this fine, but what
happens in the case of multiple tree's is that the lack
of a common node with IDENTICAL set forces us to assume
that there are multiple non IDENTICAL cores in the
machine.

Jeremy Linton (4):
  ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
  ACPI/PPTT: Modify node flag detection to find last IDENTICAL
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/acpi/pptt.c           | 82 ++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu_acpi.c   | 69 +++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    | 11 ++++-
 include/linux/acpi.h          |  5 +++
 5 files changed, 157 insertions(+), 13 deletions(-)

-- 
2.20.1
