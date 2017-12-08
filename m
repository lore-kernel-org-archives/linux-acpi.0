From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi: add NFIT and HMAT to the initrd override list
Date: Fri, 08 Dec 2017 08:29:25 -0800
Message-ID: <151275056532.8020.17160155121603376532.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19700 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbdLHQhy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 11:37:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-nvdimm@lists.01.org

These tables, NFIT and HMAT, are essential for describing
next-generation platform memory topologies and performance
characteristics. Allow them to be overridden for debug and test and
purposes.

Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/tables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 80ce2a7d224b..67a44fd79449 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -456,7 +456,8 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_NFIT,
+	ACPI_SIG_HMAT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 

