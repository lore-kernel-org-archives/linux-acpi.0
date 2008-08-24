From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Acer Aspire 7720 shutdown problems and DSDT fixes
Date: Sun, 24 Aug 2008 18:48:57 +0100
Message-ID: <48B19F09.3070804@tuffmail.co.uk>
References: <200808241822.18839.bero@arklinux.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:23563 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYHXRtC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Aug 2008 13:49:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so578881nfc.21
        for <linux-acpi@vger.kernel.org>; Sun, 24 Aug 2008 10:49:00 -0700 (PDT)
In-Reply-To: <200808241822.18839.bero@arklinux.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bernhard_Rosenkr=E4nzer?= <bero@arklinux.ch>
Cc: linux-acpi@vger.kernel.org

Bernhard Rosenkr=E4nzer wrote:
> Hi,
> I recently got an Acer Aspire 7720 using BIOS 1.43. Obviously, the fi=
rst thing=20
> to do was install Linux (currently running 2.6.27-rc4).
>
> Everything is working, but under heavy load, the machine tends to shu=
t down=20
> without prior warning. Unlike the similar problem described at=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D9167, /proc/acpi/thermal=
_zone/TZ01/temperature=20
> does show the correct temperature all the time, and the fan does turn=
 on.
>
> I've looked at the DSDT and found a huge number of obvious bugs (_OSC=
 taking=20
> the wrong number of arguments and actually having an off-by-one bug w=
hen=20
> looking at the arguments -- looks like someone didn't know ACPI argum=
ents=20
> start at Arg0 and then increased the argument count by 1 so he could =
get the=20
> 4th argument in Arg4; Funny comparisons like
> If (LOr (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D7)))
> (not that that could ever not be true...); doesn't even compile.....)=
, but=20
> fixing them doesn't help.
>
> I've tried all sorts of things to get it to behave, including patchin=
g the=20
> DSDT to actually know about the fact that TZ01 is connected to the CP=
Us and=20
> throttling the CPUs may help:
>
>             Method (_PSV, 0, Serialized)
>             {
>                 Return (3552) // 3552 =3D (273.2+82.0)*10
>             }
>
>             Method (_PSL, Package() {
>                 \_PR.CPU0,
>                 \_PR.CPU1
>             })
>
>             Name (_TC1, 3)
>             Name (_TC2, 4)
>             Name (_TSP, 20)
>             Name (_TZP, Zero)
>
> (This part works nicely by the way)
>
> But at some point, it still shuts down.
>
> Looking at sensors output, the box seems to shut down when it hits 85=
=2E0=B0C,=20
> which is also what the coretemp module thinks is right (tjmax value) =
-- but=20
> the DSDT sets the trip point at 110=B0C:
>
>             Method (_CRT, 0, Serialized)
>             {
>                 Return (Add (0x0AAC, Multiply (0x6E, 0x0A)))
>             }
>
> Guess this explains why I'm getting a sudden shutdown instead of a cl=
ean=20
> shutdown through acpid - adjusting _CRT to return 84=B0C doesn't fix =
the=20
> problem, but does let acpid shut down the system gracefully instead o=
f just=20
> going down.
>
> However, given that's what the DSDT says, my guess is the box has act=
ually=20
> been designed to run at 110=B0C and simply shouldn't be shutting down=
 at 85=B0C=20
> without warning - any ideas what may be causing this or how to fix it=
?
>  =20
In theory they sell a version with Linux preinstalled, and are
interested in engaging with Linux generally.  Maybe you can find the
kernel version, patches & Kconfig and see if their kernel is any better=
=2E

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
