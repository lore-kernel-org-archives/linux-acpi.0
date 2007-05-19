From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] Hibernation: Prepare to enter the low power state (updated)
Date: Sat, 19 May 2007 20:32:13 +0200
Message-ID: <200705192032.13577.rjw@sisk.pl>
References: <200705191227.47325.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40240 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759595AbXESS0q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 14:26:46 -0400
In-Reply-To: <200705191227.47325.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Sorry, the code ordering was wrong in the previous version.

---
From: Rafael J. Wysocki <rjw@sisk.pl>

During hibernation we call hibernation_ops->prepare() before creating the image,
but then, before saving it, we cancel the power transition by calling
hibernation_ops->finish().  Thus prior to calling hibernation_ops->enter() we
should let the platform firmware know that we're going to enter the low power
state after all.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6.22-rc2/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc2.orig/kernel/power/disk.c	2007-05-19 11:25:56.000000000 +0200
+++ linux-2.6.22-rc2/kernel/power/disk.c	2007-05-19 12:43:52.000000000 +0200
@@ -205,12 +205,23 @@ int hibernation_restore(int platform_mod
 
 int hibernation_platform_enter(void)
 {
+	int error;
+
 	if (hibernation_ops) {
 		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		return hibernation_ops->enter();
+		/*
+		 * We have cancelled the power transition by running
+		 * hibernation_ops->finish() before saving the image, so we
+		 * should let the firmware know that we're going to enter the
+		 * sleep state after all
+		 */
+		error = hibernation_ops->prepare();
+		if (!error)
+			error = hibernation_ops->enter();
 	} else {
-		return -ENOSYS;
+		error = -ENOSYS;
 	}
+	return error;
 }
 
 /**
