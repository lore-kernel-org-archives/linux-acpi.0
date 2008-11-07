From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/21] sony-laptop: Ignore missing _DIS method on pic device
Date: Thu, 06 Nov 2008 23:39:07 -0500
Message-ID: <bd2b064ecd5504a9e9eeaa5742b9f8bcc6d27637.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37227 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYKGEj3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00LLO4XSOZP0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:29 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Adam Jackson <ajax@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

At least the Vaio VGN-Z540N doesn't have this method, so let's not fail
to suspend just because it doesn't exist.

Signed-off-by: Adam Jackson <ajax@redhat.com>
Acked-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 5a97d3a..f483c42 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -2315,8 +2315,10 @@ end:
  */
 static int sony_pic_disable(struct acpi_device *device)
 {
-	if (ACPI_FAILURE(acpi_evaluate_object(device->handle,
-			"_DIS", NULL, NULL)))
+	acpi_status ret = acpi_evaluate_object(device->handle, "_DIS", NULL,
+					       NULL);
+
+	if (ACPI_FAILURE(ret) && ret != AE_NOT_FOUND)
 		return -ENXIO;
 
 	dprintk("Device disabled\n");
-- 
1.5.6.5

