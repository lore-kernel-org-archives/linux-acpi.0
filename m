From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/20] ACPICA: Disassembler: Remove duplicate code in _PLD processing.
Date: Tue, 25 Aug 2015 10:28:32 +0800
Message-ID: <7a21df9c35b438a525ff3e9ca1374f3b7298afb0.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6d9c827b540837b6e54059e17756a06985e4a196

ACPICA BZ 1176.

Link: https://bugs.acpica.org/show_bug.cgi?id=1176
Link: https://github.com/acpica/acpica/commit/6d9c827b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxface.c |    5 +++--
 include/acpi/acbuffer.h       |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 51cf52d..c2bd5e2 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -517,7 +517,8 @@ acpi_decode_pld_buffer(u8 *in_buffer,
 
 	/* Parameter validation */
 
-	if (!in_buffer || !return_buffer || (length < 16)) {
+	if (!in_buffer || !return_buffer
+	    || (length < ACPI_PLD_REV1_BUFFER_SIZE)) {
 		return (AE_BAD_PARAMETER);
 	}
 
@@ -567,7 +568,7 @@ acpi_decode_pld_buffer(u8 *in_buffer,
 	pld_info->rotation = ACPI_PLD_GET_ROTATION(&dword);
 	pld_info->order = ACPI_PLD_GET_ORDER(&dword);
 
-	if (length >= ACPI_PLD_BUFFER_SIZE) {
+	if (length >= ACPI_PLD_REV2_BUFFER_SIZE) {
 
 		/* Fifth 32-bit DWord (Revision 2 of _PLD) */
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 6b040f4..fcf9080 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -147,6 +147,7 @@ struct acpi_pld_info {
  *        (Intended for BIOS use only)
  */
 #define ACPI_PLD_REV1_BUFFER_SIZE               16	/* For Revision 1 of the buffer (From ACPI spec) */
+#define ACPI_PLD_REV2_BUFFER_SIZE               20	/* For Revision 2 of the buffer (From ACPI spec) */
 #define ACPI_PLD_BUFFER_SIZE                    20	/* For Revision 2 of the buffer (From ACPI spec) */
 
 /* First 32-bit dword, bits 0:32 */
-- 
1.7.10
