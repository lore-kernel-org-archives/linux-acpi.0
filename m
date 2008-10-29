From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 2/3]  ACPI :Add the 2us delay before loop check EC
	status while in polling mode
Date: Wed, 29 Oct 2008 17:50:08 +0800
Message-ID: <1225273808.5189.271.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61096 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbYJ2Jnm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 05:43:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Add the 2us delay before loop check EC status while in polling mode

According to the ACPI spec when the host writes data to the command or data
register of the embedded controller, the input buffer flag (IBF) in the 
status register is set within 1 microsecond. 
Maybe the incorrect status is returned by EC if host checks the EC status 
immediately after the data is written to EC I/O port. On most laptosp it
is unnecessary to add the delay as EC device is connected with the slow
peripherial bus. 
But it is safe to add the delay of 2 microseconds before starting loop 
check the EC status while EC is in polling mode.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/ec.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -259,6 +259,7 @@ static int acpi_ec_wait(struct acpi_ec *
 	} else {
 		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
 		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
+		udelay(2);
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				return 0;


