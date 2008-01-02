From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended (rev. 2)
Date: Wed, 2 Jan 2008 13:56:58 +0100
Message-ID: <200801021356.59865.rjw@sisk.pl>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41197 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbYABMzC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 07:55:02 -0500
In-Reply-To: <20080102105217.GA14731@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Greg KH <gregkh@suse.de>

On Wednesday, 2 of January 2008, Ingo Molnar wrote:
>=20
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
>=20
> > Hi,
> >=20
> > Some device drivers register CPU hotplug notifiers and use them to=20
> > destroy device objects when removing the corresponding CPUs and to=20
> > create these objects when adding the CPUs back.
> >=20
> > Unfortunately, this is not the right thing to do during=20
> > suspend/hibernation, since in that cases the CPU hotplug notifiers =
are=20
> > called after suspending devices and before resuming them, so the=20
> > operations in question are carried out on the objects representing=20
> > suspended devices which shouldn't be unregistered behing the PM cor=
e's=20
> > back. =A0Although right now it usually doesn't lead to any practica=
l=20
> > complications, it will predictably deadlock if=20
> > gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is=20
> > applied.
> >=20
> > The solution is to prevent drivers from removing/adding devices fro=
m=20
> > within CPU hotplug notifiers during suspend/hibernation using the=20
> > FROZEN bit in the notifier's action argument.  However, this has to=
 be=20
> > done with care, since the devices objects related to the nonboot CP=
Us=20
> > that failed to go online during resume should not be present in the=
=20
> > system.  For this reason, it seems reasonable to introduce a mechan=
ism=20
> > allowing drivers to ask the PM core to remove device objects=20
> > corresponding to suspended devices on their behalf.
> >=20
> > The first patch in the series introduces such a mechanism.  The=20
> > remaining three patches modify the MSR, x86-64 MCE and cpuid driver=
s=20
> > in accordance with the above approach.
>=20
> btw., it would be really, really cool if there was a scriptable way i=
=20
> could test suspend/resume functionality.

=46irst, there are patches queued for 2.6.25 that allow you to test var=
ious
phases of suspend (specifically, patches 09-11 in the series at
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/).

With these patches applied you can do something like:
# echo core > /sys/power/pm_test
# echo mem > /sys/power/state
and it will run the suspend code up to, but not including, entering the=
 sleep
state (it will busy wait for 5 sec. instead).  Then, it will run the re=
sume
code.

There are 6 testing levels available, documented in patch 11 and in the
changelogs.

Second, there's the rtc wakealarm thing that can be used to test the re=
al
suspend.

> Pavel has this /dev/rtc thing to set up an alarm (not sure how functi=
onal it
> is) - would it be possible to have it as a "suspend for 10 seconds th=
en
> resume" debug functionality?

Well, we have the following test script in the userland suspend package=
 that
is supposed to work right now:

#!/bin/bash
date
cd /sys/class/rtc/rtc0
echo $(( $(cat since_epoch) + 20 )) > wakealarm
s2ram
date

provided that the new rtc driver code is compiled (and the old one is n=
ot).

> That way any suspend breakage would be detectable (and bisectable) in
> automated testing - if the resume does not come back after 10-20 seco=
nds then
> the test failed.=20

Yes, but please note that some systems require user space manipulations=
 of the
graphics adapter for suspend to work and to detect a breakage of such a=
 system
you need to boot it into X and use s2ram to suspend.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
