From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/30] ACPICA: Interpreter: Update some function headers, no functional change
Date: Thu, 24 Mar 2016 09:39:58 +0800
Message-ID: <7c48db35c36e28e80d1746652748cfb31052e1f8.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit e068948f49eb61a78c211028976a174604c5644a

Fix some issues in the exutils.c file.

Link: https://github.com/acpica/acpica/commit/e068948f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exutils.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 4d44bc1..425f133 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -301,8 +301,8 @@ static u32 acpi_ex_digits_needed(u64 value, u32 base)
  *
  * FUNCTION:    acpi_ex_eisa_id_to_string
  *
- * PARAMETERS:  compressed_id   - EISAID to be converted
- *              out_string      - Where to put the converted string (8 bytes)
+ * PARAMETERS:  out_string      - Where to put the converted string (8 bytes)
+ *              compressed_id   - EISAID to be converted
  *
  * RETURN:      None
  *
@@ -354,7 +354,7 @@ void acpi_ex_eisa_id_to_string(char *out_string, u64 compressed_id)
  *                                possible 64-bit integer.
  *              value           - Value to be converted
  *
- * RETURN:      None, string
+ * RETURN:      Converted string in out_string
  *
  * DESCRIPTION: Convert a 64-bit integer to decimal string representation.
  *              Assumes string buffer is large enough to hold the string. The
@@ -384,9 +384,9 @@ void acpi_ex_integer_to_string(char *out_string, u64 value)
  * FUNCTION:    acpi_ex_pci_cls_to_string
  *
  * PARAMETERS:  out_string      - Where to put the converted string (7 bytes)
- * PARAMETERS:  class_code      - PCI class code to be converted (3 bytes)
+ *              class_code      - PCI class code to be converted (3 bytes)
  *
- * RETURN:      None
+ * RETURN:      Converted string in out_string
  *
  * DESCRIPTION: Convert 3-bytes PCI class code to string representation.
  *              Return buffer must be large enough to hold the string. The
@@ -417,7 +417,7 @@ void acpi_ex_pci_cls_to_string(char *out_string, u8 class_code[3])
  *
  * PARAMETERS:  space_id            - ID to be validated
  *
- * RETURN:      TRUE if valid/supported ID.
+ * RETURN:      TRUE if space_id is a valid/supported ID.
  *
  * DESCRIPTION: Validate an operation region space_ID.
  *
-- 
1.7.10
