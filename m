From: Thomas Koch <linrunner@gmx.net>
Subject: [PATCH] ACPI: Add missing Thinkpad models to OSI(Linux) white list
Date: Fri, 14 Jun 2013 18:21:38 +0200
Message-ID: <51BB4312.6060302@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51167 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab3FNQVn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Jun 2013 12:21:43 -0400
Received: from mailout-de.gmx.net ([10.1.76.35]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MRhah-1UtpF90Nnl-00SxFo for
 <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2013 18:21:42 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org


acpi_osi=Linux helps the mute button work properly by sending Linux a
mute key press.

Add missing Thinkpad models X61[st], X200[st], R400, R500, W500, W700,
X300, X301 to the list.

Signed-off-by: Thomas Koch <linrunner@gmx.net>
---
 drivers/acpi/blacklist.c |   58
+++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index cb96296..65dfe0e 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -305,7 +305,7 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
 	},
 	{
 	.callback = dmi_enable_osi_linux,
-	.ident = "Lenovo ThinkPad X61",
+	.ident = "Lenovo ThinkPad X61[s][t]",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
@@ -327,6 +327,62 @@ static struct dmi_system_id acpi_osi_dmi_table[]
__initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
 		},
 	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad X200[s][t]",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X200"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R400",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R400"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad R500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R500"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad W500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W500"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad W700[ds]",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W700"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad X300",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X300"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad X301",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X301"),
+		},
+	},
 	{}
 };

-- 
1.7.9.5
