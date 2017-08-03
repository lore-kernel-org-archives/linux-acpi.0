From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH] acpi: ghes: fix the OSPM acknowledges error flow
Date: Thu, 3 Aug 2017 23:42:25 +0800
Message-ID: <1501774945-31726-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:10832 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdHCPWq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 11:22:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, prarit@redhat.com, andriy.shevchenko@linux.intel.com, zjzhang@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gengdongjiu@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, wangxiongfeng2@huawei.com

In GHESv2, The read_ack_register is used to specify the
location of the read ack register, it is only the physical
address, but not the value. so needs to continue reading
the address to get the right value. Also It needs to write
the ack value to the right physical address.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/acpi/apei/ghes.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index bb83044..44bb65f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -703,16 +703,25 @@ static void ghes_estatus_cache_add(
 static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 {
 	int rc;
-	u64 val = 0;
+	u64 ack_paddr;
+	u64 ack_val = 0;
 
-	rc = apei_read(&val, &gv2->read_ack_register);
+	rc = apei_read(&ack_paddr, &gv2->read_ack_register);
 	if (rc)
 		return rc;
 
-	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
-	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
+	if (!ack_paddr)
+		return -ENOENT;
+
+	ghes_copy_tofrom_phys(&ack_val, ack_paddr,
+			      sizeof(u64), 1);
 
-	return apei_write(val, &gv2->read_ack_register);
+	ack_val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
+	ack_val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
+
+	ghes_copy_tofrom_phys(&ack_val, ack_paddr,
+				sizeof(u64), 0);
+	return 0;
 }
 
 static void __ghes_panic(struct ghes *ghes)
-- 
2.10.1

