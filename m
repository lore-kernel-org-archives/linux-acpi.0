From: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Sun, 03 Jun 2007 23:20:41 +0200
Message-ID: <87wsykpweu.fsf@goat.bogus.local>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
	<87hcpr2ubl.fsf@goat.bogus.local> <200706020037.16615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:52714 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXFCVUO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jun 2007 17:20:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Second, you can use PM_TRACE (Documentation/power/s2ram.txt) to find the
> place where it really fails.

First I augmented my minimal config kernel with some TRACE_RESUME()s:

--- a/kernel/power/main.c	2007-05-27 23:48:05.000000000 +0200
+++ b/kernel/power/main.c	2007-06-03 22:28:46.000000000 +0200
@@ -223,6 +223,7 @@
 	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish(state);
  Unlock:
+	TRACE_RESUME(error);
 	mutex_unlock(&pm_mutex);
 	return error;
 }
@@ -303,6 +304,7 @@
 		error = enter_state(state);
 	else
 		error = -EINVAL;
+	TRACE_RESUME(error);
 	return error ? error : n;
 }
 
With this test script:

#! /bin/sh

sync
echo 1 >/sys/power/pm_trace
echo mem >/sys/power/state
shutdown -rn now

I got alternating
  hash matches drivers/base/power/resume.c:58
and
  hash matches kernel/power/main.c:307

> First, you can check if the patch
>
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/20-ACPI-preserve-the-ebx-value-in-acpi_copy_wakeup_routine.patch

Then I applied this patch, but it doesn't change anything.

But either way the script never reaches "shutdown -rn now". So, it
seems, that my laptop does a full resume every other reboot, but it
never returns to userspace.

> Also, please read Documentation/power/basic-pm-debugging.txt .

Regards, Olaf.
