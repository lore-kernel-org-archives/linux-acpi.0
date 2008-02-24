From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/4] acer-wmi: Make device detection error messages more
	descriptive
Date: Sun, 24 Feb 2008 13:34:24 +0000
Message-ID: <20080224133424.2317.90354.stgit@pacifica>
References: <20080224133412.2317.5802.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34345 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757160AbYBXNek (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 08:34:40 -0500
In-Reply-To: <20080224133412.2317.5802.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

The current device detection error messages are all copy & pasted - make
them more descriptive so it's easier to see where in the code a problem
occurs.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index d1d64db..99beeb8 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1052,11 +1052,12 @@ static int __init acer_wmi_init(void)
 
 	if (wmi_has_guid(WMID_GUID2) && interface) {
 		if (ACPI_FAILURE(WMID_set_capabilities())) {
-			printk(ACER_ERR "Unable to detect available devices\n");
+			printk(ACER_ERR "Unable to detect available WMID ");
+			printk(KERN_CONT "devices\n");
 			return -ENODEV;
 		}
 	} else if (!wmi_has_guid(WMID_GUID2) && interface) {
-		printk(ACER_ERR "Unable to detect available devices\n");
+		printk(ACER_ERR "No WMID device detection method found\n");
 		return -ENODEV;
 	}
 
@@ -1064,7 +1065,8 @@ static int __init acer_wmi_init(void)
 		interface = &AMW0_interface;
 
 		if (ACPI_FAILURE(AMW0_set_capabilities())) {
-			printk(ACER_ERR "Unable to detect available devices\n");
+			printk(ACER_ERR "Unable to detect available AMW0 ");
+			printk(KERN_CONT "devices\n");
 			return -ENODEV;
 		}
 	}

