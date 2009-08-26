From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 2/6] thermal: sysfs-api.txt - document passive attribute for thermal zones
Date: Wed, 26 Aug 2009 18:17:21 +0200
Message-ID: <1251303445-25317-3-git-send-email-elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751936AbZHZQS1@vger.kernel.org>
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Zhang Rui <rui.zhang@intel.com>, Sujith Thomas <sujith.thomas@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 895337f..2a036eb 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -3,7 +3,7 @@ Generic Thermal Sysfs driver How To
 
 Written by Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>
 
-Updated: 2 January 2008
+Updated: 21 August 2009
 
 Copyright (c)  2008 Intel Corporation
 
@@ -199,6 +199,15 @@ cdev[0-*]_trip_point
 	point.
 	RO, Optional
 
+passive
+	Attribute is only present for zones which do not have a passive
+	cooling policy (_PSV) defined in ACPI. Default is zero and can be
+	set to a temperature (in millidegrees) to enable a passive trip
+	point for the zone. Activation is done by polling with an interval
+	of 1 second.
+	Unit: millidegrees Celsius
+	RW, Optional
+
 *****************************
 * Cooling device attributes *
 *****************************
@@ -230,8 +239,9 @@ thermal_zone_device (thermal_zone1) with 4 trip points in all.
 It has one processor and one fan, which are both registered as
 thermal_cooling_device.
 
-If the processor is listed in _PSL method, and the fan is listed in _AL0
-method, the sys I/F structure will be built like this:
+If the processor is listed in _PSL method, the fan is listed in _AL0
+method, and the zone has a _PSV method, the sys I/F structure will be
+built like this:
 
 /sys/class/thermal:
 
