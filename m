From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] ACPI / hotplug: Don't set kobject parent pointer
 explicitly
Date: Wed, 25 Sep 2013 14:23:12 -0600
Message-ID: <20130925202312.18667.49960.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ye0-f179.google.com ([209.85.213.179]:47383 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab3IYUXP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 16:23:15 -0400
Received: by mail-ye0-f179.google.com with SMTP id r6so83807yen.38
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2013 13:23:14 -0700 (PDT)
In-Reply-To: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

kobject_add() sets the parent pointer, so we don't need to do it
explicitly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/sysfs.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index ea68583..7543281 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -764,7 +764,6 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 
 	kobject_init(&hotplug->kobj, &acpi_hotplug_profile_ktype);
 
-	hotplug->kobj.parent = hotplug_kobj;
 	error = kobject_add(&hotplug->kobj, hotplug_kobj, "%s", name);
 	if (error)
 		goto err_out;

