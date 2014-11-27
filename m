From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/6] ACPICA: Disassembler: Emit correct string for 0 stop bits.
Date: Thu, 27 Nov 2014 14:26:28 +0800
Message-ID: <6a3b2fcc1aaad67e0a02ee24402db0d284948a84.1416899966.git.lv.zheng@intel.com>
References: <cover.1416899966.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1416899966.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, "David E. Box" <david.e.box@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Was stop_bits_none, corrected to stop_bits_zero.
David E. Box.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 5cd017c..bc1ff82 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -263,7 +263,7 @@ const char *acpi_gbl_bpb_decode[] = {
 /* UART serial bus stop bits */
 
 const char *acpi_gbl_sb_decode[] = {
-	"StopBitsNone",
+	"StopBitsZero",
 	"StopBitsOne",
 	"StopBitsOnePlusHalf",
 	"StopBitsTwo"
-- 
1.7.10
