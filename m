From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Computer Resets on Resume From S3
Date: 27 Nov 2003 03:46:48 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069904808.28929.7.camel@darkstar.portugal>
References: <200311201522.15255.jak97@doc.ic.ac.uk>
	<200311212333.10341.jak97@doc.ic.ac.uk>
	<20031122131957.GA1162@atrey.karlin.mff.cuni.cz>
	<200311221716.10690.jak97@doc.ic.ac.uk>  <20031122172352.GA265@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031122172352.GA265-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2003-11-22 at 17:23, Pavel Machek wrote:
> Hi!
>=20
> > > I've seen something similar before -- it usually meant we left
> > > hardware in "weird" state and it crashed in BIOS.
> > >
> > > Can you add "noapic" first, then turn off all unneccesary drivers? No
> > > SMP, please.
> > > 								Pavel
> >=20
> > Hi,
> >=20
> > I boot with noapic and also init=3D/bin/bash so no modules loaded. Same=
=20
> > behaviour.=20
> >=20
> > My kernel config is at: http://www.doc.ic.ac.uk/~jak97/dsdt/config.gz
> > And the dmesg is: http://www.doc.ic.ac.uk/~jak97/dsdt/dmesg
> > Other info at http://www.doc.ic.ac.uk/~jak97/dsdt
> >=20
> > I am running with standard DSDT with relaxed AML checking, however I ha=
ve also=20
> > tried a fixed DSDT previously and that didn't seem to make any differen=
ce at=20
> > all.
> >=20
> > Are there any other useful places I might put an infinite loop?
>=20
> I do not have better ideas.
>=20
> > What about something to check before the machine goes into S3?
> >=20
> > I am compiling for Athlon architecture, do you think I should try
> > i386?
>=20
> That should not make a difference.
>=20
> > Could it be a gcc problem? gcc is version 3.3.2.
>=20
> I do not think gcc could cause this.

Asking why fedora core 1, why compile kernel with gcc 3.2.3 and use
gcc3.3.2 for compile everything else.
reply:
if you try (compiling kernel with gcc3.3.x), then it just magically
works for you, and you go on happy, possibly with silent data
corruption, or possibly not.  Roll a 20 sided dice to find out.

--=20
S=E9rgioMB




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
