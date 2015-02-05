From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 0/6] ACPI / EC: Fix GPE handling related races.
Date: Thu,  5 Feb 2015 16:24:29 +0800
Message-ID: <cover.1423123818.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26433 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733AbbBEIYv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Feb 2015 03:24:51 -0500
In-Reply-To: <cover.1403060601.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset is based on ACPICA 20150204 release.

This patchset introduces a GPE raw handler mode and switches EC driver into
a GPE raw handler mode user.

The EC driver is a kind of the hardware driver that wants to control the
interrupt handling itself (for example, implementing the storming
prevention or the burst mode). But it has no mean to do so using the EC
firmware provided commands. The EC driver has to rely on the GPE APIs to
achieve the interrupt controlling.
Due to the shortcoming of the current ACPICA GPE APIs, the EC driver is
using the GPE APIs in a racy way. We then can see many issues between the
ACPICA internal GPE controlling and the EC driver's GPE handling. Such
races prevents us from correctly root causing other EC issues. This
patchset fixes the GPE related race issues by holding the EC state machine
lock for the whole EC GPE handling process:
  Lock(EC)        <- EC lock
  if (STS==1)     <- GPE API
    STS=0         <- GPE API
  EC_SC read      <- EC GPE handler
  EC_SC handled   <- EC GPE handler
  Unlock(EC)      <- EC lock

We can see several GPE handling stuffs improved by applying this patchset
because of EC/GPE races fixed:
1. Some platforms may suffer from GPE loss, which is because GPE is handled
   in the polling mode with its GPE indication left uncleared, the
   uncleared indication may stop further GPEs from being triggered.
   This patchset can make sure the indication has been cleared before
   handling, thus it may have fixed the potential root cause of the bugs
   that were originally fixed by the MSI quirk.
2. We originally can see many no-op EC GPE handler invocations, which is
   becaue GPE can be handled in the task context after the GPE IRQ handler
   is invoked, then when the driver goes back to the handler, there is no
   indication left for it to handle.
   This patchset can reduce the number of no-op EC GPE handler invocations
   to almost 0 by fixing the races, thus it may have fixed the potential
   root cause of the issues that were originally fixed by the storming
   condition threshold quirk.

Lv Zheng (6):
  ACPICA: Events: Introduce ACPI_GPE_DISPATCH_RAW_HANDLER to fix 2
    issues for the current GPE APIs.
  ACPICA: Events: Introduce acpi_set_gpe()/acpi_finish_gpe() to reduce
    divergences.
  ACPICA: Events: Enable APIs to allow interrupt/polling adaptive
    request based GPE handling model.
  ACPI / EC: Fix several GPE handling issues by deploying
    ACPI_GPE_DISPATCH_RAW_HANDLER mode.
  ACPI / EC: Reduce ec_poll() by referencing the last register access
    timestamp.
  ACPI / EC: Update revision due to raw handler mode.

 drivers/acpi/acpica/evgpe.c     |   52 +++++++++++++++---
 drivers/acpi/acpica/evgpeblk.c  |    2 +
 drivers/acpi/acpica/evgpeinit.c |    6 +-
 drivers/acpi/acpica/evgpeutil.c |    6 +-
 drivers/acpi/acpica/evxface.c   |  115 +++++++++++++++++++++++++++++++++++----
 drivers/acpi/acpica/evxfgpe.c   |  114 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/ec.c               |  104 ++++++++++++++++++++++++++++++-----
 include/acpi/acpixf.h           |    8 +++
 include/acpi/actypes.h          |   11 ++--
 9 files changed, 375 insertions(+), 43 deletions(-)

-- 
1.7.10

