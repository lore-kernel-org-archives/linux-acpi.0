From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 00/16] Thermal: generic thermal layer enhancement
Date: Thu, 19 Jul 2012 14:31:04 +0800
Message-ID: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61928 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2GSGbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 02:31:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>

Hi, all,

these are the patches that I want to push to linux-next.

it contains two patches from Durga, one patch for documentation update,
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
6) patch 10, 11, 12, 13 rename some thermal structures to make them more accurate.
7) patch 14 introduces a simple cooling state arbitrator.
8) patch 15 unifies the code for both passive and active cooling.
9) patch 16 converts an internal list to plist, which is more efficient.

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
      Thermal: use plist instead of list

---------------------------------------------------------------------------
 Documentation/thermal/sysfs-api.txt      |   36 +-
 drivers/acpi/thermal.c                   |   99 ++++--
 drivers/platform/x86/acerhdf.c           |    6 +-
 drivers/platform/x86/intel_mid_thermal.c |    2 +-
 drivers/thermal/spear_thermal.c          |    4 +-
 drivers/thermal/thermal_sys.c            |  543 +++++++++++++++++++++---------
 include/linux/thermal.h                  |   43 ++-
 7 files changed, 521 insertions(+), 212 deletions(-)

