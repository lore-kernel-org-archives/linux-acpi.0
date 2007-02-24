From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/5] ACPI: ibm-acpi: update documentation
Date: Sat, 24 Feb 2007 13:01:22 -0200
Message-ID: <d23ebd8421c3593ed659e16d6aa41a59dedc561c.1172327581.git.hmh__1311.06010308049$1172329486$gmane$org@hmh.eng.br>
References: <11723292823837-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60133 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932966AbXBXPET (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Feb 2007 10:04:19 -0500
In-Reply-To: <11723292823837-git-send-email-hmh@hmh.eng.br>
Message-Id: <d23ebd8421c3593ed659e16d6aa41a59dedc561c.1172327581.git.hmh@hmh.eng.br>
In-Reply-To: <bde16e404cce89ebfe6d9b143d979f0c6fe5434b.1172327581.git.hmh@hmh.eng.br>
References: <bde16e404cce89ebfe6d9b143d979f0c6fe5434b.1172327581.git.hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update documentation header, and relocate a hunk of text that was missplaced.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/ibm-acpi.txt |   85 +++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 0132d36..16f1c77 100644
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
1.5.0.1

