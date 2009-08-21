From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 2/3] acpi: thermal/sysfs-api.txt: document passive attribute for thermal zones
Date: Fri, 21 Aug 2009 10:59:35 +0200
Message-ID: <200908211059.36774.elendil@planet.nl>
References: <200908211055.20569.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:60146 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754366AbZHUI7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 04:59:35 -0400
In-Reply-To: <200908211055.20569.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Sujith Thomas <sujith.thomas@intel.com>

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 48e9c5c..52b63c4 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -3,7 +3,7 @@ Generic Thermal Sysfs driver How To
 
 Written by Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>
 
-Updated: 2 January 2008
+Updated: 21 August 2009
 
 Copyright (c)  2008 Intel Corporation
 
@@ -199,6 +199,16 @@ cdev[0-*]_trip_point
 	point.
 	RO, Optional
 
+passive
+	Attribute is only present for zones which do not have a passive
+	cooling policy (_PSV) defined in ACPI. Default is zero and can be
+	set to a temperature (in millidegrees) to enable a passive trip
+	point for the zone. Activation is done by polling (default interval:
+	10 seconds); the polling interval can be set in
+	/proc/acpi/thermal/TZN/polling_frequency.
+	Unit: millidegree Celsius
+	RW, Optional
+
 *****************************
 * Cooling device attributes *
 *****************************
@@ -230,8 +240,9 @@ thermal_zone_device (thermal_zone1) with 4 trip points in all.
 It has one processor and one fan, which are both registered as
 thermal_cooling_device.
 
-If the processor is listed in _PSL method, and the fan is listed in _AL0
-method, the sys I/F structure will be built like this:
+If the processor is listed in _PSL method, the fan is listed in _AL0
+method, and the zone has a _PSV method, the sys I/F structure will be
+built like this:
 
 /sys/class/thermal:
 
