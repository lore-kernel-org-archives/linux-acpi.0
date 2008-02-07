From: Len Brown <lenb@kernel.org>
Subject: [PATCH 076/112] ACPI: blacklist update
Date: Thu,  7 Feb 2008 04:34:38 -0500
Message-ID: <a64217b922e5a06f328e3962ff903ce829aff3d6.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755149AbYBGJgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:32 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

move some OSI(Linux) to "disable" from "unknown"
to reduce dmesg lines that we don't really need.

update Acer 5315 comment
update Dell entries, add R200 entry
update Apple entries

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bd12c8e..6dbaa2d 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -70,8 +70,6 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
 	/* IBM 600E - _ADR should return 7, but it returns 1 */
 	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Incorrect _ADR", 1},
-	{"ASUS\0\0", "P2B-S   ", 0, ACPI_SIG_DSDT, all_versions,
-	 "Bogus PCI routing", 1},
 
 	{""}
 };
@@ -225,16 +223,18 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * Disable OSI(Linux) warnings on all "Acer"
 	 *
 	 * _OSI(Linux) effect unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720Z"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 6460"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 7510"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
+	 *
+	 * _OSI(Linux) is a NOP:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
 	 */
 	{
-	.callback = dmi_unknown_osi_linux,
+	.callback = dmi_disable_osi_linux,
 	.ident = "Acer",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
@@ -242,21 +242,22 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	/*
 	 * Disable OSI(Linux) warnings on all "Apple Computer, Inc."
+	 * Disable OSI(Linux) warnings on all "Apple Inc."
 	 *
 	 * _OSI(Linux) confirmed to be a NOP:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBook2,1"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro2,2"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3,1"),
 	 * _OSI(Linux) effect unknown:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacPro2,1"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro1,1"),
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3,1"),
 	 */
 	{
 	.callback = dmi_disable_osi_linux,
 	.ident = "Apple",
 	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple"),
 		},
 	},
 	/*
@@ -294,7 +295,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * DMI_MATCH(DMI_BOARD_NAME, "IFL91"),
 	 */
 	{
-	.callback = dmi_unknown_osi_linux,
+	.callback = dmi_disable_osi_linux,
 	.ident = "Compal",
 	.matches = {
 		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
@@ -310,7 +311,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) is a NOP */
 	.callback = dmi_disable_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell i1501",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1501"),
@@ -318,7 +319,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell Latitude D830",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D830"),
@@ -326,7 +327,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell OP GX620",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX620"),
@@ -334,15 +335,23 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell PE 1900",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1900"),
 		},
 	},
+	{ /* OSI(Linux) is a NOP */
+	.callback = dmi_disable_osi_linux,
+	.ident = "Dell PE R200",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R200"),
+		},
+	},
 	{ /* OSI(Linux) touches USB */
 	.callback = dmi_disable_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell PR 390",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 390"),
@@ -358,7 +367,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{ /* OSI(Linux) effect unknown */
 	.callback = dmi_unknown_osi_linux,
-	.ident = "Dell",
+	.ident = "Dell PE SC440",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		     DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge SC440"),
@@ -521,7 +530,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ11M"),
 	 */
 	{
-	.callback = dmi_unknown_osi_linux,
+	.callback = dmi_disable_osi_linux,
 	.ident = "Sony",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-- 
1.5.4.23.gef5b9

