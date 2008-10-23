From: Len Brown <lenb@kernel.org>
Subject: [PATCH 052/122] ACPI: EC: Check for IBF=0 periodically if not in GPE
 mode
Date: Thu, 23 Oct 2008 02:38:26 -0400
Message-ID: <c0ff17720ec5f42205b3d2ca03a18da0a8272976.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbYJWGkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KA0IIOS8A2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:01 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 453ba1e..444cd9e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -298,6 +298,18 @@ static int ec_check_ibf0(struct acpi_ec *ec)
 	return (status & ACPI_EC_FLAG_IBF) == 0;
 }
 
+static int ec_wait_ibf0(struct acpi_ec *ec)
+{
+	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+	/* interrupt wait manually if GPE mode is not active */
+	unsigned long timeout = test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ?
+		msecs_to_jiffies(ACPI_EC_DELAY) : msecs_to_jiffies(1);
+	while (time_before(jiffies, delay))
+		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec), timeout))
+			return 0;
+	return -ETIME;
+}
+
 static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
 			       int force_poll)
 {
@@ -315,8 +327,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
 			goto unlock;
 		}
 	}
-	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
-				msecs_to_jiffies(ACPI_EC_DELAY))) {
+	if (ec_wait_ibf0(ec)) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
 		status = -ETIME;
-- 
1.5.5.1

