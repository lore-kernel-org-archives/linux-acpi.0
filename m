From: Timur Tabi <timur@codeaurora.org>
Subject: [PATCH] ACPI / CPPC: remove redundant mbox_send_message() declaration
Date: Tue, 26 Jan 2016 12:43:00 -0600
Message-ID: <1453833780-28099-1-git-send-email-timur@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35489 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcAZSnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2016 13:43:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, pprakash@codeaurora.org

Remove a redundant function declaration in cppc_acpi.h for
mbox_send_message().  That function is defined in mailbox_client.h,
which is already included.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 include/acpi/cppc_acpi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 717a298..dad8af3 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -133,6 +133,5 @@ extern int acpi_get_psd_map(struct cpudata **);
 /* Methods to interact with the PCC mailbox controller. */
 extern struct mbox_chan *
 	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
-extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
 
 #endif /* _CPPC_ACPI_H*/
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

