From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 05/19] ACPI: remove unused acpi_bus_scan_fixed() argument
Date: Mon, 31 Aug 2009 16:32:31 -0600
Message-ID: <20090831223231.11814.12248.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:30441 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZHaWcY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:24 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We never use the "root" argument, so just remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3c23d68..177f1b4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1583,15 +1583,12 @@ int acpi_bus_trim(struct acpi_device *start, int rmdevice)
 }
 EXPORT_SYMBOL_GPL(acpi_bus_trim);
 
-static int acpi_bus_scan_fixed(struct acpi_device *root)
+static int acpi_bus_scan_fixed(void)
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
 	struct acpi_bus_ops ops;
 
-	if (!root)
-		return -ENODEV;
-
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 	ops.acpi_op_start = 1;
@@ -1642,7 +1639,7 @@ int __init acpi_scan_init(void)
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-	result = acpi_bus_scan_fixed(acpi_root);
+	result = acpi_bus_scan_fixed();
 
 	if (!result)
 		result = acpi_bus_scan(acpi_root, &ops);

