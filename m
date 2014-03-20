From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: [PATCH 2/2] ACPI: Use kmalloc instead of kzalloc
Date: Thu, 20 Mar 2014 16:36:36 +0900
Message-ID: <000501cf440f$1ff0b2a0$5fd217e0$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42493 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaCTHgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 03:36:38 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2Q00H2G551SGE0@mailout2.samsung.com> for
 linux-acpi@vger.kernel.org; Thu, 20 Mar 2014 16:36:37 +0900 (KST)
Content-language: ko
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: 'Len Brown' <lenb@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

All the members are initialized after kzalloc.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/acpi/osl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 09e53be..64a7a51 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -378,7 +378,7 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size
size)
 		goto out;
 	}
 
-	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	map = kmalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
 		return NULL;
@@ -1121,7 +1121,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 * having a static work_struct.
 	 */
 
-	dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
+	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
 	if (!dpc)
 		return AE_NO_MEMORY;
 
-- 
1.7.10.4

