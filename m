From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 2/3] ACPI / numa: Fix __init attribute locations
Date: Tue, 13 Aug 2013 18:31:14 +0800
Message-ID: <1376389876-11791-2-git-send-email-hanjun.guo@linaro.org>
References: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:52971 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab3HMKdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2013 06:33:15 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4713159pdi.19
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2013 03:33:15 -0700 (PDT)
In-Reply-To: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

__init belongs after the return type on functions, not before it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/numa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 33e609f..2e82e5d 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -159,7 +159,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
  * distance than the others.
  * Do some quick checks here and only use the SLIT if it passes.
  */
-static __init int slit_valid(struct acpi_table_slit *slit)
+static int __init slit_valid(struct acpi_table_slit *slit)
 {
 	int i, j;
 	int d = slit->locality_count;
-- 
1.7.9.5

