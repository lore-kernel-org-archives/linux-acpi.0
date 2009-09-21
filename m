From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 12/17] ACPI: enumerate namespace before adding functional
	fixed hardware devices
Date: Mon, 21 Sep 2009 13:29:45 -0600
Message-ID: <20090921192945.21322.61922.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:32769 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZIUT3m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:42 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch changes the order so we enumerate in the "root, namespace,
functional fixed" order instead of the "root, functional fixed, namespace"
order.  When I change acpi_bus_scan() to use acpi_walk_namespace(), it
will use the former order, so this patch isolates the order change for
bisectability.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4fe7359..27d2dec 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1650,10 +1650,10 @@ int __init acpi_scan_init(void)
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-	result = acpi_bus_scan_fixed();
+	result = acpi_bus_scan(acpi_root->handle, &ops);
 
 	if (!result)
-		result = acpi_bus_scan(acpi_root->handle, &ops);
+		result = acpi_bus_scan_fixed();
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);

