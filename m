From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Fri, 13 Dec 2002 08:22:43 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B9AB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Herbert Nachtnebel' <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I must agree that this is a really bad idea.  Once we start allowing =
these
kinds of errors to slip by, there is potentially no end to it.  It's a =
very
slippery slope that will potentially plunge everyone into the same kind =
of
BIOS abyss that ACPI was intended to solve in the first place.

Worse, there are situations where the AML interpreter cannot "guess" =
what
the ASL/AML (BIOS) coder actually intended, i.e., there are multiple
solutions to the problem.

What is really being proposed here is for Linux ACPI to be bug-for-bug
compatible with Microsoft.  This is impossible to do deterministically
because the MS interpreter is closed source.  The only standard that we =
have
that we can code to is the ACPI specification, and this has to be the =
last
word on the matter.

We have a good opportunity here to help drive the industry to proper =
BIOS
and ACPI implementations by following the specification and developing =
tools
(such as the iASL compiler) that help enforce conformance to the ACPI
specification -- and also giving feedback to the BIOS vendors about =
their
broken ASL code.

Bob Moore


-----Original Message-----
From: Herbert Nachtnebel [mailto:Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org]=20
Sent: Friday, December 13, 2002 1:30 AM
To: NoZizzing OrDripping; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: AW: [ACPI] [PATCH] Add CONFIG_ACPI_RELAXED_AML option

That's a really bad idea! This size checks are identented to assure, =
that
important data which accidently follows the buffer can't be overridden =
by
brain dead bios coders. Now you allow buffer overflow injection into =
linux
from the bios!
These are serious bios faults, in my DSDT I had to extend a buffer by =
128
bytes to avoid a buffer overflow!=20
The situation doesn't get better if we ignore such errors. We have to =
urge
the manufacturers to correct the DSDT's. And the best way to do this is =
to
recognise the faults and blame them.

Herbert.


> -----Urspr=FCngliche Nachricht-----
> Von: NoZizzing OrDripping [mailto:nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org]
> Gesendet: Freitag, 13. Dezember 2002 05:48
> An: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Betreff: [ACPI] [PATCH] Add CONFIG_ACPI_RELAXED_AML option
>=20
>=20
> The patch adds a new configuration option,
> CONFIG_ACPI_RELAXED_AML.  When turned on,
> the ACPI code will become forgiving of minor
> errors in the AML code.
>=20
> For this first cut, the patch and option will ignore
> region size errors.  An off-by-one error is often
> found in the AML shipped with Toshiba laptops,
> even new models. This minor error prevents the
> AC module from operating without this patch.
>=20
> I urge the adoption of this patch (or something
> similar) into the ACPI code.  This will make it
> much easier to install and proliferate Linux on
> a large category of laptops.
>=20
> Rick Richardson
> rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org
> [Sorry, have to use my Yahoo account to post to this list)
>=20
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
>=20


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility=20
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
