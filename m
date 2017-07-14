From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
Date: Fri, 14 Jul 2017 13:52:33 +0800
Message-ID: <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, bhe@redhat.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Julian Wollrath <jwollrath@web.de>
List-Id: linux-acpi@vger.kernel.org

Linux uses acpi_early_init() to put the ACPI table management into
the late stage from the early stage where the mapped ACPI tables is
temporary and should be unmapped.

But, now initializing interrupt delivery mode should map and parse the
DMAR table earlier in the early stage. This causes an ACPI error when
Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
the DMAR table after using in the early stage.

Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
be mapped and parsed in late stage like before.

Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zheng, Lv <lv.zheng@intel.com>
Cc: Julian Wollrath <jwollrath@web.de>
---
Test in my own PC(Lenovo M4340). 
Ask help for doing regression testing for the bug said in commit c4e1acbb35e4 
("ACPI / init: Invoke early ACPI initialization later").

 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index df58a41..7a09467 100644
--- a/init/main.c
+++ b/init/main.c
@@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
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
