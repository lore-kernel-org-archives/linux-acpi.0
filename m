From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/4] swsusp: Fix hibernation code ordering
Date: Fri, 18 May 2007 00:26:20 +0200
Message-ID: <200705180026.20647.rjw@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60806 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030AbXEQWYI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 18:24:08 -0400
In-Reply-To: <200705180019.35548.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

Change the code ordering so that hibernation_ops->prepare() is called after
device_suspend().  This is needed so that we don't violate the ACPI
specification, which states that the _PTS and _GTS system-control methods,
executed from acpi_sleep_prepare(), ought to be called after devices have been
put in low power states.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22-rc1/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc1.orig/kernel/power/disk.c	2007-05-17 22:53:27.000000000 +0200
+++ linux-2.6.22-rc1/kernel/power/disk.c	2007-05-17 22:56:24.000000000 +0200
@@ -135,15 +135,15 @@ int hibernation_snapshot(int platform_mo
 	if (error)
 		goto Finish;
 
-	error = platform_prepare(platform_mode);
-	if (error)
-		goto Finish;
-
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error)
 		goto Resume_devices;
 
+	error = platform_prepare(platform_mode);
+	if (error)
+		goto Resume_devices;
+
 	error = disable_nonboot_cpus();
 	if (!error) {
 		if (hibernation_mode != HIBERNATION_TEST) {
