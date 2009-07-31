From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 14/19] ACPI: enumerate namespace before adding functional
	fixed hardware devices
Date: Fri, 31 Jul 2009 15:37:44 -0600
Message-ID: <20090731213744.29930.45532.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:36051 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbZGaVhp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:37:45 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
index afd10b5..b97b2ad 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1606,10 +1606,10 @@ int __init acpi_scan_init(void)
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

