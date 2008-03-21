From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  1/16][BUG] Export kobject_rename for pci_hotplug_core (Not
 for mainline!)
Date: Fri, 21 Mar 2008 13:09:06 +0900
Message-ID: <47E334E2.6060306@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44945 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYCUEPP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:15:15 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Export kobject_rename() to fix the following link error. This happens
when pci_hotplug_core driver is compiled as a kernel module.

ERROR: "kobject_rename" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 lib/kobject.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.25-rc6/lib/kobject.c
===================================================================
--- linux-2.6.25-rc6.orig/lib/kobject.c
+++ linux-2.6.25-rc6/lib/kobject.c
@@ -456,6 +456,7 @@ out:
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(kobject_rename);
 
 /**
  * kobject_move - move object to another parent


