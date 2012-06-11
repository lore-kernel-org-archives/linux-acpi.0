From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH 0/4] Thermal Framework Enhancements
Date: Mon, 11 Jun 2012 23:09:30 +0530
Message-ID: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45134 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049Ab2FLFW2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 01:22:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch series attempts to add some simple governors/
throttling algorithms to the generic thermal layer.
Although this patch set creates simple governors which depend
on the platform data provided, we can start here, and write
some really smart algorithms that will do the wonder!!

Patch 1/4: Creates necessary infrastructure required to
	   add throttling algorithms in thermal_sys.c
	   1. Introduces the get_trend callback
	   2. Introduces the notify_thermal_framework() API
	   3. Exposes sysfs to show/store the throttle_policy

Patch 2/4: Introduce fair_share governor
	   This throttles the cooling_devices according to their
	   weights (and hence the name; Suggestion are welcome :-).
	   The weights in turn describe the effectiveness of a
	   particular cooling device in cooling a thermal zone.

Patch 3/4: Introduce step_wise governor
	   This throttles/de-throttles the cooling devices one
	   step at a time. This is exactly similar to the code
	   we have in thermal_zone_device_update function. The
	   intention is to move all 'throttling logic' related
	   code outside thermal_sys.c and keep them separate.

Patch 4/4: Platform data patch
	   This patch is not for merge. Just as an example to
	   show how we can provide platform data to thermal
	   framework. Not that we do not know how to fill structures,
	   I felt the patch set is in-complete without this. That's
	   why it is here. From next versions, I will ignore this one.

TODO on these patch sets:
* Sync up with Rui's latest patches
* Add more protection and tidy up the existing ones
* Expose the weights and cooling devices through sysfs (Read-Only)
* Remove all throttling related code(if we all agree) from thermal_sys.c
* In fair_share, before setting new state, check if there are other zones,
  which do not want the 'state' to be changed.
  (To do this, we have to loop through the thermal_tz_list and 
  thermal_cdev_list inside fair_share.c. Need to see how good it is
  to make this lists public)
* If we all agree, use step_wise and remove linear_throttle from thermal_sys.c
* Enhance notify_user_space(), so that the use land can extract some sane
  information out of UEvent.

WishList:
* Find a way to provide platform data so that we can map cooling devices
  for a trip point in a thermal zone.
* Make all _throttle methods have same signature. This way we can make use
  of function pointers and make the code a bit simpler.
* The simple governors heavily depend on the platform data provided. We
  can think of some really smart logic, that depends on very minimal platform
  data, and do things on its own :-)
* Make other subsystem core files register with the thermal framework as a
  thermal sensor or as a cooling device as appropriate.
  (I am thinking of Power Supply, Video, cpufreq for now)
* Ah, Find time to do all this !

Durgadoss R (4):
  RFC Thermal: Enhance Generic Thermal layer with policies
  RFC Thermal: Introduce fair-share thermal governor
  RFC Thermal: Introduce a step-wise thermal governor
  RFC Thermal: Platform layer changes to provide thermal data

 Documentation/thermal/sysfs-api.txt |   26 +++
 arch/x86/platform/mrst/mrst.c       |   39 ++++
 drivers/thermal/Kconfig             |   13 ++
 drivers/thermal/Makefile            |    4 +-
 drivers/thermal/fair_share.c        |  111 ++++++++++
 drivers/thermal/step_wise.c         |   86 ++++++++
 drivers/thermal/thermal_sys.c       |  383 ++++++++++++++++++++++++++---------
 include/linux/thermal.h             |   55 +++++
 8 files changed, 620 insertions(+), 97 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c
 create mode 100644 drivers/thermal/step_wise.c

