From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] trival: fix acpi_hest_firmware_first_pci() caused oops
Date: Thu,  8 Apr 2010 11:16:15 +0800
Message-ID: <1270696575-3385-1-git-send-email-shaohua.li@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39887 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab0DHDQZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Apr 2010 23:16:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, Shaohua Li <shaohua.li@intel.com>

acpi_hest_firmware_first_pci() could be called when acpi is disabled
and cause system oops.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/hest.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/hest.c b/drivers/acpi/hest.c
index 4bb18c9..1c527a1 100644
--- a/drivers/acpi/hest.c
+++ b/drivers/acpi/hest.c
@@ -123,6 +123,10 @@ int acpi_hest_firmware_first_pci(struct pci_dev *pci)
 {
 	acpi_status status = AE_NOT_FOUND;
 	struct acpi_table_header *hest = NULL;
+
+	if (acpi_disabled)
+		return 0;
+
 	status = acpi_get_table(ACPI_SIG_HEST, 1, &hest);
 
 	if (ACPI_SUCCESS(status)) {
-- 
1.6.3.3

