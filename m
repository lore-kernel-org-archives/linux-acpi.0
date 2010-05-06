From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/9] ACPI: fix acpi_hest_firmware_first_pci() caused oops
Date: Thu, 06 May 2010 03:03:21 -0400
Message-ID: <4bdae98f1a456ea1fea5ea02f9249d23bceab75b.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:40062 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0EFHDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:44 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00LQKKXSABZ4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:33 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

acpi_hest_firmware_first_pci() could be called when acpi is disabled
and cause system oops.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

