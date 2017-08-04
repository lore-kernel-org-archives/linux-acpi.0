From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 1/2] ACPI: SPCR: extend XGENE 8250 workaround to m400
Date: Fri,  4 Aug 2017 22:49:43 +0100
Message-ID: <20170804214944.3910-2-graeme.gregory@linaro.org>
References: <20170804214944.3910-1-graeme.gregory@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38765 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdHDVtx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 17:49:53 -0400
Received: by mail-wr0-f180.google.com with SMTP id f21so20963878wrf.5
        for <linux-acpi@vger.kernel.org>; Fri, 04 Aug 2017 14:49:53 -0700 (PDT)
In-Reply-To: <20170804214944.3910-1-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, lho@apm.com, gregkh@linuxfoundation.org, jcm@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>

xgene v1/v2 chips are also used on moonshot cartridges that have
different table headers to the ones on Mustang. Extend the quirk
so it also recognises the Moonshot M400 variant too.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/spcr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 4ac3e06b41d8..1457ef0b0fd5 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -43,17 +43,24 @@ static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
  */
 static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
 {
+	bool xgene_8250 = false;
+
 	if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
 		return false;
 
-	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
+	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE) &&
+	    memcmp(tb->header.oem_id, "HPE   ", ACPI_OEM_ID_SIZE))
 		return false;
 
 	if (!memcmp(tb->header.oem_table_id, "XGENESPC",
 	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
-		return true;
+		xgene_8250 = true;
 
-	return false;
+	if (!memcmp(tb->header.oem_table_id, "ProLiant",
+	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 1)
+		xgene_8250 = true;
+
+	return xgene_8250;
 }
 
 /**
-- 
2.13.4

