From: Jon Mason <jon.mason@broadcom.com>
Subject: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Thu,  4 May 2017 11:05:30 -0400
Message-ID: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com>
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
 drivers/acpi/spcr.c     | 18 ++++++++++++++++--
 include/acpi/acrestyp.h |  7 +++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 01c9466..11233f6 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
 		goto done;
 	}
 
-	iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
-			"mmio" : "io";
+	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		switch (table->serial_port.access_width) {
+		default:
+			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+		case ACPI_ACCESS_SIZE_BYTE:
+			iotype = "mmio";
+			break;
+		case ACPI_ACCESS_SIZE_WORD:
+			iotype = "mmio16";
+			break;
+		case ACPI_ACCESS_SIZE_DWORD:
+			iotype = "mmio32";
+			break;
+		}
+	} else
+		iotype = "io";
 
 	switch (table->interface_type) {
 	case ACPI_DBG2_ARM_SBSA_32BIT:
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index f0f7403..781cb55 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
 	u64 address;
 };
 
+/* Generic Address Space Access Sizes */
+#define ACPI_ACCESS_SIZE_UNDEFINED		0
+#define ACPI_ACCESS_SIZE_BYTE			1
+#define ACPI_ACCESS_SIZE_WORD			2
+#define ACPI_ACCESS_SIZE_DWORD			3
+#define ACPI_ACCESS_SIZE_QWORD			4
+
 struct acpi_resource_gpio {
 	u8 revision_id;
 	u8 connection_type;
-- 
2.7.4
