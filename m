From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH v2] ACPI: SPCR: Use access width to determine mmio usage
Date: Fri,  5 May 2017 17:55:12 -0400
Message-ID: <1494021312-4107-1-git-send-email-jon.mason@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-acpi@vger.kernel.org

The current SPCR code does not check the access width of the mmio, and
uses a default of 8bit register accesses.  This prevents devices that
only do 16 or 32bit register accesses from working.  By simply checking
this field and setting the mmio string appropriately, this issue can be
corrected.  To prevent any legacy issues, the code will default to 8bit
accesses if the value is anything but 16 or 32.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 drivers/acpi/spcr.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 01c94669a2b0..63b690d142f1 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
 		goto done;
 	}
 
-	iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
-			"mmio" : "io";
+	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		switch (1 << (table->serial_port.access_width + 2)) {
+		default:
+			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+		case 8:
+			iotype = "mmio";
+			break;
+		case 16:
+			iotype = "mmio16";
+			break;
+		case 32:
+			iotype = "mmio32";
+			break;
+		}
+	} else
+		iotype = "io";
 
 	switch (table->interface_type) {
 	case ACPI_DBG2_ARM_SBSA_32BIT:
-- 
2.7.4
