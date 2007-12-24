From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM: Do not destroy/create devices while suspended
Date: Mon, 24 Dec 2007 01:55:13 +0100
Message-ID: <200712240155.14765.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57116 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXLXAjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Dec 2007 19:39:25 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>

Hi,

Some device drivers register CPU hotplug notifiers and use them to destroy
device objects when removing the corresponding CPUs and to create these objects
when adding the CPUs back.

Unfortunately, this is not the right thing to do during suspend/hibernation,
since in that cases the CPU hotplug notifiers are called after suspending
devices and before resuming them, so the operations in question are carried
out on the objects representing suspended devices which shouldn't be
unregistered behing the PM core's back.  Although right now it usually doesn't
lead to any practical complications, it will predictably deadlock if
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is applied.

The solution is to prevent drivers from removing/adding devices from within
CPU hotplug notifiers during suspend/hibernation using the FROZEN bit
in the notifier's action argument.  The following three patches modify the
MSR, x86-64 MCE and cpuid drivers along these lines.

Thanks,
Rafael

