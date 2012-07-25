From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 00/16] Thermal: generic thermal layer enhancement
Date: Wed, 25 Jul 2012 10:10:57 +0800
Message-ID: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36673 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409Ab2GYCL0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2012 22:11:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org


Hi, all,

This is the refreshed patch set for linux-next.

the changes includes
- fixing a build error.
- making a couple of changes based on Rafael's comments
- removing the plist patch for now as I do not have validate data to show how much benefit it brings.

This patch set contains two patches from Durga,
one patch for documentation update,
and 13 patches to fix the problems discussed in
http://marc.info/?l=linux-acpi&m=133836783425764&w=2

please kindly review.

1) patch 1, 2, introduce the writeable trip point,
   and introduce hysterisis information for each trip point.
2) patch 3 is a Documentation update.
3) patch 4, 5, 6, introduce the multiple cooling states support
   for both active and passive trip points.
4) patch 7, 8, remove passive specific requirement, aka, tc1/tc2, and
   introduce .get_trend() instead, for both active and passive cooling
   algorithm.
5) patch 9 introduces new function thermal_zone_trip_update(),
   which contains the code for general cooling algorithm.
6) patch 10, 11, 12, 13 rename some thermal structures.
7) patch 14 introduces a simple cooling state arbitrator.
8) patch 15 unifies the code for both passive and active cooling.
9) patch 16 add lock for cdev.thermal_instances list.

Any comments are welcome.

thanks,
rui

---------------------------------------------------------------------------
Durgadoss R (2):
      Thermal: Make Thermal trip points writeable
      Thermal: Add Hysteresis attributes

Zhang Rui (14):
      Thermal: Documentation update
      Thermal: Introduce multiple cooling states support
      Thermal: Introduce cooling states range support
      Thermal: set upper and lower limits
      Thermal: Introduce .get_trend() callback.
      Thermal: Remove tc1/tc2 in generic thermal layer.
      Thermal: Introduce thermal_zone_trip_update()
      Thermal: rename structure thermal_cooling_device_instance to thermal_instance
      Thermal: Rename thermal_zone_device.cooling_devices to thermal_zone_device.instances
      Thermal: Rename thermal_instance.node to thermal_instance.tz_node.
      Thermal: List thermal_instance in thermal_cooling_device.
      Thermal: Introduce simple arbitrator for setting device cooling state
      Thermal: Unify the code for both active and passive cooling
      Thermal: Introduce locking for cdev.thermal_instances
---------------------------------------------------------------------------
 Documentation/thermal/sysfs-api.txt      |   39 ++-
 drivers/acpi/thermal.c                   |  106 ++++--
 drivers/platform/x86/acerhdf.c           |    7 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    4 +-
 drivers/thermal/thermal_sys.c            |  533 +++++++++++++++++++++---------
 include/linux/thermal.h                  |   44 ++-
 7 files changed, 521 insertions(+), 214 deletions(-)
---------------------------------------------------------------------------
