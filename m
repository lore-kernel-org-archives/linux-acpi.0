From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / processor: Remove unused macros in processor_driver.c
Date: Mon, 24 Jun 2013 15:36:33 +0800
Message-ID: <1372059393-15996-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41694 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3FXHhl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jun 2013 03:37:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so10550031pab.25
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jun 2013 00:37:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

ACPI_PROCESSOR_FILE_INFO, ACPI_PROCESSOR_FILE_THROTTLING and
ACPI_PROCESSOR_FILE_LIMIT are used for procfs, but this feature was removed
in commit d09fe555 (ACPI processor: remove deprecated ACPI procfs I/F) long
ago. So, these macros should also be removed.

ACPI_PROCESSOR_LIMIT_USER and ACPI_PROCESSOR_LIMIT_THERMAL are not used
by any code, remove them too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_driver.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d93963f..823be116 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -43,16 +43,10 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_PROCESSOR_FILE_INFO	"info"
-#define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
-#define ACPI_PROCESSOR_FILE_LIMIT	"limit"
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
 
-#define ACPI_PROCESSOR_LIMIT_USER	0
-#define ACPI_PROCESSOR_LIMIT_THERMAL	1
-
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_driver");
 
-- 
1.7.9.5

