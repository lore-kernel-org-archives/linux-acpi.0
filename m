From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv2 00/14] Thermal Framework Enhancements
Date: Mon, 27 Aug 2012 09:58:12 +0530
Message-ID: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26117 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2H0E24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 00:28:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch series is a v2 of the series submitted here:
http://www.spinics.net/lists/linux-acpi/msg37375.html

These patches are based on Rui's tree here: (branch - thermal)
git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git

Changes since v1:
 * Created thermal_core.h
 * Removed get_cdev_by_name API, as it is no longer needed
 * Introduced thermal_bind_params inside thermal_zone_params
 * Use a single arbitrator by making thermal_cdev_update global
 * Added more documentation on EXPORT_SYMBOL APIs in thermal_sys.c
 * Various minor fixes based on comments from Rui and Eduardo.

The function pointer based implementation for various throttling
policies is not done here. I tried and it altered the structure of
the patch set a lot, and hence I shall take it up after this code
gets in.

Durgadoss R (14):
  Thermal: Refactor thermal.h file
  Thermal: Move thermal_instance to thermal_core.h
  Thermal: Add get trend, get instance API's to thermal_sys
  Thermal: Add platform level information to thermal.h
  Thermal: Obtain platform data for thermal zone
  Thermal: Add a policy sysfs attribute
  Thermal: Update binding logic based on platform data
  Thermal: Make thermal_cdev_update as a global function
  Thermal: Introduce fair_share thermal governor
  Thermal: Introduce a step_wise thermal governor
  Thermal: Remove throttling logic out of thermal_sys.c
  Thermal: Add a notification API
  Thermal: Add documentation for platform layer data
  Thermal: Platform layer changes to provide thermal data

 Documentation/thermal/sysfs-api.txt |   51 +++
 arch/x86/platform/mrst/mrst.c       |   49 +++
 drivers/thermal/Kconfig             |   12 +
 drivers/thermal/Makefile            |    4 +-
 drivers/thermal/fair_share.c        |  113 ++++++
 drivers/thermal/step_wise.c         |  173 ++++++++++
 drivers/thermal/thermal_core.h      |   53 +++
 drivers/thermal/thermal_sys.c       |  647 ++++++++++++++++++++++-------------
 include/linux/thermal.h             |  145 ++++++--
 9 files changed, 969 insertions(+), 278 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c
 create mode 100644 drivers/thermal/step_wise.c
 create mode 100644 drivers/thermal/thermal_core.h

-- 
1.7.9.5

