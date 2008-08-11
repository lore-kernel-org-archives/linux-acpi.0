From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]  ACPI:  Avoid bogus EC timeout when EC is in Polling mode
Date: Mon, 11 Aug 2008 10:33:31 +0800
Message-ID: <1218422011.6671.65.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38571 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbYHKCTi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Aug 2008 22:19:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AndiKleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Subject: ACPI: Avoid bogus EC timeout when EC is in Polling mode
>From : Zhao Yakui <yakui.zhao@intel.com>

When EC is in Polling mode, OS will check the EC status continually by using
the following source code:
       clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
       while (time_before(jiffies, delay)) {
               if (acpi_ec_check_status(ec, event))
       	            return 0;
               msleep(1);
       }
But msleep is realized by the function of schedule_timeout. At the same time
although one process is already waken up by some events, it won't be scheduled
immediately. So maybe there exists the following phenomena:
     a. The current jiffies is already after the predefined jiffies.
	But before timeout happens, OS has no chance to check the EC
	status again.
     b. If preemptible schedule is enabled, maybe preempt schedule will happen
	before checking loop. When the process is resumed again, maybe
	timeout already happens, which means that OS has no chance to check
	the EC status.

In such case maybe EC status is already what OS expects when timeout happens.
But OS has no chance to check the EC status and regards it as AE_TIME.

So it will be more appropriate that OS will try to check the EC status again 
when timeout happens. If the EC status is what we expect, it won't be regarded
as timeout. Only when the EC status is not what we expect, it will be regarded
as timeout, which means that EC controller can't give a response in time.

http://bugzilla.kernel.org/show_bug.cgi?id=9823
http://bugzilla.kernel.org/show_bug.cgi?id=11141

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/ec.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -196,6 +196,8 @@ static int acpi_ec_wait(struct acpi_ec *
 				return 0;
 			msleep(1);
 		}
+		if (acpi_ec_check_status(ec,event))
+			return 0;
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
 		acpi_ec_read_status(ec),


