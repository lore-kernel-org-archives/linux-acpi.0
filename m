From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] mailbox: pcc: Add PCC request and free channel declarations
Date: Tue, 14 Jun 2016 16:12:43 -0700
Message-ID: <1465945963-22353-1-git-send-email-hotran@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34305 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbcFNXNA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2016 19:13:00 -0400
Received: by mail-pf0-f181.google.com with SMTP id 62so2053117pfd.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jun 2016 16:12:59 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>

As PCC will be used by other clients not only CPPC.
This change exports pcc_mbox_request_channel() and pcc_mbox_free_channel()
declarations

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 include/acpi/cppc_acpi.h       | 4 ----
 include/linux/mailbox_client.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index dad8af3..819b4b9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -130,8 +130,4 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cpudata **);
 
-/* Methods to interact with the PCC mailbox controller. */
-extern struct mbox_chan *
-	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
-
 #endif /* _CPPC_ACPI_H*/
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 41e2af8..2758d18 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -50,4 +50,8 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
 
+/* Methods to interact with the PCC mailbox controller. */
+struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *, int);
+void pcc_mbox_free_channel(struct mbox_chan *chan);
+
 #endif /* __MAILBOX_CLIENT_H */
-- 
1.9.1

