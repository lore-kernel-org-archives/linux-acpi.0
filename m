From: Bernhard =?iso-8859-1?q?Rosenkr=E4nzer?= <bero@arklinux.ch>
Subject: Acer Aspire 7720 shutdown problems and DSDT fixes
Date: Sun, 24 Aug 2008 18:22:18 +0200
Message-ID: <200808241822.18839.bero@arklinux.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.arklinux.osuosl.org ([140.211.166.25]:48725 "EHLO
	forum.arklinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYHXQ1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Aug 2008 12:27:55 -0400
Received: from [192.168.1.33] (132-209.76-83.cust.bluewin.ch [83.76.209.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.arklinux.org (Postfix) with ESMTPSA id 527567C058F
	for <linux-acpi@vger.kernel.org>; Sun, 24 Aug 2008 16:59:37 +0000 (UTC)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I recently got an Acer Aspire 7720 using BIOS 1.43. Obviously, the firs=
t thing=20
to do was install Linux (currently running 2.6.27-rc4).

Everything is working, but under heavy load, the machine tends to shut =
down=20
without prior warning. Unlike the similar problem described at=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D9167, /proc/acpi/thermal_z=
one/TZ01/temperature=20
does show the correct temperature all the time, and the fan does turn o=
n.

I've looked at the DSDT and found a huge number of obvious bugs (_OSC t=
aking=20
the wrong number of arguments and actually having an off-by-one bug whe=
n=20
looking at the arguments -- looks like someone didn't know ACPI argumen=
ts=20
start at Arg0 and then increased the argument count by 1 so he could ge=
t the=20
4th argument in Arg4; Funny comparisons like
If (LOr (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D7)))
(not that that could ever not be true...); doesn't even compile.....), =
but=20
fixing them doesn't help.

I've tried all sorts of things to get it to behave, including patching =
the=20
DSDT to actually know about the fact that TZ01 is connected to the CPUs=
 and=20
throttling the CPUs may help:

            Method (_PSV, 0, Serialized)
            {
                Return (3552) // 3552 =3D (273.2+82.0)*10
            }

            Method (_PSL, Package() {
                \_PR.CPU0,
                \_PR.CPU1
            })

            Name (_TC1, 3)
            Name (_TC2, 4)
            Name (_TSP, 20)
            Name (_TZP, Zero)

(This part works nicely by the way)

But at some point, it still shuts down.

Looking at sensors output, the box seems to shut down when it hits 85.0=
=B0C,=20
which is also what the coretemp module thinks is right (tjmax value) --=
 but=20
the DSDT sets the trip point at 110=B0C:

            Method (_CRT, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (0x6E, 0x0A)))
            }

Guess this explains why I'm getting a sudden shutdown instead of a clea=
n=20
shutdown through acpid - adjusting _CRT to return 84=B0C doesn't fix th=
e=20
problem, but does let acpid shut down the system gracefully instead of =
just=20
going down.

However, given that's what the DSDT says, my guess is the box has actua=
lly=20
been designed to run at 110=B0C and simply shouldn't be shutting down a=
t 85=B0C=20
without warning - any ideas what may be causing this or how to fix it?

The DSDTs are available at
http://arklinux.org/~bero/dsdt-acer.dsl (Original DSDT)
http://arklinux.org/~bero/dsdt-bugfixes.dsl (Bugfixed version)
http://arklinux.org/~bero/dsdt-newfeatures.dsl (Version with CPU thrott=
ling=20
etc.)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
