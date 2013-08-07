From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ACPI: Print diagnostic messages if device links cannot be created
Date: Thu, 08 Aug 2013 01:55:52 +0200
Message-ID: <13381284.aBozDrehN8@vostro.rjw.lan>
References: <5685060.iNWFUGc9at@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59867 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab3HGXpx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Aug 2013 19:45:53 -0400
In-Reply-To: <5685060.iNWFUGc9at@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Although the device links created by acpi_bind_one() are not
essential from the kernel functionality point of view, user space
may be confused when they are missing, so print diagnostic messages
to the kernel log if they can't be created.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -252,8 +252,15 @@ int acpi_bind_one(struct device *dev, ac
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				   physical_node_name);
+	if (retval)
+		dev_err(&acpi_dev->dev, "Failed to create link %s (%d)\n",
+			physical_node_name, retval);
+
 	retval = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
 				   "firmware_node");
+	if (retval)
+		dev_err(dev, "Failed to create link firmware_node (%d)\n",
+			retval);
 
 	mutex_unlock(&acpi_dev->physical_node_lock);
 

