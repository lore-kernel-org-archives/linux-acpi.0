From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/32] ACPI: hpet: ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFF0
Date: Fri, 21 Sep 2007 23:46:37 -0400
Message-ID: <11904328241904-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
 <11904328151023-git-send-email-lenb@kernel.org>
 <1190432816575-git-send-email-lenb@kernel.org>
 <1190432817158-git-send-email-lenb@kernel.org>
 <1190432818954-git-send-email-lenb@kernel.org>
 <11904328193063-git-send-email-lenb@kernel.org>
 <11904328192862-git-send-email-lenb@kernel.org>
 <1190432820190-git-send-email-lenb@kernel.org>
 <1190432821532-git-send-email-lenb@kernel.org>
 <11904328221731-git-send-email-lenb@kernel.org>
 <1190432823640-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:56179 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757726AbXIVDrK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:10 -0400
In-Reply-To: <1190432823640-git-send-email-lenb@kernel.org>
Message-Id: <8a4b57f787502d9fef5ac7e02f657f801ea15567.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

If hpet has been initialized before registering hpet driver, the callback
function of hpet_resources will return the status code of -EBUSY, which is
not defined in the ACPI exception table.  So when ACPI checks the status
code of callback function, it will report the unknown exception code.

So the status code in ACPI is used instead of the generic error code in the
ACPI callback function of hpet_resources.
For example: -EBUSY is replaced by AE_ALREADY_EXISTS
	     -EINVAL is replaced by AE_NO_MEMORY

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/hpet.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 7ecffc9..fd51554 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -943,14 +943,14 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
 				__FUNCTION__, hdp->hd_phys_address);
 			iounmap(hdp->hd_address);
-			return -EBUSY;
+			return AE_ALREADY_EXISTS;
 		}
 	} else if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
 		struct acpi_resource_fixed_memory32 *fixmem32;
 
 		fixmem32 = &res->data.fixed_memory32;
 		if (!fixmem32)
-			return -EINVAL;
+			return AE_NO_MEMORY;
 
 		hdp->hd_phys_address = fixmem32->address;
 		hdp->hd_address = ioremap(fixmem32->address,
@@ -960,7 +960,7 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
 				__FUNCTION__, hdp->hd_phys_address);
 			iounmap(hdp->hd_address);
-			return -EBUSY;
+			return AE_ALREADY_EXISTS;
 		}
 	} else if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
 		struct acpi_resource_extended_irq *irqp;
-- 
1.5.3.1.27.g57543
