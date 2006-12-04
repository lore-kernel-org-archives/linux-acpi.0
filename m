From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 3/3] acpi: Fix symbol conflict between acpiphp and dock
Date: Mon, 4 Dec 2006 14:50:17 -0800
Message-ID: <20061204145017.b5f558a3.kristen.c.accardi@intel.com>
References: <20061204224037.713257809@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11130 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759759AbWLDWuQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:50:16 -0500
In-Reply-To: <20061204224037.713257809@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

From: Prarit Bhargava <prarit@redhat.com>

Fix bug which will cause acpiphp to not be able to load when dock.ko
cannot load.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/acpi/dock.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- kristen-2.6.orig/drivers/acpi/dock.c
+++ kristen-2.6/drivers/acpi/dock.c
@@ -443,6 +443,9 @@ static int dock_in_progress(struct dock_
  */
 int register_dock_notifier(struct notifier_block *nb)
 {
+	if (!dock_station)
+		return -ENODEV;
+
 	return atomic_notifier_chain_register(&dock_notifier_list, nb);
 }
 
@@ -454,6 +457,9 @@ EXPORT_SYMBOL_GPL(register_dock_notifier
  */
 void unregister_dock_notifier(struct notifier_block *nb)
 {
+	if (!dock_station)
+		return;
+
 	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
 }
 
@@ -806,7 +812,7 @@ static int __init dock_init(void)
 			    ACPI_UINT32_MAX, find_dock, &num, NULL);
 
 	if (!num)
-		return -ENODEV;
+		printk(KERN_INFO "No dock devices found.\n");
 
 	return 0;
 }

--
