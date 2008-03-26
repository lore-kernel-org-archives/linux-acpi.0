From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/6] ACPI: SBS: remove typo from sbchc.c
Date: Wed, 26 Mar 2008 01:13:35 -0400
Message-ID: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:48066 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752507AbYCZFWj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:22:39 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbshc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index a2cf300..bcf2c70 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -130,7 +130,6 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
 		goto end;
 	}
 	smb_hc_write(hc, ACPI_SMB_COMMAND, command);
-	smb_hc_write(hc, ACPI_SMB_COMMAND, command);
 	if (!(protocol & 0x01)) {
 		smb_hc_write(hc, ACPI_SMB_BLOCK_COUNT, length);
 		for (i = 0; i < length; ++i)
-- 
1.5.5.rc1.6.g5cc8f

