From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] PM: Do not destroy/create devices while suspended in cpuid.c
Date: Wed, 2 Jan 2008 00:42:11 +0100
Message-ID: <200801020042.12466.rjw@sisk.pl>
References: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38092 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936AbYAAXkv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jan 2008 18:40:51 -0500
In-Reply-To: <200801020032.45529.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

The cpuid driver should not attempt to destroy/create a device while
suspended, unless this device corresponds to a nonboot CPU that
failed to go online during a resume, in which case the PM core should
be asked to remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/cpuid.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpuid.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpuid.c
+++ linux-2.6/arch/x86/kernel/cpuid.c
@@ -157,15 +157,15 @@ static int __cpuinit cpuid_class_cpu_cal
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
 		err = cpuid_device_create(cpu);
 		break;
 	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
 		cpuid_device_destroy(cpu);
 		break;
+	case CPU_UP_CANCELED_FROZEN:
+		destroy_suspended_device(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+		break;
 	}
 	return err ? NOTIFY_BAD : NOTIFY_OK;
 }
