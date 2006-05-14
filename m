From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] mem-leak fix for acpi_thermal_write_trip_points()
Date: Sun, 14 May 2006 02:28:58 +0200
Message-ID: <200605140228.58460.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:23075 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964828AbWENA2H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 May 2006 20:28:07 -0400
Received: by nf-out-0910.google.com with SMTP id c31so192435nfb
        for <linux-acpi@vger.kernel.org>; Sat, 13 May 2006 17:28:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andy Grover <andrew.grover@intel.com>, Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>

There's a memory leak in
 drivers/acpi/thermal.c::acpi_thermal_write_trip_points()
found by the Coverity checker as bug #1243

The problem is simply that if the allocation of 'active' fails, then we'll
return from the function without freeing the memory previously allocated 
to 'limit_string'.

One fix would have been the insertion of kfree(limit_string); just before
the return_VALUE(-ENOMEM); call, but I chose a different fix.
Except for this one return the function only has a single exit point at 
the end: label, and there it does proper cleanup of everything. So even 
though setting the return value (the 'count' variable) and jumping there 
results in a pointless kfree(NULL) call (since 'active' will be NULL), I 
thought this was a small price to pay for the bennefit of having just a 
single exit path for the function.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/thermal.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/acpi/thermal.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4-git2/drivers/acpi/thermal.c	2006-05-14 02:18:30.000000000 +0200
@@ -942,8 +942,10 @@ acpi_thermal_write_trip_points(struct fi
 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
 
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
-	if (!active)
-		return_VALUE(-ENOMEM);
+	if (!active) {
+		count = -ENOMEM;
+		goto end;
+	}
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));



