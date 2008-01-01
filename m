From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] PM: Do not destroy/create devices while suspended (rev. 2)
Date: Wed, 2 Jan 2008 00:32:44 +0100
Message-ID: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38105 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbYAAXk4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jan 2008 18:40:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

Hi,

Some device drivers register CPU hotplug notifiers and use them to dest=
roy
device objects when removing the corresponding CPUs and to create these=
 objects
when adding the CPUs back.

Unfortunately, this is not the right thing to do during suspend/hiberna=
tion,
since in that cases the CPU hotplug notifiers are called after suspendi=
ng
devices and before resuming them, so the operations in question are car=
ried
out on the objects representing suspended devices which shouldn't be
unregistered behing the PM core's back. =A0Although right now it usuall=
y doesn't
lead to any practical complications, it will predictably deadlock if
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is appl=
ied.

The solution is to prevent drivers from removing/adding devices from wi=
thin
CPU hotplug notifiers during suspend/hibernation using the FROZEN bit
in the notifier's action argument.  However, this has to be done with c=
are,
since the devices objects related to the nonboot CPUs that failed to go=
 online
during resume should not be present in the system.  For this reason, it=
 seems
reasonable to introduce a mechanism allowing drivers to ask the PM core=
 to
remove device objects corresponding to suspended devices on their behal=
f.

The first patch in the series introduces such a mechanism.  The remaini=
ng three
patches modify the MSR, x86-64 MCE and cpuid drivers in accordance with=
 the
above approach.

Thanks,
Rafael

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
