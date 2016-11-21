From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] ACPI: Override rev for DELL Latitude 3350
Date: Mon, 21 Nov 2016 10:07:05 +0800
Message-ID: <1479694025-13372-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34871 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbcKUCHK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Nov 2016 21:07:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The ethernet network fails to work on DELL Latitude 3350 after this commit
   ea7d521 Revert 'Revert "ACPICA: Permanently set _REV to the value '2'."'

dmesg shows
   r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
   r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
   pci 0000:00:1c.2: PCI INT C: failed to register GSI
   pci 0000:00:1c.2: Error enabling bridge (-16), continuing
   r8169 0000:03:00.0: PCI INT A: failed to register GSI
   r8169 0000:03:00.0 (unnamed net_device) (uninitialized): enable failure
   r8169: probe of 0000:03:00.0 failed with error -16

So override the ACPI _REV for this machine to fix the issue.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/acpi/blacklist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bdc67ba..a8c10f2 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -160,6 +160,14 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
 		},
 	},
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL Latitude 3350",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
+		},
+	},
 #endif
 	{}
 };
-- 
2.7.4

