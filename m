From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 1/4] ACPI: Don't issue burst disable command if EC
	exits the burst mode
Date: Thu, 25 Sep 2008 11:54:38 +0800
Message-ID: <1222314879.4023.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23355 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbYIYDt6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 23:49:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Subject: ACPI: Don't issue burst disable command if EC exits the burst mode

It is meaningless that OS continues to issue the burst disable command 
if the EC already exits the burst mode. So if EC already exits the 
burst mode, don't issue burst disable command again.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -327,12 +327,25 @@ static int acpi_ec_transaction(struct ac
 int acpi_ec_burst_enable(struct acpi_ec *ec)
 {
 	u8 d;
+	/*
+	 * When burst enable command is issused, EC will put the EC burst
+	 * acknowledge byte (0x90) into output buffer.
+	 * Maybe it is worth checking the returned acknowledge bytes.
+	 */
 	return acpi_ec_transaction(ec, ACPI_EC_BURST_ENABLE, NULL, 0, &d, 1, 0);
 }
 
 int acpi_ec_burst_disable(struct acpi_ec *ec)
 {
-	return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL, 0, NULL, 0, 0);
+	u8 d = acpi_ec_read_status(ec);
+	if (d & ACPI_EC_FLAG_BURST) {
+		/*
+		 * Only when EC is in burst mode, it is necessary to disable.
+		 */
+		return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL,
+						0, NULL, 0, 0);
+	}
+	return 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)


