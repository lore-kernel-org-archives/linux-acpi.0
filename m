From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] ACPI / hotplug: Set kobject name via kobject_add(),
 not kobject_set_name()
Date: Wed, 25 Sep 2013 14:23:04 -0600
Message-ID: <20130925202304.18667.26104.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:52005 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab3IYUXI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 16:23:08 -0400
Received: by mail-ye0-f176.google.com with SMTP id m4so86551yen.21
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2013 13:23:07 -0700 (PDT)
In-Reply-To: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Set the kobject name via kobject_add() instead of using kobject_set_name(),
which is deprecated per Documentation/kobject.txt.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/sysfs.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 05306a5..ea68583 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -763,12 +763,9 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 		goto err_out;
 
 	kobject_init(&hotplug->kobj, &acpi_hotplug_profile_ktype);
-	error = kobject_set_name(&hotplug->kobj, "%s", name);
-	if (error)
-		goto err_out;
 
 	hotplug->kobj.parent = hotplug_kobj;
-	error = kobject_add(&hotplug->kobj, hotplug_kobj, NULL);
+	error = kobject_add(&hotplug->kobj, hotplug_kobj, "%s", name);
 	if (error)
 		goto err_out;
 

