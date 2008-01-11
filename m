From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend (rev. 3)
Date: Fri, 11 Jan 2008 10:07:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801111006410.4263-100000@iolanthe.rowland.org>
References: <200801110216.35446.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55016 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756100AbYAKPHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 10:07:40 -0500
In-Reply-To: <200801110216.35446.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 11 Jan 2008, Rafael J. Wysocki wrote:

> Hi,
>=20
> The patch below is intended as a replacement for
> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch that =
deadlocked
> suspend and hibernation on some systems. =C2=A0The present patch cont=
ains some
> safeguards against deadlocks in the relevant cases and a mechanism to=
 print
> warnings if a deadlock is probable.
>=20
> Greetings,
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>, Alan Stern <stern@rowland.harv=
ard.edu>
>=20
> This patch reorganizes the way suspend and resume notifications are
> sent to drivers.  The major changes are that now the PM core acquires
> every device semaphore before calling the methods, and calls to
> device_add() during suspends will fail, while calls to device_del()
> during suspends will block.
>=20
> It also provides a way to safely remove a suspended device with the
> help of the PM core, by using the device_pm_schedule_removal() callba=
ck
> introduced specifically for this purpose, and updates two drivers (ms=
r
> and cpuid) that need to use it.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
