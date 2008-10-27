From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: revert msleep patch
Date: Tue, 28 Oct 2008 00:35:30 +0300
Message-ID: <20081027213530.7104.27639.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39829 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbYJ0Vf2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 17:35:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

With the better solution for EC interrupt storm issue,
there is no need to use msleep over udelay.

References:
	http://bugzilla.kernel.org/show_bug.cgi?id=11810
	http://bugzilla.kernel.org/show_bug.cgi?id=10724


Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

