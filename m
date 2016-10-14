From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] mailbox: PCC: Fix return value of pcc_mbox_request_channel()
Date: Fri, 14 Oct 2016 16:20:21 -0700
Message-ID: <1476487221-20337-1-git-send-email-hotran@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33734 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbcJNXVF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Oct 2016 19:21:05 -0400
Received: by mail-pa0-f43.google.com with SMTP id vu5so50234898pab.0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Oct 2016 16:21:05 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Prakash Prashanth <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, devel@acpica.org, Hoan Tran <hotran@apm.com>

When CONFIG_PCC is disabled, pcc_mbox_request_channel() needs to
return ERR_PTR(-ENODEV), not a NULL pointer, as the callers of
this function use IS_ERR() to check for error code.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Hoan Tran <hotran@apm.com>
---
 include/acpi/pcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 17a940a..8caa79c 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -21,7 +21,7 @@ extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 static inline struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 							 int subspace_id)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct mbox_chan *chan) { }
 #endif
-- 
1.9.1

