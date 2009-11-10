From: Dan Carpenter <error27@gmail.com>
Subject: [patch] move null check earlier
Date: Tue, 10 Nov 2009 10:56:26 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911081929420.10055@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47467 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZKJI4b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 03:56:31 -0500
Received: by bwz27 with SMTP id 27so4301537bwz.21
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2009 00:56:35 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I moved the null dereference after the check.  It is unlikely to make any 
difference, but it's the right thing to do and it makes my static checker 
happy.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/drivers/acpi/processor_throttling.c	2009-11-08 19:26:09.000000000 +0200
+++ devel/drivers/acpi/processor_throttling.c	2009-11-08 19:27:10.000000000 +0200
@@ -1133,15 +1133,15 @@
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
+	if (!pr)
+		return -EINVAL;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
 			  pr->throttling.duty_offset,
 			  pr->throttling.duty_width));
 
-	if (!pr)
-		return -EINVAL;
-
 	/*
 	 * Evaluate _PTC, _TSS and _TPC
 	 * They must all be present or none of them can be used.
