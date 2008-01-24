From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] ACPI: DMI blacklist to reduce console warnings on OSI(Linux) systems.
Date: Wed, 23 Jan 2008 21:32:47 -0500
Message-ID: <a1bd4e35e8d9df24db7d7addd74cbfcc87ec9fb3.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:21248 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752458AbYAXCdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:40 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This DMI blacklist reduces the console messages
on systems which have a BIOS that invokes OSI(Linux).

As the DMI blacklist already knows about these systems,
the request for DMI info itself is disabled.

Further, if OSI(Linux) has already been determined
to have no beneift, we disable the console message
requesting acpi_osi=Linux test results.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |  343 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 343 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e88d446..8809654 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -178,12 +178,264 @@ static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 	acpi_dmi_osi_linux(1, d);	/* enable */
 	return 0;
 }
+static int __init dmi_disable_osi_linux(const struct dmi_system_id *d)
+{
+	acpi_dmi_osi_linux(0, d);	/* disable */
+	return 0;
+}
+static int __init dmi_unknown_osi_linux(const struct dmi_system_id *d)
+{
+	acpi_dmi_osi_linux(-1, d);	/* unknown */
+	return 0;
+}
+
+/*
+ * Most BIOS that invoke OSI(Linux) do nothing with it.
+ * But some cause Linux to break.
+ * Only a couple use it to make Linux run better.
+ *
+ * Thus, Linux should continue to disable OSI(Linux) by default,
+ * should continue to discourage BIOS writers from using it, and
+ * should whitelist the few existing systems that require it.
+ *
+ * If it appears clear a vendor isn't using OSI(Linux)
+ * for anything constructive, blacklist them by name to disable
+ * unnecessary dmesg warnings on all of their products.
+ */
 
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	/*
+	 * Disable OSI(Linux) warnings on all "Acer, inc."
+	 *
+	 * _OSI(Linux) disables the latest Windows BIOS code:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5050"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5580"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 3010"),
+	 * _OSI(Linux) effect unknown:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Ferrari 5000"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Acer, inc.",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer, inc."),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Acer"
+	 *
+	 * _OSI(Linux) effect unknown:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720Z"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 6460"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 7510"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
+	 */
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Acer",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Apple Computer, Inc."
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook2,1"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro2,2"),
+	 * _OSI(Linux) effect unknown:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacPro2,1"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro1,1"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3,1"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Apple",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "BenQ"
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Joybook S31"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "BenQ",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "BenQ"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Clevo Co."
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "M570RU"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Clevo",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Clevo Co."),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "COMPAL"
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_BOARD_NAME, "HEL8X"),
+	 * _OSI(Linux) unknown effect:
+	 * DMI_MATCH(DMI_BOARD_NAME, "IFL91"),
+	 */
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Compal",
+	.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+		},
+	},
+	{ /* OSI(Linux) touches USB, breaks suspend to disk */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell Dimension 5150",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Dell DM051"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1501"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D830"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX620"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1900"),
+		},
+	},
+	{ /* OSI(Linux) touches USB */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 390"),
+		},
+	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell Vostro 1000",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Vostro   1000"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dell",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge SC440"),
+		},
+	},
+	{ /* OSI(Linux) effect unknown */
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Dialogue Flybook V5",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dialogue Technology Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Flybook V5"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "FUJITSU SIEMENS"
+	 *
+	 * _OSI(Linux) disables latest Windows BIOS code:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 2510"),
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1536"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pi 1556"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Xi 1546"),
+	 * _OSI(Linux) unknown effect:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo M1425"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Amilo Si 1520"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * .ident = "HP Pavilion tx 1000"
+	 * DMI_MATCH(DMI_BOARD_NAME, "30BF"),
+	 * .ident = "HP Pavilion dv2000"
+	 * DMI_MATCH(DMI_BOARD_NAME, "30B5"),
+	 * .ident = "HP Pavilion dv5000",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30A7"),
+	 * .ident = "HP Pavilion dv6300 30BC",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30BC"),
+	 * .ident = "HP Pavilion dv6000",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30B7"),
+	 * DMI_MATCH(DMI_BOARD_NAME, "30B8"),
+	 * .ident = "HP Pavilion dv9000",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30B9"),
+	 * .ident = "HP Pavilion dv9500",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30CB"),
+	 * .ident = "HP/Compaq Presario C500",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30C6"),
+	 * .ident = "HP/Compaq Presario F500",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30D3"),
+	 * _OSI(Linux) unknown effect:
+	 * .ident = "HP Pavilion dv6500",
+	 * DMI_MATCH(DMI_BOARD_NAME, "30D0"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Hewlett-Packard",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		},
+	},
+	/*
+	 * Lenovo has a mix of systems OSI(Linux) situations
+	 * and thus we can not wildcard the vendor.
+	 *
 	 * _OSI(Linux) helps sound
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 * _OSI(Linux) is a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
 	 */
 	{
 	.callback = dmi_enable_osi_linux,
@@ -201,6 +453,97 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
 		},
 	},
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Lenovo 3000 V100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "LENOVO3000 V100"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Lenovo 3000 N100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "LG Electronics"
+	 *
+	 * _OSI(Linux) confirmed to be a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "P1-J150B"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "LG",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+		},
+	},
+	/* NEC - OSI(Linux) effect unknown */
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "NEC VERSA M360",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC Computers SAS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "NEC VERSA M360"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Samsung Electronics"
+	 *
+	 * OSI(Linux) disables PNP0C32 and other BIOS code for Windows:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "R40P/R41P"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "R59P/R60P/R61P"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Samsung",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "Sony Corporation"
+	 *
+	 * _OSI(Linux) is a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ650N"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SZ38GP_C"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-TZ21MN_N"),
+	 * _OSI(Linux) unknown effect:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ11M"),
+	 */
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Sony",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		},
+	},
+	/*
+	 * Disable OSI(Linux) warnings on all "TOSHIBA"
+	 *
+	 * _OSI(Linux) breaks sound (bugzilla 7787):
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P100"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P105"),
+	 * _OSI(Linux) is a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A100"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A210"),
+	 * _OSI(Linux) unknown effect:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A135"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A200"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P205"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U305"),
+	 */
+	{
+	.callback = dmi_disable_osi_linux,
+	.ident = "Toshiba",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		},
+	},
 	{}
 };
 
-- 
1.5.4.rc4.14.g6fc74

