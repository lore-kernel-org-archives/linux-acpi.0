From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 3/5] GHES: Panic right after detection
Date: Fri, 27 Mar 2015 10:22:56 +0100
Message-ID: <1427448178-20689-4-git-send-email-bp@alien8.de>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427448178-20689-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The moment we log an error of panic severity, there's no need to noodle
through the ghes_nmi list anymore. So panic instead right then and
there.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 712ed95b1dca..0de3adcca03e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -837,9 +837,8 @@ static void __ghes_panic(struct ghes *ghes)
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
-	struct ghes *ghes, *ghes_global = NULL;
-	int sev, sev_global = -1;
-	int ret = NMI_DONE;
+	struct ghes *ghes;
+	int sev, ret = NMI_DONE;
 
 	raw_spin_lock(&ghes_nmi_lock);
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
@@ -847,20 +846,17 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			ghes_clear_estatus(ghes);
 			continue;
 		}
+
 		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev > sev_global) {
-			sev_global = sev;
-			ghes_global = ghes;
-		}
+		if (sev >= GHES_SEV_PANIC)
+			__ghes_panic(ghes);
+
 		ret = NMI_HANDLED;
 	}
 
 	if (ret == NMI_DONE)
 		goto out;
 
-	if (sev_global >= GHES_SEV_PANIC)
-		__ghes_panic(ghes_global);
-
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
-- 
2.3.3
