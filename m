From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH v2] mailbox: pcc: Don't access an unmapped memory address space
Date: Wed,  6 Apr 2016 21:59:49 -0500
Message-ID: <1459997989-19640-1-git-send-email-shankerd@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47707 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcDGC74 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2016 22:59:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>, Shanker Donthineni <shankerd@codeaurora.org>

The acpi_pcc_probe() could end up accessing memory outside of the
PCCT table space which might cause the kernel panic(). Increment the
pcct_entry pointer after parsing 'HW-reduced Communications Subspace'
to fix the problem. This change also enables the parsing of subtable
at index 0.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
Changes since v1:
    Edit commit message.

 drivers/mailbox/pcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0ddf638..043828d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -361,8 +361,6 @@ static int __init acpi_pcc_probe(void)
 		struct acpi_generic_address *db_reg;
 		struct acpi_pcct_hw_reduced *pcct_ss;
 		pcc_mbox_channels[i].con_priv = pcct_entry;
-		pcct_entry = (struct acpi_subtable_header *)
-			((unsigned long) pcct_entry + pcct_entry->length);
 
 		/* If doorbell is in system memory cache the virt address */
 		pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
@@ -370,6 +368,8 @@ static int __init acpi_pcc_probe(void)
 		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 			pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
 							db_reg->bit_width/8);
+		pcct_entry = (struct acpi_subtable_header *)
+			((unsigned long) pcct_entry + pcct_entry->length);
 	}
 
 	pcc_mbox_ctrl.num_chans = count;
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project

