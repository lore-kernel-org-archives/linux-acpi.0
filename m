From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ACPI: Add Toshiba Satellite C650D to DMI blacklist for corrupting DSDT
Date: Fri,  6 Aug 2010 18:40:18 +0200
Message-ID: <1281112818-19388-1-git-send-email-anisse@astier.eu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:39481 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932918Ab0HFQkl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Aug 2010 12:40:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Anisse Astier <anisse@astier.eu>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>

This machine has a BIOS that corrupts the DSDT, and adding
acpi=copy_dsdt on cmdline fixes it. This feature and the corresponding
blacklist was added in commit aa2110cb1a7510f9b834adfb39b05d4843a35d35

Cc: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c1d23cd..fe7d7b9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -99,6 +99,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
 		},
 	},
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite C650D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite C650D"),
+		},
+	},
 	{}
 };
 #else
-- 
1.7.0.6

