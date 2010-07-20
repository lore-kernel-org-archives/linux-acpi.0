From: akpm@linux-foundation.org
Subject: [patch 25/26] asus-laptop: fix wapf, wlan_status and bluetooth_status module_param permissions
Date: Tue, 20 Jul 2010 15:19:55 -0700
Message-ID: <201007202219.o6KMJtoR021098@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49474 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932733Ab0GTWk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, corentincj@iksaif.net, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

The wapf module parameters defines the behavior of the Fn+Fx wlan key. 
The wlan_status and bluetooth_status module parameters are for setting the
wlan/bluetooth status on boot.

All above module parameters are determinated only at the module load time.
 Change the value after the module is loaded does not make sense and has
no effect at all, thus set the permissions to 0444 instead of 0644.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus-laptop.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/asus-laptop.c~asus-laptop-fix-wapf-wlan_status-and-bluetooth_status-module_param-permissions drivers/platform/x86/asus-laptop.c
--- a/drivers/platform/x86/asus-laptop.c~asus-laptop-fix-wapf-wlan_status-and-bluetooth_status-module_param-permissions
+++ a/drivers/platform/x86/asus-laptop.c
@@ -76,18 +76,18 @@ MODULE_LICENSE("GPL");
  * So, if something doesn't work as you want, just try other values =)
  */
 static uint wapf = 1;
-module_param(wapf, uint, 0644);
+module_param(wapf, uint, 0444);
 MODULE_PARM_DESC(wapf, "WAPF value");
 
 static int wlan_status = 1;
 static int bluetooth_status = 1;
 
-module_param(wlan_status, int, 0644);
+module_param(wlan_status, int, 0444);
 MODULE_PARM_DESC(wlan_status, "Set the wireless status on boot "
 		 "(0 = disabled, 1 = enabled, -1 = don't do anything). "
 		 "default is 1");
 
-module_param(bluetooth_status, int, 0644);
+module_param(bluetooth_status, int, 0444);
 MODULE_PARM_DESC(bluetooth_status, "Set the wireless status on boot "
 		 "(0 = disabled, 1 = enabled, -1 = don't do anything). "
 		 "default is 1");
_
