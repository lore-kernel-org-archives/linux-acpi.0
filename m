From: Liang Li <liang.li@windriver.com>
Subject: [V2 PATCH] ACPI: fix unbalanced code block
Date: Thu, 10 Jun 2010 13:42:49 +0800
Message-ID: <1276148569-27172-1-git-send-email-liang.li@windriver.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58453 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab0FJFob (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 01:44:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

The code block braced with CONFIG_ACPI_PROCFS is unblanced. When
CONFIG_ACPI_PROCFS=n, kernel trace will be produced like:

Call Trace:
 [<c111637d>] ? remove_proc_entry+0x20d/0x290
 [<c111637d>] ? remove_proc_entry+0x20d/0x290
 [<c103b02c>] warn_slowpath_common+0x6c/0xc0
 [<c111637d>] ? remove_proc_entry+0x20d/0x290
 [<c103b0c6>] warn_slowpath_fmt+0x26/0x30
 [<c111637d>] remove_proc_entry+0x20d/0x290
 [<c1116bd7>] ? proc_register+0x117/0x1f0
 [<c1116e83>] ? proc_mkdir_mode+0x33/0x50
 [<c14f483c>] ? acpi_fan_init+0x0/0x2c
 [<c14f485f>] acpi_fan_init+0x23/0x2c
 [<c1001123>] do_one_initcall+0x23/0x180
 [<c107dcf7>] ? init_irq_proc+0x67/0x80
 [<c14d43bd>] kernel_init+0x13c/0x20e
 [<c1030e50>] ? schedule_tail+0x20/0x90
 [<c1389e06>] ? syscall_exit+0x5/0x16
 [<c14d4281>] ? kernel_init+0x0/0x20e
 [<c14d4281>] ? kernel_init+0x0/0x20e
 [<c10032f6>] kernel_thread_helper+0x6/0x30
---[ end trace a7919e7f17c0a725 ]---

Then also bracket later error checking code with ACPI_PROCFS
option to avoid mismatch problem.

Signed-off-by: Liang Li <liang.li@windriver.com>
---
 drivers/acpi/fan.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index acf2ab2..8a3b840 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -347,7 +347,6 @@ static int __init acpi_fan_init(void)
 {
 	int result = 0;
 
-
 #ifdef CONFIG_ACPI_PROCFS
 	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
@@ -356,7 +355,9 @@ static int __init acpi_fan_init(void)
 
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
+#ifdef CONFIG_ACPI_PROCFS
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
+#endif
 		return -ENODEV;
 	}
 
-- 
1.6.6

