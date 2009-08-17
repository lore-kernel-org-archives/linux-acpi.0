From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume of i8042
Date: Mon, 17 Aug 2009 02:21:34 +0200
Message-ID: <200908170221.34885.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46005 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbZHQAWb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Aug 2009 20:22:31 -0400
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

Set async_suspend for i8042.

---
 drivers/input/serio/i8042.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/i8042.c
+++ linux-2.6/drivers/input/serio/i8042.c
@@ -1289,6 +1289,8 @@ static int __init i8042_init(void)
 	if (err)
 		goto err_free_device;
 
+	device_enable_async_suspend(&i8042_platform_device->dev, true);
+
 	panic_blink = i8042_panic_blink;
 
 	return 0;
