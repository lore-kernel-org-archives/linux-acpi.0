From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/14] ACPI: remove doubled status checking
Date: Mon, 16 Mar 2009 01:23:50 -0400
Message-ID: <176f9c1804df09f3e9b998c0642e212592ac6283.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:65445 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZCPFYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL0027G305P7HE@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:05 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Jiri Slaby <jirislaby@gmail.com>

There was a misplaced status test (two consequent tests without a
statement in between) in acpi_bus_init for ages.  Remove it, since the
function which should be checked (acpi_os_initialize1) has BUG_ONs on
failure paths.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 765fd1c..bee64b7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -758,8 +758,7 @@ static int __init acpi_bus_init(void)
 	acpi_status status = AE_OK;
 	extern acpi_status acpi_os_initialize1(void);
 
-
-	status = acpi_os_initialize1();
+	acpi_os_initialize1();
 
 	status =
 	    acpi_enable_subsystem(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE);
@@ -769,12 +768,6 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to initialize ACPI OS objects\n");
-		goto error1;
-	}
-
 	/*
 	 * ACPI 2.0 requires the EC driver to be loaded and work before
 	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
-- 
1.5.6.6

