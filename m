From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/4] acer-wmi: Don't warn if mail LED cannot be detected
Date: Sun, 24 Feb 2008 13:34:29 +0000
Message-ID: <20080224133429.2317.72620.stgit@pacifica>
References: <20080224133412.2317.5802.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34346 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757464AbYBXNep (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 08:34:45 -0500
In-Reply-To: <20080224133412.2317.5802.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

This warning confuses users, who think it is an error. Not detecting the
mail LED simply means it isn't there, so let's not unduly panic users.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 99beeb8..68b12d6 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1071,10 +1071,8 @@ static int __init acer_wmi_init(void)
 		}
 	}
 
-	if (wmi_has_guid(AMW0_GUID1)) {
-		if (ACPI_FAILURE(AMW0_find_mailled()))
-			printk(ACER_ERR "Unable to detect mail LED\n");
-	}
+	if (wmi_has_guid(AMW0_GUID1))
+		AMW0_find_mailled();
 
 	find_quirks();
 

