From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/5] ACPI: EC: revert msleep patch
Date: Sun, 09 Nov 2008 19:00:43 +0300
Message-ID: <20081109160043.13635.81489.stgit@thinkpad>
References: <20081109155847.13635.15244.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43017 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755270AbYKIQAq (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 11:00:46 -0500
In-Reply-To: <20081109155847.13635.15244.stgit@thinkpad>
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
index 523ac5b..e5dbe21 100644
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

