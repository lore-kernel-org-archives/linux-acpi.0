From: akpm@linux-foundation.org
Subject: [patch for 2.6.29? 1/1] acer-wmi: fix regression in backlight detection
Date: Wed, 04 Mar 2009 12:07:34 -0800
Message-ID: <200903042007.n24K7Yc7029496@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53524 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757510AbZCDU0m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 15:26:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mspang@csclub.uwaterloo.ca, ak@linux.intel.com, carlos@strangeworlds.co.uk, len.brown@intel.com, rjw@sisk.pl, rui.zhang@intel.com, stable@kernel.org, trenn@suse.de

From: Michael Spang <mspang@csclub.uwaterloo.ca>

Currently we disable the Acer WMI backlight device if there is no ACPI
backlight device.  As a result, we end up with no backlight device at all.
 We should instead disable it if there is an ACPI device, as the other
laptop drivers do.  This regression was introduced in febf2d9 ("Acer-WMI:
fingers off backlight if video.ko is serving this functionality").

Each laptop driver with backlight support got a similar change around
febf2d9.  The changes to the other drivers look correct; see e.g. 
a598c82f for a similar but correct change.  The regression is also in
2.6.28.

Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <stable@kernel.org>		[2.6.28.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acer-wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/acer-wmi.c~acer-wmi-fix-regression-in-backlight-detection drivers/platform/x86/acer-wmi.c
--- a/drivers/platform/x86/acer-wmi.c~acer-wmi-fix-regression-in-backlight-detection
+++ a/drivers/platform/x86/acer-wmi.c
@@ -1297,7 +1297,7 @@ static int __init acer_wmi_init(void)
 
 	set_quirks();
 
-	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
+	if (acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
 		interface->capability &= ~ACER_CAP_BRIGHTNESS;
 		printk(ACER_INFO "Brightness must be controlled by "
 		       "generic video driver\n");
_
