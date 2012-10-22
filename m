From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] ACPI: Simplify conditional that has the same effect no matter
 what.
Date: Mon, 22 Oct 2012 17:40:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210221738310.5975@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:43238 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab2JVVkl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Oct 2012 17:40:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  not sure if there's something weirdly subtle happening here, but
this looks like a straightforward simplification.

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9eaf708..e76a7f5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -949,12 +949,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
 	dpc->wait = hp ? 1 : 0;

-	if (queue == kacpi_hotplug_wq)
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	else if (queue == kacpi_notify_wq)
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	else
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);

 	/*
 	 * On some machines, a software-initiated SMI causes corruption unless


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
