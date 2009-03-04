From: akpm@linux-foundation.org
Subject: [patch 8/8] acpi: wmi.c: unsigned cannot be less than 0
Date: Wed, 04 Mar 2009 11:55:30 -0800
Message-ID: <200903041955.n24JtUd9028016@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59956 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756160AbZCDT4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com

From: Roel Kluin <roel.kluin@gmail.com>

include/linux/pci-acpi.h:74:

typedef u32                 acpi_status;

result is unsigned, so an error returned by acpi_bus_register_driver()
will not be noticed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/wmi.c~acpi-wmic-unsigned-cannot-be-less-than-0 drivers/platform/x86/wmi.c
--- a/drivers/platform/x86/wmi.c~acpi-wmic-unsigned-cannot-be-less-than-0
+++ a/drivers/platform/x86/wmi.c
@@ -708,7 +708,7 @@ static int __init acpi_wmi_add(struct ac
 
 static int __init acpi_wmi_init(void)
 {
-	acpi_status result;
+	int result;
 
 	INIT_LIST_HEAD(&wmi_blocks.list);
 
_
