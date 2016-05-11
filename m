From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v5 0/5] ACPI / processor_idle: Add ACPI v6.0 LPI support
Date: Wed, 11 May 2016 16:37:37 +0100
Message-ID: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53502 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517AbcEKPhw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 May 2016 11:37:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
method to describe processor idle states. It extends the specification
to allow the expression of idle states like C-states selectable by the
OSPM when a processor goes idle, but may affect more than one processor,
and may affect other system components.

LPI extensions leverages the processor container device(again introduced
in ACPI 6.0) allowing to express which parts of the system are affected
by a given LPI state. It defines the local power states for each node
in a hierarchical processor topology. The OSPM can use _LPI object to
select a local power state for each level of processor hierarchy in the
system. They used to produce a composite power state request that is
presented to the platform by the OSPM.

Since multiple processors affect the idle state for any non-leaf hierarchy
node, coordination of idle state requests between the processors is
required. ACPI supports two different coordination schemes: Platform
coordinated and  OS initiated.

This series aims at providing basic and initial support for platform
coordinated LPI states.

v4[4]->v5:
	- Addressed all the comments from Rafael
	- Added support for retention mode(Prashant)
	- Handled acpi_processor_get_power_info return value correctly(Vikas)
	- Dropped __init from arm_cpuidle_init
	- Merged psci prepartory patch into arm64 lpi support

v3[3]->v4:
	- Dropped the preparatory patches that are merged already
	- Added ARM64 arch specific callback implementations
	- Addressed most of the review comments from Rafael

v2[2]->v3:
        - rebased against v4.4-rc3
        - fixed couple of issues reported by Prashanth and review comments
          from Ashwin

v1[1]->v2[2]:
        - Fixed support for ACPI0010 processor container
        - moved sleep state code out of processor_idle

Code is also available @[5]

Regards,
Sudeep

[1] http://marc.info/?l=linux-acpi&m=143871041601132&w=2
[2] http://marc.info/?l=linux-acpi&m=144241209800788&w=2
[3] http://marc.info/?l=linux-acpi&m=144906557814813&w=2
[4] http://marc.info/?l=linux-acpi&m=146106902731359&w=2
[5] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for_review/arm64_lpi

Sudeep Holla (5):
  ACPI / processor_idle: introduce ACPI_PROCESSOR_CSTATE
  ACPI / processor_idle: Add support for Low Power Idle(LPI) states
  arm64: cpuidle: drop __init section marker to arm_cpuidle_init
  arm64: add support for ACPI Low Power Idle(LPI)
  ACPI : enable ACPI_PROCESSOR_IDLE on ARM64

 arch/arm64/kernel/acpi.c        |  48 ++++
 arch/arm64/kernel/cpuidle.c     |   2 +-
 arch/ia64/Kconfig               |   1 +
 arch/x86/Kconfig                |   1 +
 drivers/acpi/Kconfig            |   6 +-
 drivers/acpi/bus.c              |  14 +-
 drivers/acpi/processor_driver.c |   2 +-
 drivers/acpi/processor_idle.c   | 539 ++++++++++++++++++++++++++++++++++------
 drivers/firmware/psci.c         |  56 +++++
 include/acpi/processor.h        |  26 +-
 include/linux/acpi.h            |   4 +
 11 files changed, 611 insertions(+), 88 deletions(-)

-- 
1.9.1

