From: Len Brown <len.brown@intel.com>
Subject: [PATCH 029/105] ACPI: ibm-acpi: update documentation
Date: Sun, 29 Apr 2007 00:50:29 -0400
Message-ID: <1177822331727-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55051 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbXD2EwO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:14 -0400
In-Reply-To: <11778223304019-git-send-email-len.brown@intel.com>
Message-Id: <38f996ed21089fa4ae40526a5f428e3c792ea561.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update documentation header, and relocate a hunk of text that was missplaced.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ibm-acpi.txt |   85 +++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index cdcef01..f409f4b 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -1,16 +1,17 @@
 		    IBM ThinkPad ACPI Extras Driver
 
-                            Version 0.12
-                           17 August 2005
+                            Version 0.13
+                           31 December 2006
 
                Borislav Deianov <borislav@users.sf.net>
+	     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
 		      http://ibm-acpi.sf.net/
 
 
 This is a Linux ACPI driver for the IBM ThinkPad laptops. It supports
 various features of these laptops which are accessible through the
-ACPI framework but not otherwise supported by the generic Linux ACPI
-drivers.
+ACPI framework but not otherwise fully supported by the generic Linux
+ACPI drivers.
 
 
 Status
@@ -638,6 +639,26 @@ The ThinkPad's ACPI DSDT code will reprogram the fan on its own when
 certain conditions are met.  It will override any fan programming done
 through ibm-acpi.
 
+The ibm-acpi kernel driver can be programmed to revert the fan level
+to a safe setting if userspace does not issue one of the fan commands:
+"enable", "disable", "level" or "watchdog" within a configurable
+ammount of time.  To do this, use the "watchdog" command.
+
+	echo 'watchdog <interval>' > /proc/acpi/ibm/fan
+
+Interval is the ammount of time in seconds to wait for one of the
+above mentioned fan commands before reseting the fan level to a safe
+one.  If set to zero, the watchdog is disabled (default).  When the
+watchdog timer runs out, it does the exact equivalent of the "enable"
+fan command.
+
+Note that the watchdog timer stops after it enables the fan.  It will
+be rearmed again automatically (using the same interval) when one of
+the above mentioned fan commands is received.  The fan watchdog is,
+therefore, not suitable to protect against fan mode changes made
+through means other than the "enable", "disable", and "level" fan
+commands.
+
 EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
 ---------------------------------------
 
@@ -670,59 +691,3 @@ example:
 
 	modprobe ibm_acpi hotkey=enable,0xffff video=auto_disable
 
-The ibm-acpi kernel driver can be programmed to revert the fan level
-to a safe setting if userspace does not issue one of the fan commands:
-"enable", "disable", "level" or "watchdog" within a configurable
-ammount of time.  To do this, use the "watchdog" command.
-
-	echo 'watchdog <interval>' > /proc/acpi/ibm/fan
-
-Interval is the ammount of time in seconds to wait for one of the
-above mentioned fan commands before reseting the fan level to a safe
-one.  If set to zero, the watchdog is disabled (default).  When the
-watchdog timer runs out, it does the exact equivalent of the "enable"
-fan command.
-
-Note that the watchdog timer stops after it enables the fan.  It will
-be rearmed again automatically (using the same interval) when one of
-the above mentioned fan commands is received.  The fan watchdog is,
-therefore, not suitable to protect against fan mode changes made
-through means other than the "enable", "disable", and "level" fan
-commands.
-
-
-Example Configuration
----------------------
-
-The ACPI support in the kernel is intended to be used in conjunction
-with a user-space daemon, acpid. The configuration files for this
-daemon control what actions are taken in response to various ACPI
-events. An example set of configuration files are included in the
-config/ directory of the tarball package available on the web
-site. Note that these are provided for illustration purposes only and
-may need to be adapted to your particular setup.
-
-The following utility scripts are used by the example action
-scripts (included with ibm-acpi for completeness):
-
-	/usr/local/sbin/idectl -- from the hdparm source distribution,
-		see http://www.ibiblio.org/pub/Linux/system/hardware
-	/usr/local/sbin/laptop_mode -- from the Linux kernel source
-		distribution, see Documentation/laptop-mode.txt
-	/sbin/service -- comes with Redhat/Fedora distributions
-	/usr/sbin/hibernate -- from the Software Suspend 2 distribution,
-		see http://softwaresuspend.berlios.de/
-
-Toan T Nguyen <ntt@physics.ucla.edu> notes that Suse uses the
-powersave program to suspend ('powersave --suspend-to-ram') or
-hibernate ('powersave --suspend-to-disk'). This means that the
-hibernate script is not needed on that distribution.
-
-Henrik Brix Andersen <brix@gentoo.org> has written a Gentoo ACPI event
-handler script for the X31. You can get the latest version from
-http://dev.gentoo.org/~brix/files/x31.sh
-
-David Schweikert <dws@ee.eth.ch> has written an alternative blank.sh
-script which works on Debian systems. This scripts has now been
-extended to also work on Fedora systems and included as the default
-blank.sh in the distribution.
-- 
1.5.2.rc0.34.gda94
