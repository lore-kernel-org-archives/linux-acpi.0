From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/12] ACPI: fix section mismatch in acpi_pci_root_add
Date: Tue, 11 Mar 2008 02:51:40 -0400
Message-ID: <b5678a34762edf2c8de1c60c125fea42a8c17e63.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:14880 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754033AbYCKGyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:54 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Len Brown <len.brown@intel.com>

From: Sam Ravnborg <sam@ravnborg.org>

Fix following warning:
WARNING: vmlinux.o(.text+0x550e85): Section mismatch in reference from the function acpi_pci_root_add() to the function .devinit.text:pci_acpi_scan_root()

acpi_pci_root_add uses a __devinit annotated function and
it looks like annotating it __devinit too is the correct fix.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f14ff1f..c3fed31 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -184,7 +184,7 @@ static void acpi_pci_bridge_scan(struct acpi_device *device)
 		}
 }
 
-static int acpi_pci_root_add(struct acpi_device *device)
+static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_pci_root *root = NULL;
-- 
1.5.4.3.422.g34cd6

