From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/42] ACPI: minor printk format change in acpi_pad
Date: Wed, 23 Mar 2011 02:42:55 -0400
Message-ID: <cdf2a4eeded69f66ec8c5098c375fe49e0820127.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36996 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1CWHHe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:34 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:34 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Naga Chumbalkar <nagananda.chumbalkar@hp.com>, Len Brown <len.brown@intel.com>

From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Minor format change.

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 474be3a..a43fa1a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -456,7 +456,7 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 			dev_name(&device->dev), event, 0);
 		break;
 	default:
-		printk(KERN_WARNING"Unsupported event [0x%x]\n", event);
+		printk(KERN_WARNING "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
1.7.4.1.343.ga91df

