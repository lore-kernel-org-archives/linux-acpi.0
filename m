From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [Patch 2/3] ibm-acpi: Update documentation for brightness and volume.
Date: Fri, 22 Sep 2006 12:19:15 +0200
Message-ID: <20060922101944.826924436@datenfreihafen.org>
References: <20060922101913.276298370@datenfreihafen.org>
Reply-To: linux-thinkpad@linux-thinkpad.org
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline; filename=ibm-acpi-get-rid-of-experimental-status-doc.patch
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

Document the change of the experimental flag for brightness and volume.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
Index: linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt
===================================================================
--- linux-2.6.18-ibm-acpi.orig/Documentation/ibm-acpi.txt	2006-09-21 20:56:16.000000000 +0200
+++ linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt	2006-09-21 20:59:22.000000000 +0200
@@ -30,8 +30,8 @@
 	- ACPI sounds
 	- temperature sensors
 	- Experimental: embedded controller register dump
-	- Experimental: LCD brightness control
-	- Experimental: volume control
+	- LCD brightness control
+	- Volume control
 	- Experimental: fan speed, fan enable/disable
 
 A compatibility table by model and feature is maintained on the web
@@ -523,13 +523,8 @@
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
@@ -542,13 +537,8 @@
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

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
