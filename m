From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 6/8] Schedule sysrq poweroff on boot cpu
Date: Thu, 10 Jul 2008 02:04:24 +0200
Message-ID: <200807100204.25010.rjw@sisk.pl>
References: <200807100152.17755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49043 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130AbYGJAGk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 20:06:40 -0400
In-Reply-To: <200807100152.17755.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Rus <harbour@sfinx.od.ua>

From: Zhang Rui <rui.zhang@intel.com>
Subject: Schedule sysrq poweroff on boot cpu

schedule sysrq poweroff on boot cpu.

sysrq poweroff needs to disable nonboot cpus, and we need to run this
on boot cpu to avoid any recursion.
http://bugzilla.kernel.org/show_bug.cgi?id=10897

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
tested-by: Rus <harbour@sfinx.od.ua>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/poweroff.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/poweroff.c
===================================================================
--- linux-2.6.orig/kernel/power/poweroff.c	2008-06-30 16:01:35.000000000 +0800
+++ linux-2.6/kernel/power/poweroff.c	2008-07-03 10:50:05.000000000 +0800
@@ -25,7 +25,8 @@
 
 static void handle_poweroff(int key, struct tty_struct *tty)
 {
-	schedule_work(&poweroff_work);
+	/* run sysrq poweroff on boot cpu */
+	schedule_work_on(first_cpu(cpu_online_map), &poweroff_work);
 }
 
 static struct sysrq_key_op	sysrq_poweroff_op = {





