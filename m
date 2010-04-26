From: Dan Carpenter <error27@gmail.com>
Subject: [patch v2] acpi: silence kmemcheck false positive
Date: Tue, 27 Apr 2010 00:23:37 +0200
Message-ID: <20100426222337.GX29093@bicker>
References: <20100422194346.GB29093@bicker> <20100422200220.GC29093@bicker> <201004221632.21129.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63937 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab0DZWX4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2010 18:23:56 -0400
Received: by wyb42 with SMTP id 42so303372wyb.19
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2010 15:23:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004221632.21129.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, vegardno@ifi.uio.no, casteyde.christian@free.fr

This addresses: https://bugzilla.kernel.org/show_bug.cgi?id=14998

We copy some strings into "event" but we leave the space after the NULL
terminators uninitialized.  Later in acpi_bus_receive_event() we copy
the whole struct to another buffer with memcpy().  If the new buffer is
stored on the stack, kmemcheck prints a warning about the unitialized 
space after the NULL terminators.

It's true that the space is uninitialized, but it's harmless.  The
buffer is only used in acpi_system_read_event() and we don't read past
the NULL terminators.

This patch changes the kmalloc() to kzalloc() so that we initialize the 
memory and silence the kmemcheck warning.

Reported-by: Christian Casteyde <casteyde.christian@free.fr>
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2:  In the first version I used __GFP_NOTRACK_FALSE_POSITIVE to silence
the warning, but that was ugly so this version initializes the memory with
kzalloc()

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 37132dc..743576b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -527,7 +527,7 @@ int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id,
 	if (!event_is_open)
 		return 0;
 
-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
+	event = kzalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
 	if (!event)
 		return -ENOMEM;
 
