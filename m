From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 00/13] Thermal Framework Enhancements
Date: Thu,  9 Aug 2012 18:15:52 +0530
Message-ID: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932262Ab2HIMqJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2012 08:46:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch series attempts to enhance the thermal framework
by adding some simple governors/throttling algorithms.

These patches are based on Rui's tree here: (branch - thermal)
git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git

Patch 1: Refactor thermal.h so that it is easy to read/maintain
Patch 2: Move data structures that need to be visible to thermal.h
Patch 3: Adds some APIs to thermal_sys.c
Patch 4: Adds required platform layer information to thermal.h
Patch 5: Adds code to thermal_sys, that can retrieve platform data
         (if provided) for a thermal zone
Patch 6: Creates a policy sysfs attribute (RO, for now)
Patch 7: Modifies the bind/unbind logic based on the platform data
	 With this modification, the bind/unbind can work with or
	 without platform data
Patch 8: Introduces a fair_share governor. This throttles the
	 cooling_devices according to their weights. The weights
	 in turn describe the effectiveness of a particular
	 cooling device in cooling a thermal zone.
Patch 9: Introduce step_wise governor
	 This throttles/de-throttles the cooling devices one
	 step at a time. This is exactly similar to the code
	 we have in thermal_zone_device_update function. The
	 intention is to move all 'throttling logic' related
	 code outside thermal_sys.c and keep them separate.
Patch 10: Removes all throttling code outside thermal_sys.c
Patch 11: Adds a notification API so that thermal sensor drivers
	  can notify the framework of any thermal events.
Patch 12: Adds documentation to Documentation/thermal/sysfs-api.txt
Patch 13: Shows some sample code on how to provide platform level
	  thermal data. This patch is not for merge.

Durgadoss R (13):
  Thermal: Refactor thermal.h file
  Thermal: Move thermal_instance to thermal.h
  Thermal: Add get trend, get instance API's to thermal_sys
  Thermal: Add platform level information to thermal.h
  Thermal: Obtain platform data for thermal zone
  Thermal: Add a policy sysfs attribute
  Thermal: Update binding logic based on platform data
  Thermal: Introduce fair_share thermal governor
  Thermal: Introduce a step_wise thermal governor
  Thermal: Remove throttling logic out of thermal_sys.c
  Thermal: Add a notification API
  Thermal: Add documentation for platform layer data
  Thermal: Platform layer changes to provide thermal data

 Documentation/thermal/sysfs-api.txt |   30 ++
 arch/x86/platform/mrst/mrst.c       |   42 +++
 drivers/thermal/Kconfig             |   12 +
 drivers/thermal/Makefile            |    4 +-
 drivers/thermal/fair_share.c        |  128 +++++++
 drivers/thermal/step_wise.c         |  204 +++++++++++
 drivers/thermal/thermal_sys.c       |  673 +++++++++++++++++++++--------------
 include/linux/thermal.h             |  167 +++++++--
 8 files changed, 963 insertions(+), 297 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c
 create mode 100644 drivers/thermal/step_wise.c

-- 
1.7.9.5

