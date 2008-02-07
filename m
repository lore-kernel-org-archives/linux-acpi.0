From: Len Brown <lenb@kernel.org>
Subject: [PATCH 073/112] ACPI: update blacklist comments
Date: Thu,  7 Feb 2008 04:34:35 -0500
Message-ID: <d0280a02f7412f3fdd45fbd2f51f59d7d8a03fe8.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754985AbYBGJgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:31 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

...based on additional feedback -- no code change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 9ace219..bd12c8e 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -208,7 +208,9 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * Disable OSI(Linux) warnings on all "Acer, inc."
 	 *
 	 * _OSI(Linux) disables the latest Windows BIOS code:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3100"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5050"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5580"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 3010"),
 	 * _OSI(Linux) effect unknown:
@@ -223,7 +225,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * Disable OSI(Linux) warnings on all "Acer"
 	 *
 	 * _OSI(Linux) effect unknown:
-	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720Z"),
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5520"),
@@ -298,7 +300,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
 		},
 	},
-	{ /* OSI(Linux) touches USB, breaks suspend to disk */
+	{ /* OSI(Linux) touches USB, unknown side-effect */
 	.callback = dmi_disable_osi_linux,
 	.ident = "Dell Dimension 5150",
 	.matches = {
@@ -472,6 +474,11 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 *
 	 * _OSI(Linux) confirmed to be a NOP:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "P1-J150B"),
+	 * with DMI_MATCH(DMI_BOARD_NAME, "ROCKY"),
+	 *
+	 * unknown:
+	 * DMI_MATCH(DMI_PRODUCT_NAME, "S1-MDGDG"),
+	 * with DMI_MATCH(DMI_BOARD_NAME, "ROCKY"),
 	 */
 	{
 	.callback = dmi_disable_osi_linux,
-- 
1.5.4.23.gef5b9

