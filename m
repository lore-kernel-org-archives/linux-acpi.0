From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/21] ACPI: EC: revert msleep patch
Date: Thu, 06 Nov 2008 23:39:06 -0500
Message-ID: <f3b900211a24952b60f4c1ce1272f0d70a03d017.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64771 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYKGEji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y00JG94XR0PN1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:28 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

With the better solution for EC interrupt storm issue,
there is no need to use msleep over udelay.

References:
	http://bugzilla.kernel.org/show_bug.cgi?id=11810
	http://bugzilla.kernel.org/show_bug.cgi?id=10724

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ef42316..3ef5b79 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -239,10 +239,10 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
 static int ec_poll(struct acpi_ec *ec)
 {
 	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-	msleep(1);
+	udelay(ACPI_EC_UDELAY);
 	while (time_before(jiffies, delay)) {
 		gpe_transaction(ec, acpi_ec_read_status(ec));
-		msleep(1);
+		udelay(ACPI_EC_UDELAY);
 		if (ec_transaction_done(ec))
 			return 0;
 	}
-- 
1.5.6.5

