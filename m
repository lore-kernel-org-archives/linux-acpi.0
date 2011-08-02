From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/27] ACPI: fix 80 char overflow
Date: Tue, 02 Aug 2011 16:53:17 -0400
Message-ID: <e545b55a1e980cbb6a158886286106bbf39722b1.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab1HBVwA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:00 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:51:58 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Len Brown <len.brown@intel.com>

From: Jon Mason <jdmason@kudzu.us>

Trivial fix for 80 char line overflow in drivers/acpi/pci_root.c

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.6.396.ge0613

