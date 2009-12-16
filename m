From: Len Brown <lenb@kernel.org>
Subject: [PATCH 082/103] ACPI: add kernel tainting after overriding an ACPI
 control method
Date: Wed, 16 Dec 2009 03:36:33 -0500
Message-ID: <4bab30a041a2f27807b0b2a7fd36c8c8695c90c8.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761839AbZLPJFt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:05:49 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:49 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add kernel tainting after overriding an ACPI control method successfully.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/debug.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 0bedd15..cc421b7 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -239,6 +239,7 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 		kfree(buf);
 		if (ACPI_FAILURE(status))
 			return -EINVAL;
+		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
 	}
 
 	return count;
-- 
1.6.0.6

