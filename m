From: Len Brown <len.brown@intel.com>
Subject: [PATCH 38/77] ACPI: dock: fix oops when _DCK evaluation fails
Date: Sun, 22 Jul 2007 05:14:23 -0400
Message-ID: <11850957413607-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763201AbXGVJPs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:48 -0400
In-Reply-To: <11850957403722-git-send-email-len.brown@intel.com>
Message-Id: <9254bc845db90a123cf992e983539d0ee409f22a.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dtor@insightbb.com>, Dmitry Torokhov <dtor@mail.ru>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dtor@insightbb.com>

Data returned by acpi_get_name in acpi_buffer is not acpi_object and
therefore should not be cast to it, otherwise we'll get an nice oops
trying to print error message.

Also print name of the ACPI object corresponding to the docking station
and elevate severity of the message printed when _DCK fails to KERN_ERR.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index dc3df93..6192c8b 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -396,12 +396,11 @@ static void handle_dock(struct dock_station *ds, int dock)
 	union acpi_object arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 
 	acpi_get_name(ds->handle, ACPI_FULL_PATHNAME, &name_buffer);
-	obj = name_buffer.pointer;
 
-	printk(KERN_INFO PREFIX "%s\n", dock ? "docking" : "undocking");
+	printk(KERN_INFO PREFIX "%s - %s\n",
+		(char *)name_buffer.pointer, dock ? "docking" : "undocking");
 
 	/* _DCK method has one argument */
 	arg_list.count = 1;
@@ -410,7 +409,8 @@ static void handle_dock(struct dock_station *ds, int dock)
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
 	if (ACPI_FAILURE(status))
-		pr_debug("%s: failed to execute _DCK\n", obj->string.pointer);
+		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
+			 (char *)name_buffer.pointer);
 	kfree(buffer.pointer);
 	kfree(name_buffer.pointer);
 }
-- 
1.5.3.rc2.22.g69a9b
