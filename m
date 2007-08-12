From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: v2.6.23-rc2 locks up during boot (without acpi=off)
Date: Sun, 12 Aug 2007 01:28:26 -0700
Message-ID: <20070812012826.cfc9f5bb.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0708012131480.1479@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55929 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756850AbXHLI3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Aug 2007 04:29:17 -0400
In-Reply-To: <Pine.LNX.4.64.0708012131480.1479@kivilampi-30.cs.helsinki.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?B?IklscG8gSuRydmluZW4i?= <ilpo.jarvinen@helsinki.fi>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, 11 Aug 2007 15:39:30 +0300 (EEST) "Ilpo J=E4rvinen" <ilpo.jarvi=
nen@helsinki.fi> wrote:

> I noticed that v2.6.23-rc1 locks up during boot, same thing happens n=
ow=20
> with the latest linus' tree (+net-2.6.24 and tcp-2.6 tree stuff on to=
p=20
> of it; in -rc1 test they weren't though). The exact location of hang
> varies a bit though. No OOPS, does not respond to sysrq or anything e=
lse=20
> besides reset. Last known bootable one is something like 2.6.22-rc4=20
> (I usually run 2.6.21.5 on this machine, haven't tried any 2.6.22 on
> this after those rcs). Problem seems to start after this line:
>=20
> Time: acpi_pm clocksource has been installed.
>=20
> ...the power led starts blinking (not periodic cycle but more or less=
=20
> varying on-off cycle, never seen that led blink before at all, didn't=
 know=20
> that one can make it blink :-)) and the machine gets consideably slow=
er=20
> too. Never have it been able to complete booting all they way up to l=
ogin=20
> prompt before lock up.
>=20
> Tried with acpi=3Doff, boots just fine (dmesg comes from it). I can t=
ake=20

A hang a short-but-variable period after a clocksource was installed: p=
robably
means that the kernel wedged on the first clock interrupt.

I'd expect 2.6.22 to work OK.  It's a little unexpected that the bug wa=
s added
after 2.6.22: a number of these reports have narrowed down to the patch=
set which
added dynticks and clockevents, but that was already in 2.6.22.

It'd be great if you could run a git bisection search please.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
