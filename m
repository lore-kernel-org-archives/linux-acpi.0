From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 2/5] GHES: Carve out the panic functionality
Date: Fri, 27 Mar 2015 10:22:55 +0100
Message-ID: <1427448178-20689-3-git-send-email-bp@alien8.de>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427448178-20689-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... into another function for more clarity. No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe1e41bf5609..712ed95b1dca 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -823,6 +823,18 @@ static void __process_error(struct ghes *ghes)
 #endif
 }
 
+static void __ghes_panic(struct ghes *ghes)
+{
+	oops_begin();
+	ghes_print_queued_estatus();
+	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
+
+	/* reboot to log the error! */
+	if (panic_timeout == 0)
+		panic_timeout = ghes_panic_timeout;
+	panic("Fatal hardware error!");
+}
+
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes, *ghes_global = NULL;
@@ -846,16 +858,8 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	if (ret == NMI_DONE)
 		goto out;
 
-	if (sev_global >= GHES_SEV_PANIC) {
-		oops_begin();
-		ghes_print_queued_estatus();
-		__ghes_print_estatus(KERN_EMERG, ghes_global->generic,
-				     ghes_global->estatus);
-		/* reboot to log the error! */
-		if (panic_timeout == 0)
-			panic_timeout = ghes_panic_timeout;
-		panic("Fatal hardware error!");
-	}
+	if (sev_global >= GHES_SEV_PANIC)
+		__ghes_panic(ghes_global);
 
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
 		if (!(ghes->flags & GHES_TO_CLEAR))
-- 
2.3.3
