From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Gericom Hummer 2430 problems
Date: Mon, 12 Jan 2004 14:57:49 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CB3@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> - I can't change the CPU throttling settings. When I write to=20
> /proc/acpi/processor/CPU1/throttling, nothing happens and the=20
> contents of=20
> this file remain unchanged. Writing to=20
> /proc/acpi/processor/CPU1/limit=20
> doesn't work either. There isn't any error message displayed=20
> in the dmesg=20
> output nor in the console.
> - Sometimes my machine locks up for less than a second and=20
> when this happens I=20
> have the following message in the dmesg output :=20
> atkbd.c: Unknown key pressed (translated set 2, code 0x0,=20
> data 0x0, on=20
> isa0060/serio0).
> I'm unsure this problem is ACPI related, but it often happens=20
> when the fan=20
> starts up.

Maybe this is ec event handling relative bug.  Please file it
on bugzilla.=20

> - The S-states just don't work. Trying to enter one either=20
> does nothing or=20
> crashes the computer. The computer shutdowns properly, though.
> I'm using Linux 2.6.0 with the ACPI patch 20031203.
> You can find useful information about my laptop (contents of=20
> the DSDT, full=20
> output of dmesg and so on) at http://irchat.free.fr/acpi/.
> Thank you,
> Seb
>=20

What kind of crash? Maybe this could the most easy one. :)


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
