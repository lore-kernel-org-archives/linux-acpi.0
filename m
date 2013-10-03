From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] acpi: update win8 OSI blacklist
Date: Thu,  3 Oct 2013 12:13:03 -0500
Message-ID: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-acpi@vger.kernel.org

More people have reported they need this for their machines to work
correctly.

https://bugzilla.kernel.org/show_bug.cgi?id=60682

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/blacklist.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 9515f18..f37dec5 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -297,6 +297,54 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ThinkPad Edge E530",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ThinkPad Edge E530",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Acer Aspire V5-573G",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Acer Aspire V5-572G",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ThinkPad T431s",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ThinkPad T430",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.8.4-fc
