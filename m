From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch 2/4]  ACPI : Add the 2us delay before starting check EC
	status while in polling mode
Date: Mon, 03 Nov 2008 16:57:16 +0800
Message-ID: <1225702636.26020.53.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33624 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782AbYKCIu0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 03:50:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Subject: ACPI: Add the 2us delay before starting check EC status while in polling mode
From: Zhao Yakui <yakui.zhao@intel.com>

    According to the ACPI spec when the host writes data to the command or data
register of the embedded controller, the input buffer flag (IBF) in the status 
register is set within 1 microsecond. Maybe the incorrect status is returned by
EC if host checks the EC status immediately after the data is written to EC 
I/O port. 
   On most laptosp it is unnecessary to add the delay as EC device is connected 
with the slow peripherial bus. But it is safe to add the delay of 2 microseconds
before starting loop check the EC status while EC is in polling mode.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -260,6 +260,7 @@ static int acpi_ec_wait(struct acpi_ec *
 	} else {
 		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		udelay(2);
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				return 0;


