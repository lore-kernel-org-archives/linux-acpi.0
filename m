From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/5] ACPI: ibm-acpi: update documentation
Date: Sat, 24 Feb 2007 13:01:22 -0200
Message-ID: <11723292822621-git-send-email-hmh@hmh.eng.br>
References: <11723292823837-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11723292823837-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Message-Id: <d23ebd8421c3593ed659e16d6aa41a59dedc561c.1172327581.git.hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
In-Reply-To: <bde16e404cce89ebfe6d9b143d979f0c6fe5434b.1172327581.git.hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
References: <bde16e404cce89ebfe6d9b143d979f0c6fe5434b.1172327581.git.hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Update documentation header, and relocate a hunk of text that was missplaced.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
 
                Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
+	     Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
-Toan T Nguyen <ntt-JAjqph6Yjy/HDPtHwZCLWA@public.gmane.org> notes that Suse uses the
-powersave program to suspend ('powersave --suspend-to-ram') or
-hibernate ('powersave --suspend-to-disk'). This means that the
-hibernate script is not needed on that distribution.
-
-Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> has written a Gentoo ACPI event
-handler script for the X31. You can get the latest version from
-http://dev.gentoo.org/~brix/files/x31.sh
-
-David Schweikert <dws-D+RCJvqCTXrtRgLqZ5aouw@public.gmane.org> has written an alternative blank.sh
-script which works on Debian systems. This scripts has now been
-extended to also work on Fedora systems and included as the default
-blank.sh in the distribution.
-- 
1.5.0.1


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
