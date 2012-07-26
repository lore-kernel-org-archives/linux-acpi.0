From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V4 00/13] Thermal: generic thermal layer enhancement
Date: Thu, 26 Jul 2012 16:41:10 +0800
Message-ID: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5721 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab2GZIlh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2012 04:41:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org


Hi, all,

This is the patch set for linux-next.

the changes includes:

V4:
- dropped three patches which have been already picked by Len.
- re-organize some piece of code based on Rafael's comments
- improve some changelog

V3: http://marc.info/?l=linux-acpi&m=134318254518940&w=2
- fixing a build error.
- making a couple of changes based on Rafael's comments
- removing the plist patch for now as I do not have validate data to show how much benefit it brings.

V2: http://marc.info/?l=linux-acpi&m=134267975014396&w=2
- a couple of changes based on Eduardo and Amit's comments.
- convert an internal list to plist to be more efficiency.

V1: http://marc.info/?l=linux-acpi&m=133938485224765&w=2
- 12 RFC patches to fix the problems discussed in http://marc.info/?l=linux-acpi&m=133836783425764&w=2

please kindly review.

Any comments are welcome.

thanks,
rui

---------------------------------------------------------------------------
Zhang Rui (13):
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
 Documentation/thermal/sysfs-api.txt      |    9 +-
 drivers/acpi/thermal.c                   |   98 +++++++---
 drivers/platform/x86/acerhdf.c           |    5 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    2 +-
 drivers/thermal/thermal_sys.c            |  308 +++++++++++++++++++-----------
 include/linux/thermal.h                  |   28 ++-
 7 files changed, 300 insertions(+), 152 deletions(-)
---------------------------------------------------------------------------
