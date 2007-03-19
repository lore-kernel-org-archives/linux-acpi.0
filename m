From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [PATCH] prevent ACPI quirk warning mass spamming in logs
Date: Mon, 19 Mar 2007 12:50:34 +0100
Message-ID: <m2aby9ih9x.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from office-abk.mandriva.com ([84.55.162.90]:4459 "EHLO
	office.mandriva.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbXCSMDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2007 08:03:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

--=-=-=

Hi,

The following patch prevent this warning to be displayed again & again
(eg: nine times on my NForce2 motherboard) and thus improve signal to
noise ratio in logs.

The ATI quirk below probably needs a similar "fix" but I don't have
the hardware to test.

Btw arch/x86_64/kernel/early-quirks.c::nvidia_bugs() would probably
need to be synced (but I don't have an x86_64 NVidia motherboard to
boot test it). Still it shows the usefullness of the recent x86 merge
thread.

    Signed-off-by: Thierry Vignaud <tvignaud@mandriva.com>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=kernel_1.diff

The following patch prevent this warning to be displayed again & again
(eg: nine times on my NForce2 motherboard) and thus improve signal to
noise ratio in logs.

The ATI quirk below probably needs a similar "fix" but I don't have
the hardware to test.

Btw arch/x86_64/kernel/early-quirks.c::nvidia_bugs() would probably
need to be synced (but I don't have an x86_64 NVidia motherboard to
boot test it). Still it shows the usefullity of the recent x86 merge
thread.

    Signed-off-by: Thierry Vignaud <tvignaud@mandriva.com>

--- ./arch/i386/kernel/acpi/earlyquirk.c.tv1	2007-03-18 20:42:17.000000000 +0100
+++ ./arch/i386/kernel/acpi/earlyquirk.c	2007-03-18 20:44:06.000000000 +0100
@@ -22,11 +22,13 @@
 
 static int __init check_bridge(int vendor, int device)
 {
+	static int warned = 0;
 #ifdef CONFIG_ACPI
 	/* According to Nvidia all timer overrides are bogus unless HPET
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
-		if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
+		if (!warned && acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
+			warned = 1;
 			acpi_skip_timer_override = 1;
 			  printk(KERN_INFO "Nvidia board "
                        "detected. Ignoring ACPI "

--=-=-=


the same as attachment in case an MTA garbages the inline one:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=kernel_1.diff

The following patch prevent this warning to be displayed again & again
(eg: nine times on my NForce2 motherboard) and thus improve signal to
noise ratio in logs.

The ATI quirk below probably needs a similar "fix" but I don't have
the hardware to test.

Btw arch/x86_64/kernel/early-quirks.c::nvidia_bugs() would probably
need to be synced (but I don't have an x86_64 NVidia motherboard to
boot test it). Still it shows the usefullity of the recent x86 merge
thread.

    Signed-off-by: Thierry Vignaud <tvignaud@mandriva.com>

--- ./arch/i386/kernel/acpi/earlyquirk.c.tv1	2007-03-18 20:42:17.000000000 +0100
+++ ./arch/i386/kernel/acpi/earlyquirk.c	2007-03-18 20:44:06.000000000 +0100
@@ -22,11 +22,13 @@
 
 static int __init check_bridge(int vendor, int device)
 {
+	static int warned = 0;
 #ifdef CONFIG_ACPI
 	/* According to Nvidia all timer overrides are bogus unless HPET
 	   is enabled. */
 	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
-		if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
+		if (!warned && acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
+			warned = 1;
 			acpi_skip_timer_override = 1;
 			  printk(KERN_INFO "Nvidia board "
                        "detected. Ignoring ACPI "

--=-=-=--
