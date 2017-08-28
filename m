From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v8 11/13] ACPI / init: Invoke early ACPI initialization earlier
Date: Mon, 28 Aug 2017 11:20:36 +0800
Message-ID: <1503890438-27840-12-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1503890438-27840-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32318 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752052AbdH1DVm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Aug 2017 23:21:42 -0400
In-Reply-To: <1503890438-27840-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc: mingo@kernel.org, hpa@zytor.com, bhe@redhat.com, rjw@rjwysocki.net, bp@alien8.de, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, "Zheng, Lv" <lv.zheng@intel.com>

Linux uses acpi_early_init() to put the ACPI table management into
the late stage from the early stage.The two stages are different. the
mapped ACPI tables in early stage is temporary and should be unmapped, but
in late stage, it permanent and don't need to be unmapped.

Originally, mapping and parsing the DMAR table is in the late stage.
However, initializing interrupt delivery mode earlier will move it into
the early stage. This causes an ACPI error warning when Linux reallocates
the ACPI root tables. Because Linux doesn't unmapped the DMAR table after
using in the early stage.

Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
be mapped and parsed in late stage like before.

Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zheng, Lv <lv.zheng@intel.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 052481f..52dee20 100644
--- a/init/main.c
+++ b/init/main.c
@@ -655,12 +655,12 @@ asmlinkage __visible void __init start_kernel(void)
 	kmemleak_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
 	pidmap_init();
 	anon_vma_init();
-	acpi_early_init();
 #ifdef CONFIG_X86
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		efi_enter_virtual_mode();
-- 
2.5.5



