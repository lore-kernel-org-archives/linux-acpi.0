From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/6] PM: Allow serio input devices to suspend/resume asynchronously
Date: Wed, 26 Aug 2009 22:24:19 +0200
Message-ID: <200908262224.19110.rjw@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35954 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZHZU1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 16:27:33 -0400
In-Reply-To: <200908262217.19609.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Set async_suspend for all serio input devices, so that they can be
suspended and resumed asynchronously with other devices they don't
depend on in a known way (i.e. devices which are not their parents
or children and to which they are not connected via struct pm_link
objects).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/input/serio/serio.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/serio.c
+++ linux-2.6/drivers/input/serio/serio.c
@@ -576,6 +576,7 @@ static void serio_add_port(struct serio 
 			printk(KERN_ERR
 				"serio: sysfs_create_group() failed for %s (%s), error: %d\n",
 				serio->phys, serio->name, error);
+		device_enable_async_suspend(&serio->dev, true);
 	}
 }
 

