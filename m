From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/7] ACPI: schedule obsolete features for deletion
Date: Thu, 11 Jan 2007 04:11:46 -0500
Message-ID: <11685067141577-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com> <11685067101245-git-send-email-len.brown@intel.com> <11685067113037-git-send-email-len.brown@intel.com> <11685067121393-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45388 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030248AbXAKJLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:55 -0500
In-Reply-To: <11685067121393-git-send-email-len.brown@intel.com>
Message-Id: <1bb67c2582f4271488721001a707124fd0af347e.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   45 ++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 30f3c8c..2ee16b4 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -256,3 +256,48 @@ Why:	Speedstep-centrino driver with ACPI hooks and acpi-cpufreq driver are
 Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
+
+What:	ACPI hotkey driver (CONFIG_ACPI_HOTKEY)
+When:	2.6.21
+Why:	hotkey.c was an attempt to consolidate multiple drivers that use
+	ACPI to implement hotkeys.  However, hotkeys are not documented
+	in the ACPI specification, so the drivers used undocumented
+	vendor-specific hooks and turned out to be more different than
+	the same.
+
+	Further, the keys and the features supplied by each platform
+	are different, so there will always be a need for
+	platform-specific drivers.
+
+	So the new plan is to delete hotkey.c and instead, work on the
+	platform specific drivers to try to make them look the same
+	to the user when they supply the same features.
+
+	hotkey.c has always depended on CONFIG_EXPERIMENTAL
+
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
+What:	/sys/firmware/acpi/namespace
+When:	2.6.21
+Why:	The ACPI namespace is effectively the symbol list for
+	the BIOS.  The device names are completely arbitrary
+	and have no place being exposed to user-space.
+
+	For those interested in the BIOS ACPI namespace,
+	the BIOS can be extracted and disassembled with acpidump
+	and iasl as documented in the pmtools package here:
+	http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils
+
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
+
+What:	/proc/acpi/button
+When:	August 2007
+Why:	/proc/acpi/button has been replaced by events to the input layer
+	since 2.6.20.
+Who:	Len Brown <len.brown@intel.com>
+
+---------------------------
-- 
1.4.4.4.ge05d
