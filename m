From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: [PATCH 2/2] ACPI: Use kmalloc instead of kzalloc
Date: Thu, 20 Mar 2014 13:31:53 +0900
Message-ID: <000101cf43f5$52b0f110$f812d330$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19460 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaCTEb4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 00:31:56 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2P00IYRWL7LR10@mailout1.samsung.com> for
 linux-acpi@vger.kernel.org; Thu, 20 Mar 2014 13:31:55 +0900 (KST)
Content-language: ko
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "'open list:ACPI'" <linux-acpi@vger.kernel.org>
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

