From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] ACPI / hotplug: Use kobject_init_and_add() instead of
 _init() and _add()
Date: Wed, 25 Sep 2013 14:23:20 -0600
Message-ID: <20130925202319.18667.46523.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:40336 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3IYUXW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 16:23:22 -0400
Received: by mail-yh0-f50.google.com with SMTP id a41so104737yho.23
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2013 13:23:22 -0700 (PDT)
In-Reply-To: <20130925202037.18667.31220.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use kobject_init_and_add() since we have nothing special to do between
kobject_init() and kobject_add().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/sysfs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7543281..bb6045c 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -762,9 +762,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 	if (!hotplug_kobj)
 		goto err_out;
 
-	kobject_init(&hotplug->kobj, &acpi_hotplug_profile_ktype);
-
-	error = kobject_add(&hotplug->kobj, hotplug_kobj, "%s", name);
+	error = kobject_init_and_add(&hotplug->kobj,
+		&acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
 	if (error)
 		goto err_out;
 

