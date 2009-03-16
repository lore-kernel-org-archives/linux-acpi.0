From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/14] acpi: check for pxm_to_node_map overflow
Date: Mon, 16 Mar 2009 01:23:51 -0400
Message-ID: <27ce34198345886854643b9572f9a06d2e7500d2.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:45332 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZCPFYH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL005Y0305JSNN@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:06 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Cyrill Gorcunov <gorcunov@gmail.com>

It is hardly (if ever) possible but in case of broken _PXM entry we could
reach out of pxm_to_node_map array bounds in acpi_map_pxm_to_node() call.

Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/numa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index c5e292a..3a0d8ef 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -277,7 +277,7 @@ int acpi_get_node(acpi_handle *handle)
 	int pxm, node = -1;
 
 	pxm = acpi_get_pxm(handle);
-	if (pxm >= 0)
+	if (pxm >= 0 && pxm < MAX_PXM_DOMAINS)
 		node = acpi_map_pxm_to_node(pxm);
 
 	return node;
-- 
1.5.6.6

