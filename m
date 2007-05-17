From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: [PATCH] Workaround for a PCI restoring bug
Date: Thu, 17 May 2007 22:50:18 +0200
Message-ID: <20070517205017.GA3593@ics.muni.cz>
References: <200705161925.53410.rjw@sisk.pl> <CFF307C98FEABE47A452B27C06B85BB6031BCDF6@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:58201 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477AbXEQUwP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 16:52:15 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6031BCDF6@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org

> Yep -- here's the quote from ACPI 3.0b:
>=20
> OSPM will invoke _GTS, _PTS, _TTS, _WAK, and _BFS in the following
> order:
> 1.OSPM decides (through a policy scheme) to place the system into a
> sleeping state.
> 2._TTS(Sx) is run, where Sx is the desired sleep state to enter.
> 3. OSPM notifies all native device drivers of the sleep state transit=
ion
> 4._PTS is run
> 5.OSPM readies system for the sleep state transition
> 6._GTS is run
> 7.OSPM writes the sleep vector and the system enters the specified Sx
> sleep state.
> 8.System Wakes up
> 9._BFS is run
> 10.OSPM readies system for the return from the sleep state transition
> 11._WAK is run
> 12. OSPM notifies all native device drivers of the return from the sl=
eep
> state transition
> 13._TTS(0) is run to indicate the return to the S0 state.
>=20
> Technically we write the sleep vector too early as well.
> And we don't evaluate _TTS at all -- though _TTS was
> added only as of ACPI 3.0 and I've not seen it implemented on
> any of the systems I've got.

However, we still do something wrong with ACPI and suspend-to-ram becau=
se my
system is unable to reboot after resume from ram. The only way to reboo=
t is to
disable the ACPI in the machine_emergency_restart(). (in particular, ke=
yboard
LEDs flash as the reset has been issued but the BIOS logo does not appe=
ar.)

Any ideas, Len?

Andrew dislikes the patch resulted from this bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=3D6655

Anyway, it works for me pretty well.

--=20
Luk=E1=B9 Hejtm=E1nek
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
