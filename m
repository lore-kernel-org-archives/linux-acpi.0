From: akpm@linux-foundation.org
Subject: [patch 4/4] acpi_pad: "processor_aggregator" name too long
Date: Tue, 27 Apr 2010 14:06:05 -0700
Message-ID: <201004272106.o3RL66mW019664@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56756 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077Ab0D0VGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 17:06:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, error27@gmail.com, pavel@ucw.cz, shaohua.li@intel.com, wharms@bfs.de

From: Dan Carpenter <error27@gmail.com>

cpi_device_class can only be 19 characters and a NULL terminator.

With the current name we get a buffer overflow in acpi_pad_add()
	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);

[akpm@linux-foundation.org: call it acpi_pad, per Shaohua Li]
Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: walter harms <wharms@bfs.de>
Cc: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/acpi_pad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/acpi_pad.c~acpi_pad-processor_aggregator-name-too-long drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~acpi_pad-processor_aggregator-name-too-long
+++ a/drivers/acpi/acpi_pad.c
@@ -31,7 +31,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"processor_aggregator"
+#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 static DEFINE_MUTEX(isolated_cpus_lock);
_
