From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: [RFC PATCH v1 3/3] arm64/apei: get error address from memory section for recovery
Date: Fri, 1 Sep 2017 18:32:01 +0800
Message-ID: <1504261921-39308-4-git-send-email-xiexiuqi@huawei.com>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbdIAKbQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Sep 2017 06:31:16 -0400
In-Reply-To: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, x86@kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com

In some platform, when SEA triggerred, physical address might be
reported by memory section, so we save it for error recovery later.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/ras.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
index 8562ec7..2b400b8 100644
--- a/arch/arm64/kernel/ras.c
+++ b/arch/arm64/kernel/ras.c
@@ -136,3 +136,20 @@ void arm_proc_error_check(struct ghes *ghes, struct cper_sec_proc_arm *err)
 	if (!ret)
 		set_thread_flag(TIF_SEA_NOTIFY);
 }
+
+void arch_apei_report_mem_error(struct ghes *ghes, int sev,
+				struct cper_sec_mem_err *mem)
+{
+	int ret = -1;
+
+	if ((ghes->generic->notify.type != ACPI_HEST_NOTIFY_SEA) ||
+	    (ghes->estatus->error_severity != CPER_SEV_RECOVERABLE))
+		return;
+
+	if (mem->validation_bits & CPER_MEM_VALID_PA) {
+		ret = sea_save_info(mem->physical_addr);
+	}
+
+	if (!ret)
+		set_thread_flag(TIF_SEA_NOTIFY);
+}
-- 
1.8.3.1

