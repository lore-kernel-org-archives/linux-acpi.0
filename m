From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / table: Replace '1' with specific error in return value
Date: Thu,  5 Dec 2013 23:42:38 +0800
Message-ID: <1386258158-10056-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35560 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726Ab3LEPmw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 10:42:52 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so24859467pdj.37
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 07:42:51 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

In commit 7f8f97c3cc (ACPI: acpi_table_parse() now returns success/fail,
not count), it return '1' when no table found, replace -ENODEV here
to make it more resonable.

Fix the same problem in acpi_table_init() too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/tables.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index d67a1fe..4ec4425 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -306,7 +306,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		early_acpi_os_unmap_memory(table, tbl_size);
 		return 0;
 	} else
-		return 1;
+		return -ENODEV;
 }
 
 /* 
@@ -351,7 +351,7 @@ int __init acpi_table_init(void)
 
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
-		return 1;
+		return -EINVAL;
 
 	check_multiple_madt();
 	return 0;
-- 
1.7.9.5

