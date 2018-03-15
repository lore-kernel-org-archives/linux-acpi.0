From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v3 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Wed, 14 Mar 2018 20:04:44 -0600
Message-ID: <20180315020445.150604-3-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315020445.150604-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
earlycon setup handler to configure its input clock in order to compute
baud rate divisor registers.
Detect them by examining the OEMID field in the SPCR header, and pass
then pass uart type amdcz to earlycon.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v1:
 * added Reviewed-by

 drivers/acpi/spcr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 9d52743080a4..52d840d0e05b 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -73,6 +73,24 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
 	return xgene_8250;
 }
 
+/*
+ * AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
+ * earlycon setup handler to configure its input clock in order to compute
+ * baud rate divisor registers.
+ * Detect them by examining the OEM fields in the SPCR header.
+ */
+static bool amdcz_present(struct acpi_table_spcr *tb)
+{
+	if (memcmp(tb->header.oem_id, "AMDCZ ", ACPI_OEM_ID_SIZE))
+		return false;
+
+	if (memcmp(tb->header.oem_table_id, "AMDCZ   ",
+		    ACPI_OEM_TABLE_ID_SIZE))
+		return false;
+
+	return true;
+}
+
 /**
  * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
  *
@@ -189,6 +207,11 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 			uart = "qdf2400_e44";
 	}
 
+	if (amdcz_present(table)) {
+		if (enable_earlycon)
+			uart = "amdcz";
+	}
+
 	if (xgene_8250_erratum_present(table)) {
 		iotype = "mmio32";
 
-- 
2.16.2.804.g6dcf76e118-goog
