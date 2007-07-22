From: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/77] ACPI: Remove Dell Optiplex GX240 from the ACPI blacklist
Date: Sun, 22 Jul 2007 05:14:02 -0400
Message-ID: <11850957192175-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761017AbXGVJPV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:21 -0400
In-Reply-To: <11850957181201-git-send-email-len.brown@intel.com>
Message-Id: <4d2fafd17a325b3f4f5f9edb1211bc7f4c311269.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Tear <tarrqt@yahoo.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Tear <tarrqt@yahoo.com>

I have a Dell Optiplex GX240 and when I boot Linux, ACPI gets set up by only
acpi=ht.  dmesg shows the following line:

   DELL GX240 detected: force use of acpi=ht

Everything seemed to be fine.  However, I discovered that everything is not
fine.  The USB controller works so slowly that copying a few (uncached) 1
megabyte large photos from a USB-enabled digital camera takes many minutes
instead of a couple of seconds.

I am using Linux 2.6.21.1 on a Debian 4.0 ("Etch") system.

I thought that this might be related to ACPI.  So I tried to boot with _only_
"acpi=force" appended to the kernel command line.  Voila, the USB controller
started to work at full speed and copying photos from my digital camera took
only seconds.

I tested the system with "acpi=force" and could not find anything which did
not work.

I thought that this might be related to interrupts and APIC as well.  (Note
that this is APIC, not ACPI.) I tried booting with _only_ "noapic" and
"nolapic" appended to the command line.  Again, the USB controller started to
work at full speed.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/acpi/boot.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 280898b..a2c8b9e 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -971,14 +971,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "DELL GX240",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
-		     DMI_MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "HP VISUALIZE NT Workstation",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-- 
1.5.3.rc2.22.g69a9b
