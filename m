From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/10] ACPI, APEI, EINJ, cleanup 0 vs NULL confusion
Date: Mon, 23 Jan 2012 20:30:08 -0500
Message-ID: <29924b9f8f39e37275cff93740835d28b9e6fb36.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:48996 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab2AXBag (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2012 20:30:36 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYA002PB46ND8BB@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Jan 2012 19:30:29 -0600 (CST)
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <dan.carpenter@oracle.com>

This function is returning pointers.  Sparse complains here:
drivers/acpi/apei/einj.c:262:32: warning:
	Using plain integer as NULL pointer

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/einj.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index bb20b03..c89b0e5 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -259,15 +259,15 @@ static void *einj_get_parameter_address(void)
 
 		v4param = ioremap(paddrv4, sizeof(*v4param));
 		if (!v4param)
-			return 0;
+			return NULL;
 		if (readq(&v4param->reserved1) || readq(&v4param->reserved2)) {
 			iounmap(v4param);
-			return 0;
+			return NULL;
 		}
 		return v4param;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* do sanity check to trigger table */
-- 
1.7.9.rc2

