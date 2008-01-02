From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended
	(rev. 2)
Date: Wed, 2 Jan 2008 11:52:17 +0100
Message-ID: <20080102105217.GA14731@elte.hu>
References: <200801020032.45529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54078 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041AbYABKxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jan 2008 05:53:08 -0500
Content-Disposition: inline
In-Reply-To: <200801020032.45529.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Greg KH <gregkh@suse.de>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Hi,
>=20
> Some device drivers register CPU hotplug notifiers and use them to=20
> destroy device objects when removing the corresponding CPUs and to=20
> create these objects when adding the CPUs back.
>=20
> Unfortunately, this is not the right thing to do during=20
> suspend/hibernation, since in that cases the CPU hotplug notifiers ar=
e=20
> called after suspending devices and before resuming them, so the=20
> operations in question are carried out on the objects representing=20
> suspended devices which shouldn't be unregistered behing the PM core'=
s=20
> back. =A0Although right now it usually doesn't lead to any practical=20
> complications, it will predictably deadlock if=20
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is=20
> applied.
>=20
> The solution is to prevent drivers from removing/adding devices from=20
> within CPU hotplug notifiers during suspend/hibernation using the=20
> FROZEN bit in the notifier's action argument.  However, this has to b=
e=20
> done with care, since the devices objects related to the nonboot CPUs=
=20
> that failed to go online during resume should not be present in the=20
> system.  For this reason, it seems reasonable to introduce a mechanis=
m=20
> allowing drivers to ask the PM core to remove device objects=20
> corresponding to suspended devices on their behalf.
>=20
> The first patch in the series introduces such a mechanism.  The=20
> remaining three patches modify the MSR, x86-64 MCE and cpuid drivers=20
> in accordance with the above approach.

btw., it would be really, really cool if there was a scriptable way i=20
could test suspend/resume functionality. Pavel has this /dev/rtc thing=20
to set up an alarm (not sure how functional it is) - would it be=20
possible to have it as a "suspend for 10 seconds then resume" debug=20
functionality? That way any suspend breakage would be detectable (and=20
bisectable) in automated testing - if the resume does not come back=20
after 10-20 seconds then the test failed.

	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
