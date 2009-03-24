From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/3] ACPI: remove unused acpi_device_ops .lock and .scan
	methods
Date: Tue, 24 Mar 2009 10:55:22 -0600
Message-ID: <20090324165522.25119.23560.stgit@bob.kio>
References: <20090324165420.25119.78955.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:18989 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762677AbZCXQzZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 12:55:25 -0400
In-Reply-To: <20090324165420.25119.78955.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Rajesh Shah <rajesh.shah@intel.com>

No drivers use the .lock and .scan methods, and the Linux/ACPI
code doesn't even provide a way to invoke them, so remove them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 include/acpi/acpi_bus.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e9f6574..e3c5a4e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -88,13 +88,11 @@ struct acpi_device;
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
-typedef int (*acpi_op_lock) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef int (*acpi_op_stop) (struct acpi_device * device, int type);
 typedef int (*acpi_op_suspend) (struct acpi_device * device,
 				pm_message_t state);
 typedef int (*acpi_op_resume) (struct acpi_device * device);
-typedef int (*acpi_op_scan) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef int (*acpi_op_shutdown) (struct acpi_device * device);
@@ -117,12 +115,10 @@ struct acpi_bus_ops {
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_lock lock;
 	acpi_op_start start;
 	acpi_op_stop stop;
 	acpi_op_suspend suspend;
 	acpi_op_resume resume;
-	acpi_op_scan scan;
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_shutdown shutdown;

