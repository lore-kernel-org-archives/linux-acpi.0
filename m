From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] ACPI/init: Correct the comments about acpi_subsystem_init
Date: Mon,  4 Jul 2016 11:13:59 +0800
Message-ID: <1467602039-13186-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbcGDDOG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Jul 2016 23:14:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

In acpi_subsystem_init, function acpi_enable_subsystem is called to do
the real job. However with different flags passed to acpi_enable_subsystem,
different code is executed. In acpi_subsystem_init with "~ACPI_NO_ACPI_ENABLE"
passed in it will only switch over the platform to the ACPI mode. The rest
part of acpi_enable_subsystem is done when acpi_bus_init is called.

So the comments above acpi_subsystem_init is not exact, change it here.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/acpi/bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 262ca31..eef468d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -961,8 +961,7 @@ void __init acpi_early_init(void)
 /**
  * acpi_subsystem_init - Finalize the early initialization of ACPI.
  *
- * Switch over the platform to the ACPI mode (if possible), initialize the
- * handling of ACPI events, install the interrupt and global lock handlers.
+ * Switch over the platform to the ACPI mode (if possible).
  *
  * Doing this too early is generally unsafe, but at the same time it needs to be
  * done before all things that really depend on ACPI.  The right spot appears to
-- 
2.5.5

