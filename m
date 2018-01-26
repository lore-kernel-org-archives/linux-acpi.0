From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: [PATCH v5 2/3] GHES: add a notify chain for process memory section
Date: Fri, 26 Jan 2018 20:31:24 +0800
Message-ID: <1516969885-150532-3-git-send-email-xiexiuqi@huawei.com>
References: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:42097 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751804AbeAZMZS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jan 2018 07:25:18 -0500
In-Reply-To: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, stephen.boyd@linaro.org, bp@suse.de, julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org, cj.chengjian@huawei.com

Add a notify chain for process memory section, with
which other modules might do error recovery.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 10 ++++++++++
 include/acpi/ghes.h      |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cff671d..1f0ebfb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -109,6 +109,9 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
+ATOMIC_NOTIFIER_HEAD(ghes_mem_err_chain);
+EXPORT_SYMBOL(ghes_mem_err_chain);
+
 /*
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
@@ -441,6 +444,13 @@ static void ghes_do_proc(struct ghes *ghes,
 
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+			struct ghes_mem_err mem;
+
+			mem.notify_type = ghes->generic->notify.type;
+			mem.severity = gdata->error_severity;
+			mem.mem_err = mem_err;
+
+			atomic_notifier_call_chain(&ghes_mem_err_chain, 0, &mem);
 
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index d626367..921ebf1 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -124,4 +124,12 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 extern void ghes_arm_process_error(struct ghes *ghes,
 				   struct cper_sec_proc_arm *err);
 
+struct ghes_mem_err {
+	int notify_type;
+	int severity;
+	struct cper_sec_mem_err *mem_err;
+};
+
+extern struct atomic_notifier_head ghes_mem_err_chain;
+
 #endif /* GHES_H */
-- 
1.8.3.1

