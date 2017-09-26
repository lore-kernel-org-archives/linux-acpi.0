From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPI / EC: EC regression fixes related to EC event stuck
Date: Tue, 26 Sep 2017 16:53:57 +0800
Message-ID: <cover.1506414565.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There are 2 regressions reported on bugzilla.
 Link: https://bugzilla.kernel.org/show_bug.cgi?id=196847 [#1]
 Link: https://bugzilla.kernel.org/show_bug.cgi?id=196833 [#2]
It looks they are related to the modification against the timing of
acpi_ec_enable_event() invocation, but they are all due to different root
causes.

For link 1, its root cause is: we rely on acpi_ec_suspend/resume() to
control the timing of EC event handling enablement, but ECDT is not an
ACPI device, thus the PM hooks are not invoked for it.
For link 2, reporter seems to favor a fix that can fix both of the
problems:
1. EC event can stuck if there is no triggering source.
2. Post-resume enabling of EC event handling may be too late.
But actually the report is only against problem 1 which is known to have a
very low and accepted reproduce ratio.

For problem 2, it should has a sympton related to the driver resume order
rather than EC event stuck. And its fix should be acpi.ec_freeze_events=Y
related. Note acpi.ec_freeze_events=Y is a feature we need to keep for
now as:
1. It's reasonable for EC driver to act as an agent for EC event
   handling while EC transaction is handled by ACPI core handler, thus
   1.1. unbind/suspend means suspending EC event handling;
   1.2. bind/resume means resuming EC event handling.
2. According to the known EC FW facts, it takes time for EC FW to
   initialize after boot/resume.

This patchset fixes the root causes of the 2 regressions and keeps the
possibility of tuning acpi.ec_freeze_events=Y. Note that PATCH 02
depends on PATCH 01 to be safe for driver unbind.

Lv Zheng (2):
  ACPI / EC: Fix a regression related to the triggering source of the EC
    event handling
  ACPI / EC: Fix a regression related to the PM ops support of ECDT
    device

 drivers/acpi/ec.c           | 81 +++++++++++++++++++++++++++++----------------
 drivers/acpi/internal.h     |  1 +
 drivers/acpi/scan.c         | 21 ++++++++++++
 include/acpi/acpi_bus.h     |  1 +
 include/acpi/acpi_drivers.h |  1 +
 5 files changed, 76 insertions(+), 29 deletions(-)

-- 
2.7.4
