From: Len Brown <lenb@kernel.org>
Subject: [PATCH 071/112] ACPI: remove redundant Acer blacklist entry
Date: Thu,  7 Feb 2008 04:34:33 -0500
Message-ID: <8964ebb8c35533f4084cc667079a0ce620356104.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754817AbYBGJga (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:30 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

dmi_check_system() does sub-string matching using strstr(),
rather than exact string compares with !strcmp().

So delete the longer of the Acer blacklist entries, as its
function is just a redundant console message.

Spotted-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 8809654..9ace219 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -214,13 +214,11 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * _OSI(Linux) effect unknown:
 	 * DMI_MATCH(DMI_PRODUCT_NAME, "Ferrari 5000"),
 	 */
-	{
-	.callback = dmi_disable_osi_linux,
-	.ident = "Acer, inc.",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Acer, inc."),
-		},
-	},
+	/*
+	 * note that dmi_check_system() uses strstr()
+	 * to match sub-strings rather than !strcmp(),
+	 * so "Acer" below matches "Acer, inc." above.
+	 */
 	/*
 	 * Disable OSI(Linux) warnings on all "Acer"
 	 *
-- 
1.5.4.23.gef5b9

