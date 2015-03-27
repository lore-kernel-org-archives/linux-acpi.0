From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 4/5] GHES: Elliminate double-loop in the NMI handler
Date: Fri, 27 Mar 2015 10:22:57 +0100
Message-ID: <1427448178-20689-5-git-send-email-bp@alien8.de>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58661 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbbC0JYv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Mar 2015 05:24:51 -0400
In-Reply-To: <1427448178-20689-1-git-send-email-bp@alien8.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There's no real need to iterate twice over the HW error sources in the
NMI handler. With the previous cleanups, elliminating the second loop is
almost trivial.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0de3adcca03e..94a44bad5576 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -851,25 +851,18 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		if (sev >= GHES_SEV_PANIC)
 			__ghes_panic(ghes);
 
-		ret = NMI_HANDLED;
-	}
-
-	if (ret == NMI_DONE)
-		goto out;
-
-	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
 
 		__process_error(ghes);
 		ghes_clear_estatus(ghes);
+
+		ret = NMI_HANDLED;
 	}
 
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	irq_work_queue(&ghes_proc_irq_work);
 #endif
-
-out:
 	raw_spin_unlock(&ghes_nmi_lock);
 	return ret;
 }
-- 
2.3.3

