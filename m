From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv3 00/15] Thermal_Framework_Enhancements
Date: Sat,  1 Sep 2012 17:21:21 +0530
Message-ID: <1346500296-25200-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45763 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab2IALwX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Sep 2012 07:52:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, Durgadoss R <durgadoss.r@intel.com>

This patch series is a v3 of the series submitted here:
http://www.spinics.net/lists/linux-acpi/msg37375.html

These patches are based on Rui's tree here: (branch - thermal)
git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git

Changes since v2:
 * Made thermal_zone_params as argument to tzd_register()
 * Introduced Thermal governor register/unregister APIs
 * Added 'write' permission for policy sysfs attribute
 * Added function pointer based implemention for thermal
   governors.
 * Added a 'dummy' user space governor in thermal_sys.c
 * Renamed 'do_binding' and 'update_bind_info' functions as
   'bind_tz' and 'bind_cdev' respectively
 * Updated Documentation for all the changes
Changes since v1:
 * Created thermal_core.h
 * Removed get_cdev_by_name API, as it is no longer needed
 * Introduced thermal_bind_params inside thermal_zone_params
 * Use a single arbitrator by making thermal_cdev_update global
 * Added more documentation on EXPORT_SYMBOL APIs in thermal_sys.c
 * Various minor fixes based on comments from Rui and Eduardo.

Durgadoss R (15):
  Thermal: Refactor thermal.h file
  Thermal: Move thermal_instance to thermal_core.h
  Thermal: Add get trend, get instance API's to thermal_sys
  Thermal: Add platform level information to thermal.h
  Thermal: Pass zone parameters as argument to tzd_register
  Thermal: Add thermal governor registration APIs
  Thermal: Add a policy sysfs attribute
  Thermal: Update binding logic based on platform data
  Thermal: Make thermal_cdev_update as a global function
  Thermal: Introduce fair_share thermal governor
  Thermal: Introduce a step_wise thermal governor
  Thermal: Register a governor for user space
  Thermal: Remove throttling logic out of thermal_sys.c
  Thermal: Add a notification API
  Thermal: Add documentation for platform layer data

 Documentation/thermal/sysfs-api.txt                |   64 ++
 drivers/acpi/thermal.c                             |    6 +-
 drivers/platform/x86/acerhdf.c                     |    2 +-
 drivers/platform/x86/intel_mid_thermal.c           |    2 +-
 drivers/power/power_supply_core.c                  |    2 +-
 drivers/staging/omap-thermal/omap-thermal-common.c |    2 +-
 drivers/thermal/Kconfig                            |   12 +
 drivers/thermal/Makefile                           |    4 +-
 drivers/thermal/fair_share.c                       |  133 ++++
 drivers/thermal/spear_thermal.c                    |    2 +-
 drivers/thermal/step_wise.c                        |  194 ++++++
 drivers/thermal/thermal_core.h                     |   53 ++
 drivers/thermal/thermal_sys.c                      |  715 +++++++++++++-------
 include/linux/thermal.h                            |  130 +++-
 14 files changed, 1031 insertions(+), 290 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c
 create mode 100644 drivers/thermal/step_wise.c
 create mode 100644 drivers/thermal/thermal_core.h

-- 
1.7.9.5

