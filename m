From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/4] swsusp: Remove incorrect code from user.c
Date: Fri, 18 May 2007 00:21:21 +0200
Message-ID: <200705180021.21953.rjw@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60800 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbXEQWYH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 18:24:07 -0400
In-Reply-To: <200705180019.35548.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the code hibernation code in kernel/power/user.c be functionally equivalent
to the corresponding code in kernel/power/disk.c , as it should be.

The calls to the platform functions removed by this patch are incorrect.  They
should be replaced with some other "platform" operations that will be
introduced in one of the subsequent patches.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-08 22:10:36.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-08 23:03:17.000000000 +0200
@@ -179,34 +179,25 @@ static inline int snapshot_suspend(int p
 	return error;
 }
 
-static inline int snapshot_restore(int platform_suspend)
+static inline int snapshot_restore(void)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
-		goto Resume_devices;
+		goto Finish;
 
 	error = disable_nonboot_cpus();
 	if (!error)
 		error = swsusp_resume();
 
 	enable_nonboot_cpus();
- Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
+ Finish:
 	device_resume();
 	resume_console();
- Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore(data->platform_suspend);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:

