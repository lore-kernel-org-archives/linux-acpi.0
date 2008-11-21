From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] DOC: fix acpi kernel-parameters
Date: Fri, 21 Nov 2008 13:57:22 -0800
Message-ID: <49272EC2.5080600@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet14.oracle.com ([148.87.113.126]:43276 "EHLO
	rgminet14.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbYKUV7c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Nov 2008 16:59:32 -0500
Received: from rgminet12.oracle.com (rcsinet12.oracle.com [148.87.113.124])
	by rgminet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id mALM0OSB024721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Nov 2008 22:00:25 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Please queue after one of Rafael's patches.  This does not
apply cleanly to Linus-mainline, but it does apply to
linux-next or -mm.



From: Randy Dunlap <randy.dunlap@oracle.com>

Spell out "wrt".  I suspect plenty of people won't know
what that means.

Fix a '}' that should be a ']'.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-parameters.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20081112.orig/Documentation/kernel-parameters.txt
+++ linux-next-20081112/Documentation/kernel-parameters.txt
@@ -158,9 +158,9 @@ and is between 256 and 4096 characters. 
 			s4_nohwsig prevents ACPI hardware signature from being
 			used during resume from hibernation.
 			old_ordering causes the ACPI 1.0 ordering of the _PTS
-			control method, wrt putting devices into low power
-			states, to be enforced (the ACPI 2.0 ordering of _PTS is
-			used by default).
+			control method, with respect to putting devices into
+			low power states, to be enforced (the ACPI 2.0 ordering
+			of _PTS is used by default).
 			s4_nonvs prevents the kernel from saving/restoring the
 			ACPI NVS memory during hibernation.
 
@@ -197,7 +197,7 @@ and is between 256 and 4096 characters. 
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
-	acpi_use_timer_override [HW,ACPI}
+	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have
 			HPET
