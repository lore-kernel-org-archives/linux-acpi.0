From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/9] ACPI: silence kmemcheck false positive
Date: Thu, 06 May 2010 03:03:13 -0400
Message-ID: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60921 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab0EFHDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:41 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z0072RKXNPLO9@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:29 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <error27@gmail.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
 
-- 
1.6.0.6

