From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 2/4] Export kobject_rename for pci_hotplug_core
Date: Tue, 25 Mar 2008 11:12:46 -0600
Message-ID: <20080325171246.GC3489__37137.6808303923$1206465310$gmane$org@ldl.fc.hp.com>
References: <20080325170951.GA3489@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:20350 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYCYRMs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 13:12:48 -0400
Content-Disposition: inline
In-Reply-To: <20080325170951.GA3489@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@suse.de, Gary Hade <garyhade@us.ibm.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.c>

Export kobject_rename() to fix the following link error. This happens
when pci_hotplug_core driver is compiled as a kernel module.

ERROR: "kobject_rename" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Acked-by: Alex Chiang <achiang@hp.com>
---
 lib/kobject.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 0d03252..e2a9f65 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -456,6 +456,7 @@ out:
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(kobject_rename);
 
 /**
  * kobject_move - move object to another parent
-- 
1.5.3.1.g1e61

