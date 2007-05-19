From: Tear <tarrqt@yahoo.com>
Subject: [patch] Dell Optiplex GX240, ACPI and APIC
Date: Sat, 19 May 2007 03:00:27 -0700 (PDT)
Message-ID: <147799.82847.qm@web63612.mail.re1.yahoo.com>
References: <20070512103441.a21194fc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from n8.bullet.re3.yahoo.com ([68.142.237.93]:27068 "HELO
	n8.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755946AbXESKA2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 May 2007 06:00:28 -0400
In-Reply-To: <20070512103441.a21194fc.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello,

This patch removes Dell Optiplex GX240 from
the ACPI blacklist.

Please see the following for more information:

http://marc.info/?l=linux-kernel&m=117897875024464&w=2

Regards,
- Tear

--- linux-2.6.21.1.orig/arch/i386/kernel/acpi/boot.c	2007-05-01 17:10:30.000000000 +0300
+++ linux-2.6.21.1/arch/i386/kernel/acpi/boot.c	2007-05-01 20:31:53.000000000 +0300
@@ -971,14 +971,6 @@
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "DELL GX240",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
-		     DMI_MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "HP VISUALIZE NT Workstation",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),





       
____________________________________________________________________________________Get the Yahoo! toolbar and be alerted to new email wherever you're surfing.
http://new.toolbar.yahoo.com/toolbar/features/mail/index.php

