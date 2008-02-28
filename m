From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: SBS: remove typo from sbchc.c
Date: Thu, 28 Feb 2008 19:17:39 +0300
Message-ID: <20080228161739.5909.19415.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35765 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753348AbYB1QRr (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 28 Feb 2008 11:17:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

