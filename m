From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/9] PM: Allow ACPI devices to suspend/resume asynchronously
Date: Thu, 10 Sep 2009 01:37:38 +0200
Message-ID: <200909100137.38335.rjw@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200909100127.11252.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Set async_suspend for all ACPI devices, so that they can be suspended
and resumed asynchronously with other devices they don't depend on in
a known way (i.e. devices which are not their parents or children and
to which they are not connected via struct pm_link objects).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -539,6 +539,7 @@ static int acpi_device_register(struct a
 		       dev_name(&device->dev));
 
 	device->removal_type = ACPI_BUS_REMOVAL_NORMAL;
+	device_enable_async_suspend(&device->dev, true);
 	return 0;
 end:
 	mutex_lock(&acpi_device_lock);
