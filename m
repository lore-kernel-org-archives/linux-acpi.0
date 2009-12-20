From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/3] sony-laptop: documentation updates
Date: Sun, 20 Dec 2009 23:17:37 +0900
Message-ID: <1261318659-5980-2-git-send-email-malattia@linux.it>
References: <1261318659-5980-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:54544
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZLTOR4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 09:17:56 -0500
In-Reply-To: <1261318659-5980-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 Documentation/laptops/sony-laptop.txt |   37 ++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/laptops/sony-laptop.txt b/Documentation/laptops/sony-laptop.txt
index 23ce7d3..2bd4e82 100644
--- a/Documentation/laptops/sony-laptop.txt
+++ b/Documentation/laptops/sony-laptop.txt
@@ -14,7 +14,8 @@ Some models report hotkeys through the SNC or SPIC devices, such events are
 reported both through the ACPI subsystem as acpi events and through the INPUT
 subsystem. See the logs of acpid or /proc/acpi/event and
 /proc/bus/input/devices to find out what those events are and which input
-devices are created by the driver.
+devices are created by the driver. Additionally, loading the driver with the
+debug option will report all events in the kernel log.
 
 Backlight control:
 ------------------
@@ -64,6 +65,16 @@ powers off the sound card,
 	# echo "1" > /sys/devices/platform/sony-laptop/audiopower
 powers on the sound card.
 
+
+RFkill control:
+---------------
+More recent Vaio models expose a consistent set of ACPI methods to
+control radio frequency emitting devices. If you are a lucky owner of
+such a laptop you will find the necessary rfkill devices under
+/sys/class/rfkill. Check those starting with sony-* in
+	# grep . /sys/class/rfkill/*/{state,name}
+
+
 Development:
 ------------
 
@@ -75,8 +86,21 @@ pass the option 'debug=1'.
 REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
 
 In your kernel logs you will find the list of all ACPI methods
-the SNC device has on your laptop. You can see the GCDP/GCDP methods
-used to pwer on/off the CD drive, but there are others.
+the SNC device has on your laptop.
+
+* For new models you will see a long list of meaningless method names,
+reading the DSDT table source should reveal that:
+(1) the SNC device uses an internal capability lookup table
+(2) SN00 is used to find values in the lookup table
+(3) SN06 and SN07 are used to call into the real methods based on
+    offsets you can obtain iterating the table using SN00
+(4) SN02 used to enable events.
+Some values in the capability lookup table are more or less known, see
+the code for all sony_call_snc_handle calls, others are more obscure.
+
+* For old models you can see the GCDP/GCDP methods used to pwer on/off
+the CD drive, but there are others and they are usually different from
+model to model.
 
 I HAVE NO IDEA WHAT THOSE METHODS DO.
 
@@ -108,9 +132,8 @@ Bugs/Limitations:
   laptop, including permanent damage.
 
 * The sony-laptop and sonypi drivers do not interact at all. In the
-  future, sonypi could use sony-laptop to do (part of) its business.
+  future, sonypi will be removed and replaced by sony-laptop.
 
 * spicctrl, which is the userspace tool used to communicate with the
-  sonypi driver (through /dev/sonypi) does not try to use the
-  sony-laptop driver. In the future, spicctrl could try sonypi first,
-  and if it isn't present, try sony-laptop instead.
+  sonypi driver (through /dev/sonypi) is deprecated as well since all
+  its features are now available under the sysfs tree via sony-laptop.
-- 
1.6.5.7

