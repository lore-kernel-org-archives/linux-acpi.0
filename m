From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/9] acpi_pad: "processor_aggregator" name too long
Date: Thu, 06 May 2010 03:03:18 -0400
Message-ID: <a40770a9537c72b555667851845e73484b22ba17.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:48985 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab0EFHDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:43 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00FHHKXQYEA0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:26 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, walter harms <wharms@bfs.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <error27@gmail.com>

cpi_device_class can only be 19 characters and a NULL terminator.

With the current name we get a buffer overflow in acpi_pad_add()
	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);

[akpm@linux-foundation.org: call it acpi_pad, per Shaohua Li]
Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: walter harms <wharms@bfs.de>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 19dacfd..6212213 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -31,7 +31,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"processor_aggregator"
+#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 static DEFINE_MUTEX(isolated_cpus_lock);
-- 
1.6.0.6

