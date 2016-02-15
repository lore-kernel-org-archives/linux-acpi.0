From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] drivers/acpi: make bgrt driver explicitly non-modular
Date: Mon, 15 Feb 2016 00:27:49 -0500
Message-ID: <1455514071-26368-2-git-send-email-paul.gortmaker@windriver.com>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55960 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbcBOFa1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2016 00:30:27 -0500
In-Reply-To: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Josh Triplett <josh@joshtriplett.org>, linux-acpi@vger.kernel.org

The Kconfig for this driver is currently:

config ACPI_BGRT
    bool "Boottime Graphics Resource Table support"

...meaning that it currently is not being built as a module by anyone.
Lets remove all modular references, so that when reading the driver
there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/bgrt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index a83e3c62c5a9..75f128e766a9 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -1,4 +1,6 @@
 /*
+ * BGRT boot graphic support
+ * Authors: Matthew Garrett, Josh Triplett <josh@joshtriplett.org>
  * Copyright 2012 Red Hat, Inc <mjg@redhat.com>
  * Copyright 2012 Intel Corporation
  *
@@ -8,7 +10,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
@@ -103,9 +104,4 @@ out_kobject:
 	kobject_put(bgrt_kobj);
 	return ret;
 }
-
-module_init(bgrt_init);
-
-MODULE_AUTHOR("Matthew Garrett, Josh Triplett <josh@joshtriplett.org>");
-MODULE_DESCRIPTION("BGRT boot graphic support");
-MODULE_LICENSE("GPL");
+device_initcall(bgrt_init);
-- 
2.6.1

