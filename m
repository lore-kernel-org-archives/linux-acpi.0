From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Avoid twice read access to EC data I/O port
Date: Mon, 18 Aug 2008 11:14:34 +0800
Message-ID: <1219029274.3998.66.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10451 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbYHRDAD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Aug 2008 23:00:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, astarikovskiy@suse.de

Subject: ACPI: Avoid twice read access to EC data I/O port 
>From : Zhao Yakui <yakui.zhao@intel.com>

In current kernel when OS reads the data returned by the EC controller, the 
EC data I/O port is accessed twice. In fact is is meaningless.
Only once access to EC data I/O port is enough to get data returned by EC 
controller.

Signed-off-by : Zhao Yakui <yakui.zhao@intel.com>
Acked-by      : Alexey Starikovskiy <astarikovskiy@suse.de>

---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -150,7 +150,7 @@ static inline u8 acpi_ec_read_data(struc
 {
 	u8 x = inb(ec->data_addr);
 	pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
-	return inb(ec->data_addr);
+	return x;
 }
 
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)


