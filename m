From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 2/2] ACPI: SPCR: Workaround for APM X-Gene 8250 UART 32-alignment errata
Date: Mon,  3 Jul 2017 14:33:09 -0700
Message-ID: <1499117589-4829-3-git-send-email-lho@apm.com>
References: <1499117589-4829-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35397 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbdGCVdP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 17:33:15 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so105327907pfk.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jul 2017 14:33:14 -0700 (PDT)
In-Reply-To: <1499117589-4829-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael@kernel.org, jon.mason@broadcom.com
Cc: jcm@redhat.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, bcm-kernel-feedback-list@broadcom.com, aleksey.makarov@linaro.org, gregkh@linuxfoundation.org, patches@apm.com, Loc Ho <lho@apm.com>

APM X-Gene verion 1 and 2 have an 8250 UART with its register
aligned to 32-bit. In addition, the latest released BIOS
encodes the access field as 8-bit access instead 32-bit access.
This causes no console with ACPI boot as the console
will not match X-Gene UART port due to the lack of mmio32
option.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/spcr.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 2905063..4ac3e06 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -36,6 +36,26 @@ static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
 	return false;
 }
 
+/*
+ * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
+ * register aligned to 32-bit. In addition, the BIOS also encoded the
+ * access width to be 8 bits. This function detects this errata condition.
+ */
+static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
+{
+	if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
+		return false;
+
+	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
+		return false;
+
+	if (!memcmp(tb->header.oem_table_id, "XGENESPC",
+	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
+		return true;
+
+	return false;
+}
+
 /**
  * parse_spcr() - parse ACPI SPCR table and add preferred console
  *
@@ -129,6 +149,8 @@ int __init parse_spcr(bool earlycon)
 
 	if (qdf2400_erratum_44_present(&table->header))
 		uart = "qdf2400_e44";
+	if (xgene_8250_erratum_present(table))
+		iotype = "mmio32";
 
 	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 		 table->serial_port.address, baud_rate);
-- 
1.8.3.1

