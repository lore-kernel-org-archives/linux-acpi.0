From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/3] acer-wmi: Make device detection error messages more
	descriptive
Date: Wed, 12 Mar 2008 20:12:50 +0000
Message-ID: <20080312201249.2071.93005.stgit@pacifica>
References: <20080312201238.2071.31534.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:45899 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752514AbYCLUNK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:13:10 -0400
In-Reply-To: <20080312201238.2071.31534.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

The current device detection error messages are all copy & pasted - make
them more descriptive so it's easier to see where in the code a problem
occurs.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 89439ac..89d346b 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1052,11 +1052,12 @@ static int __init acer_wmi_init(void)
 
 	if (wmi_has_guid(WMID_GUID2) && interface) {
 		if (ACPI_FAILURE(WMID_set_capabilities())) {
-			printk(ACER_ERR "Unable to detect available devices\n");
+			printk(ACER_ERR "Unable to detect available WMID "
+					"devices\n");
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
+			printk(ACER_ERR "Unable to detect available AMW0 "
+					"devices\n");
 			return -ENODEV;
 		}
 	}
@@ -1075,8 +1077,8 @@ static int __init acer_wmi_init(void)
 	find_quirks();
 
 	if (!interface) {
-		printk(ACER_ERR "No or unsupported WMI interface, unable to ");
-		printk(KERN_CONT "load.\n");
+		printk(ACER_ERR "No or unsupported WMI interface, unable to "
+				"load\n");
 		return -ENODEV;
 	}
 

