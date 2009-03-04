From: akpm@linux-foundation.org
Subject: [patch 7/8] acpi: check for pxm_to_node_map overflow
Date: Wed, 04 Mar 2009 11:55:29 -0800
Message-ID: <200903041955.n24JtUTS028013@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48086 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756207AbZCDT4N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, gorcunov@gmail.com, gorcunov@openvz.org

From: Cyrill Gorcunov <gorcunov@gmail.com>

It is hardly (if ever) possible but in case of broken _PXM entry we could
reach out of pxm_to_node_map array bounds in acpi_map_pxm_to_node() call.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/numa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/numa.c~acpi-check-for-pxm_to_node_map-overflow drivers/acpi/numa.c
--- a/drivers/acpi/numa.c~acpi-check-for-pxm_to_node_map-overflow
+++ a/drivers/acpi/numa.c
@@ -277,7 +277,7 @@ int acpi_get_node(acpi_handle *handle)
 	int pxm, node = -1;
 
 	pxm = acpi_get_pxm(handle);
-	if (pxm >= 0)
+	if (pxm >= 0 && pxm < MAX_PXM_DOMAINS)
 		node = acpi_map_pxm_to_node(pxm);
 
 	return node;
_
