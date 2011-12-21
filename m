From: Angus Turnbull <angus@twinhelix.com>
Subject: [PATCH] Force acpi_skip_timer_override for Gigabyte GA-MA78GPM-UD2H
Date: Wed, 21 Dec 2011 18:34:14 +1300
Message-ID: <1324445654.4784.8.camel@nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [109.169.67.147] ([109.169.67.147]:33753 "EHLO twinhelix.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab1LUFnn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Dec 2011 00:43:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Some Gigabyte motherboards from the SB700 generation have an issue
where they will not boot or suspend/resume without
"acpi_skip_timer_override" on the kernel command line. I have a
GA-MA78GPM-UD2H (AM2+ socket) and the below patch allows it to boot
successfully by adding it to the quirks list (the AMD bug detection in
early_quirks.c isn't enabling acpi_skip_timer_override automatically).

https://lkml.org/lkml/2011/3/31/195 covered a similar issue.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/658955 is a bug
report with my system information.

Also posted at https://lkml.org/lkml/2011/11/22/511

Reported-and-tested-by: <angus <at> twinhelix.com>
cc: Len Brown <lenb <at> kernel.org>



diff -upr a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
--- a/arch/x86/kernel/acpi/boot.c	
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1466,6 +1466,20 @@ static struct dmi_system_id __initdata a
 		     DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 6715b"),
 		     },
 	 },
+	/*
+	 * Buggy Gigabyte ACPI on SB700 boards, will not boot or resume
+	 * reliably without acpi_skip_timer_override (last stable BIOS).
+	 * Affects multiple boards of this generation.
+	 */
+	{
+	 .callback = dmi_ignore_irq0_timer_override,
+	 .ident = "Gigabyte GA-MA78GPM-UD2H",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR,
+			"Gigabyte Technology Co., Ltd."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "GA-MA78GPM-UD2H"),
+		     },
+	 },
 	{}
 };

