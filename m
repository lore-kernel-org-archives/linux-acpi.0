From: Dan Carpenter <error27@gmail.com>
Subject: [patch] dereference after kfree()
Date: Thu, 2 Apr 2009 08:29:56 +0300 (EAT)
Message-ID: <Pine.LNX.4.64.0904012151001.27705@usbsys.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:33119 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZDBFmS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2009 01:42:18 -0400
Received: by ewy9 with SMTP id 9so367876ewy.37
        for <linux-acpi@vger.kernel.org>; Wed, 01 Apr 2009 22:42:15 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shaohua.li@intel.com, linux-acpi@vger.kernel.org

dock_remove() calls kfree() on dock_station so we should use 
list_for_each_entry_safe() to avoid dereferencing freed memory.

Found by smatch (http://repo.or.cz/w/smatch.git/).  Compile tested.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/drivers/acpi/dock.c	2009-04-01 21:46:57.000000000 +0300
+++ devel/drivers/acpi/dock.c	2009-04-01 21:48:51.000000000 +0300
@@ -1146,9 +1146,10 @@
 static void __exit dock_exit(void)
 {
 	struct dock_station *dock_station;
+	struct dock_station *tmp;
 
 	unregister_acpi_bus_notifier(&dock_acpi_notifier);
-	list_for_each_entry(dock_station, &dock_stations, sibiling)
+	list_for_each_entry_safe(dock_station, tmp, &dock_stations, sibiling)
 		dock_remove(dock_station);
 }
 
