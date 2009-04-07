From: Len Brown <lenb@kernel.org>
Subject: [2.6.28.y, 2.6.29.y PATCH] dock: fix dereference after kfree()
Date: Mon, 06 Apr 2009 23:56:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904062354360.5698@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:42596 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZDGD4v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 23:56:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP00JE1PMNUAMA@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 06 Apr 2009 22:56:50 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>
Date: Thu, 2 Apr 2009 08:29:56 +0300
Subject: [PATCH] dock: fix dereference after kfree()

upstream f240729832dff3785104d950dad2d3ced4387f6d

dock_remove() calls kfree() on dock_station so we should use
list_for_each_entry_safe() to avoid dereferencing freed memory.

Found by smatch (http://repo.or.cz/w/smatch.git/).  Compile tested.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 35094f2..8f62fa0 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -1146,9 +1146,10 @@ static int __init dock_init(void)
 static void __exit dock_exit(void)
 {
 	struct dock_station *dock_station;
+	struct dock_station *tmp;
 
 	unregister_acpi_bus_notifier(&dock_acpi_notifier);
-	list_for_each_entry(dock_station, &dock_stations, sibiling)
+	list_for_each_entry_safe(dock_station, tmp, &dock_stations, sibiling)
 		dock_remove(dock_station);
 }
 
-- 
1.6.2.2.446.gfbdc

