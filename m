From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/4] PM: Do not destroy/create devices while suspended in mce_64.c
Date: Wed, 2 Jan 2008 00:40:55 +0100
Message-ID: <200801020040.56983.rjw@sisk.pl>
References: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38100 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbYAAXkw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jan 2008 18:40:52 -0500
In-Reply-To: <200801020032.45529.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

The x86-64 MCE driver should not attempt to destroy/create a suspended
device, unless it corresponds to a nonboot CPU that failed to go online during
a resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/cpu/mcheck/mce_64.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpu/mcheck/mce_64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/mcheck/mce_64.c
+++ linux-2.6/arch/x86/kernel/cpu/mcheck/mce_64.c
@@ -862,11 +862,10 @@ mce_cpu_callback(struct notifier_block *
 
 	switch (action) {
 	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
 		mce_create_device(cpu);
 		break;
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
+	case CPU_UP_CANCELED_FROZEN:
 		mce_remove_device(cpu);
 		break;
 	}

