From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/48] ACPI / PM: Update file information and the list of
 includes in nvs.c
Date: Wed, 12 Jan 2011 05:19:10 -0500
Message-ID: <d146df18c13d16e321efa8ef9b57c95c3bec1722.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab1ALRA1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:27 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:22 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The file information and the list of include in drivers/acpi/nvs.c
are outdated, so update them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/nvs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 57c6fab..7d64809 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -1,7 +1,7 @@
 /*
- * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
+ * nvs.c - Routines for saving and restoring ACPI NVS memory region
  *
- * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ * Copyright (C) 2008-2011 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
  * This file is released under the GPLv2.
  */
@@ -11,7 +11,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/suspend.h>
+#include <linux/acpi.h>
 
 /*
  * Platforms, like ACPI, may want us to save some memory used by them during
-- 
1.7.4.rc1.7.g2cf08

