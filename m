From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/28] ACPI: ibm_acpi: Update documentation for brightness and volume.
Date: Sat, 14 Oct 2006 04:05:44 -0400
Message-ID: <11608131722926-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15251 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752123AbWJNICv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:02:51 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <24f7ff0af855ece60064a2532d8b316df02983c6.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Fri, 22 Sep 2006 12:19:15 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>

From: Stefan Schmidt <stefan@datenfreihafen.org>

Document the change of the experimental flag for brightness and volume.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ibm-acpi.txt |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 71aa403..1672590 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -30,8 +30,8 @@ detailed description):
 	- ACPI sounds
 	- temperature sensors
 	- Experimental: embedded controller register dump
-	- Experimental: LCD brightness control
-	- Experimental: volume control
+	- LCD brightness control
+	- Volume control
 	- Experimental: fan speed, fan enable/disable
 
 A compatibility table by model and feature is maintained on the web
@@ -523,13 +523,8 @@ registers contain the current battery ca
 with this, do send me your results (including some complete dumps with
 a description of the conditions when they were taken.)
 
-EXPERIMENTAL: LCD brightness control -- /proc/acpi/ibm/brightness
------------------------------------------------------------------
-
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+LCD brightness control -- /proc/acpi/ibm/brightness
+---------------------------------------------------
 
 This feature allows software control of the LCD brightness on ThinkPad
 models which don't have a hardware brightness slider. The available
@@ -542,13 +537,8 @@ commands are:
 The <level> number range is 0 to 7, although not all of them may be
 distinct. The current brightness level is shown in the file.
 
-EXPERIMENTAL: Volume control -- /proc/acpi/ibm/volume
------------------------------------------------------
-
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+Volume control -- /proc/acpi/ibm/volume
+---------------------------------------
 
 This feature allows volume control on ThinkPad models which don't have
 a hardware volume knob. The available commands are:
-- 
1.4.3.rc2.g23bed-dirty
