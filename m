From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Mon, 5 Jul 2004 20:55:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040705185544.GA7033@rap.rap.dk>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <opsadhbojo4evsfm@smtp.pacific.net.th> <20040629221111.GB25464@elf.ucw.cz> <opsaeu9tyb4evsfm@smtp.pacific.net.th> <20040630173754.GA29587@rap.rap.dk> <opsafmf8px4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <opsafmf8px4evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 01, 2004 at 08:03:34AM +0800, Michael Frank wrote:
> On Wed, 30 Jun 2004 19:37:54 +0200, Keld J=F8rn Simonsen <keld-6PR53cSIHaE@public.gmane.org=
>=20
> wrote:
>=20
> >Well, I think what I want is S2, from the same document:
> >
> >     S2
> >
> >     While defined in the spec, this state is not currently in use. It
> >     resembles S3 with the qualification that some devices are permitt=
ed to
> >     remain on.
>=20
> "some devices" could include the CPU - fair enough!

Well, I thought all these S0/S1/S2/S3/S4/S5 states were about halting
the CPU, in different ways. So the question is how the CPU is stopped.
Sometimes it is in standby, somtimes it is with all cpu registers saved
to memory, sometimes it is with everything saved to disk.

S2 would then be: Save CPU registers to memory, power down CPU
completely, keep RAM powered on, and then keep some other devices on,
according to some user defined settings.

My understanding is that S2 is not fully implemented in ACPI, that is
why S2 is not reported as working for my machine.

> >>So again, which (mainboard/notebook) HW does depower the CPU and keep=
s the
> >>rest running ?
> >
> >I thought this was something that most mainboards would support, given
> >that we make the appropiate SW in the kernel.
>=20
> If you want to depower the CPU, you have to depower its bridge
> connections as well,  _No_  Mainboard especially the chipsets
> can do that. . ... also need a seperate set of main regulators for the
> CPU.
>=20
> The software side would be mostly CPU part of S3.

Yes, the software would mostly be S3.

I don't understand why it is not possible to just have  the screen powerd
on. What I think is needed is that the memory for the screen be on, the
screen controller, maybe some PCI bus, and then the screen itself.
But I am not a hardware expert.

> >
> >>As to ACPI there should be a S2.5 state, or a S3 extension to power d=
own
> >>the CPU and run the rest...
> >
> >I thought S2 was actually powering down the cpu, saving all registers
> >and things in memory, like S3, and then leaving some devices on. As I =
have=20
> >read it,
> >this is clean S2, and not a 2.5 level. But I am not an ACPI expert.
>=20
> It could be, provided someone writes a spec on how to power the CPU dow=
n
> while keeping the rest running and the manufacturers implement it.
>=20
> ACPI  for Linux implements the spec and supports features supported
> by hardware. I suggest you discuss in a PC hardware forum.

Any suggestions for a good hardware ACPI discussion list?

Best regards
keld


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
