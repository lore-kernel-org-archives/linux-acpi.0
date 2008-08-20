From: akpm@linux-foundation.org
Subject: [patch 1/2] acpi: add checking for NULL early param
Date: Wed, 20 Aug 2008 16:41:45 -0700
Message-ID: <200808202341.m7KNfkb8005410@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36326 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbYHTXmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2008 19:42:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, gorcunov@gmail.com

From: Cyrill Gorcunov <gorcunov@gmail.com>

The early_param handling function could recieve NULL pointer as argument
in case if user didn't enter parameter value.  So we have to be ready for
a such situation and do check for NULL pointer if needed.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/tables.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/acpi/tables.c~acpi-add-checking-for-null-early-param drivers/acpi/tables.c
--- a/drivers/acpi/tables.c~acpi-add-checking-for-null-early-param
+++ a/drivers/acpi/tables.c
@@ -300,6 +300,8 @@ int __init acpi_table_init(void)
 
 static int __init acpi_parse_apic_instance(char *str)
 {
+	if (!str)
+		return -EINVAL;
 
 	acpi_apic_instance = simple_strtoul(str, NULL, 0);
 
_
