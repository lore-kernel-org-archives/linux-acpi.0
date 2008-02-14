From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/11] ACPI: DMI blacklist updates
Date: Thu, 14 Feb 2008 02:02:31 -0500
Message-ID: <bb54675b9b2f968f07e29b6c23b8dc90bad59723.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3160 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756407AbYBNHKp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:45 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Acer Extensa 5220 -- OSI(Linux) is a NOP
Dell OptiPlex 755 -- OSI(Linux) turns GUSB into a NOP
Dell PowerEdge 1950 -- OSI(Linux) is a NOP
Dell Precision 690 -- OSI(Linux) touches USB (skips GUSB)
FSC ESPRIMO Mobile V5505 -- OSI(Linux) is a NOP
Lenovo LENOVO3000 V100 -- OSI(Linux) is a NOP
Lenovo X61x -- OSI(Linux) enables Linux specific AML
Sony Vaio VGN-NR11S_S - OSI(Linux) is a NOP

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   50 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 9ce983e..dfa4ac8 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -228,10 +228,10 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 6460"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 7510"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
 	 *
 	 * _OSI(Linux) is a NOP:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
 	 */
 	{
 	.callback = dmi_disable_osi_linux,
@@ -327,12 +327,20 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell OP GX620",
+	.ident = "Dell OptiPlex GX620",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX620"),
 		},
 	},
+	{ /* OSI(Linux) causes some USB initialization to not run */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell OptiPlex 755",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 755"),
+		},
+	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
 	.ident = "Dell PE 1900",
@@ -342,6 +350,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell PE 1950",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1950"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
 	.callback = dmi_disable_osi_linux,
 	.ident = "Dell PE R200",
 	.matches = {
@@ -357,6 +373,22 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 390"),
 		},
 	},
+	{ /* OSI(Linux) touches USB */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell PR 390",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 690"),
+		},
+	},
+	{ /* OSI(Linux) unknown - ASL looks benign, but may effect dock/SMM */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell PR M4300",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision M4300"),
+		},
+	},
 	{ /* OSI(Linux) is a NOP */
 	.callback = dmi_disable_osi_linux,
 	.ident = "Dell Vostro 1000",
@@ -390,10 +422,10 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1536"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1556"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Xi 1546"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 	 * _OSI(Linux) unknown effect:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo M1425"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo Si 1520"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 	 */
 	{
 	.callback = dmi_disable_osi_linux,
@@ -443,10 +475,11 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * _OSI(Linux) helps sound
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 * _OSI(Linux) has Linux specific hooks
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 	 * _OSI(Linux) is a NOP:
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
-	 * _OSI(Linux) effect unknown
-	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "LENOVO3000 V100"),
 	 */
 	{
 	.callback = dmi_enable_osi_linux,
@@ -465,7 +498,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{
-	.callback = dmi_unknown_osi_linux,
+	.callback = dmi_enable_osi_linux,
 	.ident = "Lenovo ThinkPad X61",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -473,7 +506,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 	{
-	.callback = dmi_unknown_osi_linux,
+	.callback = dmi_disable_osi_linux,
 	.ident = "Lenovo 3000 V100",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -543,8 +576,9 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * Disable OSI(Linux) warnings on all "Sony Corporation"
 	 *
 	 * _OSI(Linux) is a NOP:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ650N"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NR11S_S"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ38GP_C"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ650N"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-TZ21MN_N"),
 	 * _OSI(Linux) unknown effect:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ11M"),
-- 
1.5.4.1.122.gaa8d

