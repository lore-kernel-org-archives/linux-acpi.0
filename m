From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: [PATCH v2 3/3] arm64/ras: save error address from memory section for recovery
Date: Tue, 5 Sep 2017 19:06:06 +0800
Message-ID: <1504609566-66318-4-git-send-email-xiexiuqi@huawei.com>
References: <1504609566-66318-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5968 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdIELGA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2017 07:06:00 -0400
In-Reply-To: <1504609566-66318-1-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, stephen.boyd@linaro.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com

In some platform, when SEA triggerred, physical address might be
reported by memory section, so we save it for error recovery later.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
---
 arch/arm64/kernel/ras.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
index 5710b2e..8a44c01 100644
--- a/arch/arm64/kernel/ras.c
+++ b/arch/arm64/kernel/ras.c
@@ -141,3 +141,34 @@ void arm_process_error(struct ghes *ghes, struct cper_sec_proc_arm *err)
 		set_thread_flag(TIF_SEA_NOTIFY);
 }
 
+int ghes_mem_err_callback(struct notifier_block *nb, unsigned long val, void *data)
+{
+	bool info_saved = false;
+	struct ghes_mem_err *ghes_mem = (struct ghes_mem_err *)data;
+	struct cper_sec_mem_err *mem_err = ghes_mem->mem_err;
+
+	if ((ghes_mem->notify_type != ACPI_HEST_NOTIFY_SEA) ||
+	    (ghes_mem->severity != CPER_SEV_RECOVERABLE))
+		return 0;
+
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
+		info_saved = sea_save_info(mem_err->physical_addr);
+	}
+
+	if (info_saved)
+		set_thread_flag(TIF_SEA_NOTIFY);
+
+	return 0;
+}
+
+static struct notifier_block ghes_mem_err_nb = {
+	.notifier_call	= ghes_mem_err_callback,
+};
+
+static int arm64_err_recov_init(void)
+{
+	atomic_notifier_chain_register(&ghes_mem_err_chain, &ghes_mem_err_nb);
+	return 0;
+}
+
+late_initcall(arm64_err_recov_init);
-- 
1.8.3.1

