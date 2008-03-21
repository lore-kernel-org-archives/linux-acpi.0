From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 3/6] Improve debug output
Date: Fri, 21 Mar 2008 17:07:09 +0300
Message-ID: <20080321140709.30578.46285.stgit@thinkpad.local>
References: <20080321140648.30578.73816.stgit@thinkpad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51634 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753307AbYCUOHP (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 10:07:15 -0400
In-Reply-To: <20080321140648.30578.73816.stgit@thinkpad.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 63e0ac2..1a7949c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -248,9 +248,9 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 			udelay(ACPI_EC_UDELAY);
 		}
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout,"
-			       " status = %d, expect_event = %d\n",
-			       acpi_ec_read_status(ec), event);
+	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
+		acpi_ec_read_status(ec),
+		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
 	ret = -ETIME;
       end:
 	clear_bit(EC_FLAGS_ADDRESS, &ec->flags);
@@ -264,8 +264,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 {
 	int result = 0;
 	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	acpi_ec_write_cmd(ec, command);
 	pr_debug(PREFIX "transaction start\n");
+	acpi_ec_write_cmd(ec, command);
 	for (; wdata_len > 0; --wdata_len) {
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
 		if (result) {

