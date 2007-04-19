From: Thomas Renninger <trenn@suse.de>
Subject: HP nx8220 psmouse vs ACPI at boot up
Date: Thu, 19 Apr 2007 14:44:58 +0200
Message-ID: <1176986698.1231.390.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:51640 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S637744AbXDSMo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 08:44:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, kssingvo@suse.de

Hi,

I first thought it's the "unload psmouse" or "cleanup psmouse ports"
at shutdown problem again.

I think this time EC gets confused at boot time.
Compiling psmouse as module helps again.

Symptom:
AC adapter status is wrong if booted with AC unplugged.
Replugging helps.
This sounds like a minor bug, but ACPI errors at other places
with AE_TIME errors also happen and theoretically all kind of
ACPI breakage could happen...

I can reproduce this with a 2.6.18 and a 2.6.16 kernel.
Latest 2.6.21-rc7 does not show the problem.
I wonder whether this really got fixed or whether this
is just because psmouse gets activated at some earlier or later
time because of other changes in the kernel.

This looks a bit related to the 
"Could the k8temp driver be interfering with ACPI"
discussion. It seems as if mouse ports should not get touched
when ACPI is accessing the EC on HP laptops (and others?) in general?

I can't access the machine anymore, I possibly can have it for
some more tests.
I just want to point out that there still could be trouble.

   Thomas

I thought that attached patch helps (exclude psmouse init and ACPI
interpreter). But it seems that not.
Hmm, so strange, I removed processor, fan and thermal module to not be
loaded via initrd -> works. However adding them again still works, maybe
they are loaded in different order. Really confused now, as this problem
is a BIOS problem and what I see cannot get cleanly workarounded I am
giving up.

---
 drivers/input/mouse/psmouse-base.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6.18-SL102_BRANCH/drivers/input/mouse/psmouse-base.c
===================================================================
--- linux-2.6.18-SL102_BRANCH.orig/drivers/input/mouse/psmouse-base.c
+++ linux-2.6.18-SL102_BRANCH/drivers/input/mouse/psmouse-base.c
@@ -22,6 +22,8 @@
 #include <linux/libps2.h>
 #include <linux/mutex.h>
 
+#include <acpi/acpi.h>
+
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
@@ -1513,6 +1515,14 @@ static int psmouse_get_maxproto(char *bu
 
 static int __init psmouse_init(void)
 {
+	acpi_status status;
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
+	if (status) {
+		printk (KERN_ERR "%s - Could not acquire ACPI interpreter"
+			" mutex\n", __FUNCTION__);
+	}
+
 	kpsmoused_wq = create_singlethread_workqueue("kpsmoused");
 	if (!kpsmoused_wq) {
 		printk(KERN_ERR "psmouse: failed to create kpsmoused workqueue\n");
@@ -1521,6 +1531,12 @@ static int __init psmouse_init(void)
 
 	serio_register_driver(&psmouse_drv);
 
+	status = acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	if (status) {
+		printk (KERN_ERR "%s - Could not release ACPI interpreter"
+			" mutex\n", __FUNCTION__);
+	}
+
 	return 0;
 }
 


