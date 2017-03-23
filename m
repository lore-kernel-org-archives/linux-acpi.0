From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH] ACPI / IPMI: change warning to debug on timeout
Date: Thu, 23 Mar 2017 11:32:29 -0400
Message-ID: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Getting timeout message from BMC when trying to read from a non-existent
FRU. This is expected but warning is not.

Let's reduce the warning to debug.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/acpi_ipmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 747c2ba..1b64419 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -429,8 +429,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
 	    msg->msg.data_len == 1) {
 		if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
-			dev_WARN_ONCE(dev, true,
-				      "Unexpected response (timeout).\n");
+			dev_dbg_once(dev, "Unexpected response (timeout).\n");
 			tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
 		}
 		goto out_comp;
-- 
1.9.1
