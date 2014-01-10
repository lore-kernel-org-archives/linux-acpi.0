From: al.stone@linaro.org
Subject: [PATCH v6 2/6] ACPI: bus master reload not supported in reduced HW mode
Date: Fri, 10 Jan 2014 15:52:16 -0700
Message-ID: <1389394340-2680-3-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61858 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbaAJWwe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 17:52:34 -0500
Received: by mail-ie0-f179.google.com with SMTP id tp5so15751ieb.38
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2014 14:52:34 -0800 (PST)
In-Reply-To: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Do not save and restore bus master reload registers in suspend/resume
when in reduced HW mode; according to the spec, no such registers should
exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..eac984a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -229,12 +229,14 @@ static struct syscore_ops acpi_processor_syscore_ops = {
 
 void acpi_processor_syscore_init(void)
 {
-	register_syscore_ops(&acpi_processor_syscore_ops);
+	if (!acpi_gbl_reduced_hardware)
+		register_syscore_ops(&acpi_processor_syscore_ops);
 }
 
 void acpi_processor_syscore_exit(void)
 {
-	unregister_syscore_ops(&acpi_processor_syscore_ops);
+	if (!acpi_gbl_reduced_hardware)
+		unregister_syscore_ops(&acpi_processor_syscore_ops);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
1.8.4.2

