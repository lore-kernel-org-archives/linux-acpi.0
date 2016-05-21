From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0008/1529] Fix typo
Date: Sat, 21 May 2016 13:36:30 +0200
Message-ID: <20160521113630.31693-1-andrea.gelmini@gelma.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34156 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcEULgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 May 2016 07:36:35 -0400
Received: by mail-lb0-f195.google.com with SMTP id t6so41354lbv.1
        for <linux-acpi@vger.kernel.org>; Sat, 21 May 2016 04:36:35 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/acpi/namespace.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/acpi/namespace.txt b/Documentation/acpi/namespace.txt
index 1860cb3..fa84300 100644
--- a/Documentation/acpi/namespace.txt
+++ b/Documentation/acpi/namespace.txt
@@ -28,7 +28,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
    Description Table) using its first entry, the data within the FADT
    includes various fixed-length entries that describe fixed ACPI features
    of the hardware.  The FADT contains a pointer to the DSDT
-   (Differentiated System Descripition Table).  The XSDT also contains
+   (Differentiated System Description Table).  The XSDT also contains
    entries pointing to possibly multiple SSDTs (Secondary System
    Description Table).
 
-- 
2.8.2.534.g1f66975

