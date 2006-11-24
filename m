From: Len Brown <len.brown@intel.com>
Subject: [PATCH 28/65] ACPICA: Update comments in tbfadt.c
Date: Fri, 24 Nov 2006 02:18:38 -0500
Message-ID: <11643527891947-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934473AbWKXHPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:53 -0500
In-Reply-To: <1164352788512-git-send-email-len.brown@intel.com>
Message-Id: <f9be8a6f16cc421158078ede60ccb24c06267704.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 2336a72..62485d3 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -195,8 +195,8 @@ void acpi_tb_parse_fadt(acpi_native_uint
  *
  * DESCRIPTION: Converts all versions of the FADT to a common internal format.
  *
- * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt), and must contain
- *              a copy of the actual FADT.
+ * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt),
+ *              and must contain a copy of the actual FADT.
  *
  * ACPICA will use the "X" fields of the FADT for all addresses.
  *
@@ -292,9 +292,10 @@ static void acpi_tb_convert_fadt(void)
  *
  * PARAMETERS:  None
  *
- * RETURN:      Status
+ * RETURN:      None
  *
- * DESCRIPTION: Validate various ACPI registers in the FADT
+ * DESCRIPTION: Validate various ACPI registers in the FADT. For problems,
+ *              issue a message, but no status is returned.
  *
  ******************************************************************************/
 
@@ -375,6 +376,6 @@ static void acpi_tb_validate_fadt(void)
 static void acpi_tb_fadt_register_error(char *register_name, u32 value)
 {
 
-	ACPI_WARNING((AE_INFO, "Invalid FADT value \"%s\" = %X",
+	ACPI_WARNING((AE_INFO, "Invalid FADT value in field \"%s\" = %X",
 		      register_name, value));
 }
-- 
1.4.4.1
