From: Jon Mason <jdmason@kudzu.us>
Subject: [PATCH] acpi: 80 char overflow
Date: Sun, 19 Jun 2011 18:51:37 -0500
Message-ID: <20110619235136.GA6004@kudzu.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63848 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab1FSXvn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jun 2011 19:51:43 -0400
Received: by pvg12 with SMTP id 12so302027pvg.19
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jun 2011 16:51:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, trivial@kernel.org

Trivial fix for 80 char line overflow in drivers/acpi/pci_root.c

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/acpi/pci_root.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d06078d..2672c79 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -485,7 +485,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 		root->secondary.end = 0xFF;
 		printk(KERN_WARNING FW_BUG PREFIX
 		       "no secondary bus range in _CRS\n");
-		status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN,					       NULL, &bus);
+		status = acpi_evaluate_integer(device->handle, METHOD_NAME__BBN,
+					       NULL, &bus);
 		if (ACPI_SUCCESS(status))
 			root->secondary.start = bus;
 		else if (status == AE_NOT_FOUND)
-- 
1.7.5.4

