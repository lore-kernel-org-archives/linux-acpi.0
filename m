From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/6] thinkpad-acpi: fix sign of ERESTARTSYS return
Date: Wed, 25 Nov 2009 01:11:58 -0500
Message-ID: <80a8d1228e90349b4514e8c925c061fa5cbcea75.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:41538 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZKYGMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:21 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN00052IK5DISQ@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:06 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
In-reply-to: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

The returned error should be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d93108d..03c0a56 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6313,7 +6313,7 @@ static int brightness_write(char *buf)
 	 * Doing it this way makes the syscall restartable in case of EINTR
 	 */
 	rc = brightness_set(level);
-	return (rc == -EINTR)? ERESTARTSYS : rc;
+	return (rc == -EINTR)? -ERESTARTSYS : rc;
 }
 
 static struct ibm_struct brightness_driver_data = {
-- 
1.6.0.6

