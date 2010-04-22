From: Dan Carpenter <error27@gmail.com>
Subject: [patch] acpi: silence kmemcheck false positive
Date: Thu, 22 Apr 2010 21:43:46 +0200
Message-ID: <20100422194346.GB29093@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62007 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424Ab0DVToI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2010 15:44:08 -0400
Received: by wyb39 with SMTP id 39so5103048wyb.19
        for <linux-acpi@vger.kernel.org>; Thu, 22 Apr 2010 12:44:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, vegardno@ifi.uio.no

This addresses: https://bugzilla.kernel.org/show_bug.cgi?id=14998

We copy some strings into "event" and kmemcheck complains that the bytes 
after the NULL terminators are uninitialized.  That's true but it's
harmless.  The "event" struct is used in acpi_system_read_event() and we
don't read past the terminator.

This patch just silences the warning.

Reported-by: Christian Casteyde <casteyde.christian@free.fr>
Signed-off-by: Dan Carpenter <error27@gmail.com>
Tested-by: Christian Casteyde <casteyde.christian@free.fr>

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 37132dc..4ef7c97 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -527,7 +527,7 @@ int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id,
 	if (!event_is_open)
 		return 0;
 
-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
+	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC | __GFP_NOTRACK_FALSE_POSITIVE);
 	if (!event)
 		return -ENOMEM;
 
