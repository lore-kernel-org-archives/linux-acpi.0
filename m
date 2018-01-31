From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH] ACPI/PCI: pci_link: remove error messages when no _PRS methods
Date: Tue, 30 Jan 2018 21:52:19 -0800
Message-ID: <1517377939-9817-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36619 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeAaFwX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 00:52:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, alex.hung@canonical.com

In recent Intel hardware the IRQs become non-configurable after BIOS
initializes them in PEI phase and _PRS objects are no longer included in
ASL.

This is the same as "static (non-configurable) devices do not
specify a _PRS object" in ACPI spec. As a result, error messages
saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" are not
needed.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/pci_link.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 85ad679390e3..f98215971f30 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -172,10 +172,8 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
+	if (ACPI_FAILURE(status))
 		return -ENODEV;
-	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Found %d possible IRQs\n",
-- 
2.15.1

