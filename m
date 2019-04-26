From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/5] arm64: SPE ACPI enablement
Date: Fri, 26 Apr 2019 17:03:04 -0500
Message-ID: <20190426220309.55654-1-jeremy.linton@arm.com>
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
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net, linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, john.garry@huawei.com, lenb@kernel.org
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

v1->v2: Wrap the code which creates the SPE device in
    a new CONFIG_ARM_SPE_ACPI ifdef.
	Move arm,spe-v1 device name into common header file
	Some comment/case sensitivity/function name changes.

Jeremy Linton (5):
  ACPI/PPTT: Trivial, Modify the case of CPU
  ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
  ACPI/PPTT: Modify node flag detection to find last IDENTICAL
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |   3 +
 drivers/acpi/pptt.c           | 130 +++++++++++++++++++++++++---------
 drivers/perf/Kconfig          |   5 ++
 drivers/perf/arm_pmu_acpi.c   |  76 ++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    |  12 +++-
 include/linux/acpi.h          |   5 ++
 include/linux/perf/arm_pmu.h  |   2 +
 7 files changed, 196 insertions(+), 37 deletions(-)

-- 
2.20.1
