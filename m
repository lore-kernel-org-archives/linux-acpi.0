From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/20] ACPI, APEI,
 Fix a typo of error path of apei_resources_request
Date: Sun, 15 Aug 2010 01:23:12 -0400
Message-ID: <2663b3f23537618c0c286551b138353fe26b3df8.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:52060 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0HOFXd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:33 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600F3GHN8M5U0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:33 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

Fix a typo of error path of apei_resources_request. release_mem_region
and release_region should be interchange.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/apei-base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 216e1e9..73fd0c7 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -482,14 +482,14 @@ err_unmap_ioport:
 	list_for_each_entry(res, &resources->ioport, list) {
 		if (res == res_bak)
 			break;
-		release_mem_region(res->start, res->end - res->start);
+		release_region(res->start, res->end - res->start);
 	}
 	res_bak = NULL;
 err_unmap_iomem:
 	list_for_each_entry(res, &resources->iomem, list) {
 		if (res == res_bak)
 			break;
-		release_region(res->start, res->end - res->start);
+		release_mem_region(res->start, res->end - res->start);
 	}
 	return -EINVAL;
 }
-- 
1.7.2.1.95.g3d045

