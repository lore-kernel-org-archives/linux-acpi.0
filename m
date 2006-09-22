From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [Patch 1/3] ibm-acpi: Get rid of experimental status for brightness and volume.
Date: Fri, 22 Sep 2006 12:19:14 +0200
Message-ID: <20060922101944.340168743@datenfreihafen.org>
References: <20060922101913.276298370@datenfreihafen.org>
Reply-To: linux-thinkpad@linux-thinkpad.org
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline; filename=ibm-acpi-get-rid-of-experimental-status.patch
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

The brightness and volume features from ibm-acpi are stable. The experimental
flag is no more needed.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
Index: linux-2.6.18-ibm-acpi/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.18-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2006-09-21 21:02:41.000000000 +0200
+++ linux-2.6.18-ibm-acpi/drivers/acpi/ibm_acpi.c	2006-09-21 21:03:40.000000000 +0200
@@ -1702,13 +1702,11 @@
 	 .name = "brightness",
 	 .read = brightness_read,
 	 .write = brightness_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "volume",
 	 .read = volume_read,
 	 .write = volume_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "fan",

--

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
