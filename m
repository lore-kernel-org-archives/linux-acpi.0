From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Kernel Version specific vendor override possibilities needed
 -	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 11:31:16 +0100
Message-ID: <47BC0174.5050203@dbservice.com>
References: <1203471860.3358.177.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:35872 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752610AbYBTKb1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 05:31:27 -0500
In-Reply-To: <1203471860.3358.177.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

Thomas Renninger wrote:
> Hi,
>=20
> please correct me if I am wrong or missed something:
>=20
> osi=3Dlinux was an ability for vendors to provide Linux specific BIOS
> updates/quirks.
>=20
> _OSI("Linux") returned true until kernel version 2.6.23 (included?).
> This has been replaced by rather huge black+white lists (at least the=
y
> most probably will grow huge) to get rid of it again.
> Goal is to not return _OSI("Linux") as Intel identified it (after
> inventing it? Doesn't really matter...) as "not the right thing to do=
"
> as it does not consider fixes that might show up in specific kernel
> versions in the future. This is the only reason I found, did I miss o=
ne
> or the other?

"Linux" is way too generic. The kernels is such fast moving target that=
=20
changes with every other version. The idea is to replace _OSI("Linux")=20
with _OSI("Needs video POST after resume") etc. To allow the BIOS to=20
figure out what _exactly_ it needs to do, rather then guessing based on=
=20
the kernels version etc.

A lot has been discussed in linux-acpi, though mostly hidden in related=
=20
threads. Ask Henrique, he's been trying to come up with a proper _OSI()=
=20
interface. See for example this thread:
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg12262.html

The idea to remove _OSI("Linux") it to get the hardware vendors to stop=
=20
using it _now_, we don't want them to use it any longer. It will take=20
some time to come up with a proper interface, but at least we'll have=20
less legacy to deal with.

> Some questions and suggestions:
>=20
> Is there already a replacement or will there pop up something soon,
> which I may have missed?
 >
>=20
> This is an interface to the outside world (out of the kernel... in th=
is
> case not to userspace via /proc /sys ioctl, but to the BIOS).
> Such interfaces should have a very long lifetime, once they are
> implemented. In this case it should have an even much longer life tim=
e
> than any /sys or whatever userspace interface. Telling vendors that t=
his
> will vanish and giving them time to remove it from their BIOSes or
> better replace it with something else is the way to go here IMO.
>=20
>=20
> The current policy is to just return zero on _OSI("Linux").
> I don't get it why you do this.
> You break machines on purpose.
> Machines were vendors possibly have invested time to improve them for
> Linux.
> Why don't you just announce it, write it down in Documentation, also
> write it to dmesg, instead of "pls send acpidump to acpi list",
> something like: "osi=3Dlinux is deprecated and will get removed" (ok =
there
> popped up a way too much of these, but maybe dmiblacklist the message=
,
> don't do any functional change for now...).

Maybe that just didn't get outside of the linux-acpi mailinglist, but=20
that that _OSI("Linux") is deprecated has been known for some time now.=
=20
But you are right, it was never publicly announced.

=46irst users were asked to try acpi_osi=3D!Linux (sometime in the .23/=
=2E24=20
timeframe?)and see if it works better. Now !Linux is default, and they=20
are asked to try acpi_osi=3DLinux so that we can fill the blacklist.

> Why shouldn't I remove the whole dmi black/white listing from our
> OpenSUSE kernel and return true for _OSI("Linux"), this probably fixe=
s a
> lot machines and avoids bug reports (and annoyed users). I plan to do
> this rather soon if I don't get some good arguments.
>=20
> IMO this should also be done mainline. It is a pity that 2.6.24 now h=
as
> this. IMO this should even go back to a 2.6.24.X stable kernel.
> Just let it in and announce to not use it and provide something else
> (this has time then...).
>=20
>=20
> =EF=BB=BF-------------------
> Here a suggestion for an enhanced Linux Operation System Identificati=
on
> interface for ACPI:
>=20
> For general BIOS hot-fixes a check for osi=3Dlinux is sufficient for
> vendors and allows them to provide a fix without risking breakage of
> their Windows OS. This one should stay.

No, it's not sufficient, it's useless. "Linux" - what should that stand=
=20
for? How should the BIOS vendors interpret it? It's totally ambiguous.=20
It was removed, and should stay removed.

BIOS can do _OSI("Windows 2006") because "Windows 2006" defines a=20
non-moving target. MS will not change how Vista behaves without changin=
g=20
the string (they sometimes update the string in service packs).

> =EF=BB=BFThe problem is you do not know in what kernel version this m=
ight get
> fixed at the time the BIOS is published with the "short term
> workaround". While this knob is essential for vendors for pre-loads, =
it
> might break the machine if the user is trying to install a newer Linu=
x
> distribution with a newer Kernel where the problem got fixed. Then th=
e
> workaround might even slow down or break the system...
> An example:
> Lenovo wants to get rid of brightness switching via their old method
> (int10?). But this needs in-kernel graphics driver support for Intel
> graphics cards. Therefore ibm_acpi currently simulates this, the
> specified ACPI brightness interface cannot be used. In which kernel
> version in-kernel graphics drivers will be supported and Lenovo can
> safely throw out int10 brightness switching from their BIOSes is not
> known yet.
>=20
> I think an appropriate interface could look like this:
> Give vendors the possibility of an "infinite" tag, like osi=3Dlinux
> Combine this somehow with a kernel version interface.
> Vendors later should be able to simply switch from infinite to
> kernel_version < xy by just modifying a simple line.
>=20
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> AML example (when it's not yet known in which kernel version the fix
> will be):
>=20
> /* This will get filled with kernel the version */
> Name (KERN, Package (0x3)
> {
>   0, 0, 0
> })
>=20
> If (CondRefOf (_OSI, Local0))
> {
>     /* Are we running on linux? */
>     If (_OSI ("Linux"))
>     {
> =EF=BB=BF=EF=BB=BF        Store (1, QURK)
>     }
> }
>=20
>=20
> =EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> AML example (when it *is* known in which kernel version the fix will =
be,
> say 2.6.27):
>=20
> =EF=BB=BF/* This will get filled with kernel the version */
> Name (KERN, Package (0x3)
> {
>   0, 0, 0
> })
>=20
> If (CondRefOf (_OSI, Local0))
> {
>     /* Are we running on linux? */
>     If (_OSI ("Linux"))
>     {
>         /* Does linux already support kernel version query? */
> =EF=BB=BF        If (CondRefOf (_LKV, Local0))
>         {
>              /* LKV (Linux Kernel Version) returns a package with 3 i=
nt
>                 values */
>              Store(_LKV, KERN)
>              /* Only activate quirk if this is a 2.6=20
>                 kernel with version less than 27 */
>              If And(And(And((LEqual(Index(1, KERN), 2)),
>                     =EF=BB=BF(LEqual(Index(2, KERN), 6)),
> =EF=BB=BF                    =EF=BB=BF(LLess(Index(3, KERN), 27))))
>              {
> =EF=BB=BF=EF=BB=BF=EF=BB=BF                  Store (1, QURK)
>         }
>     }
> }
>=20
> So the new thing here is:
> Method(_LKV, 0, ..)
> that needs to be implemented by the kernel and returns the kernel
> version in a Package with three elements.
>=20
> Does this make sense?
> Is it too complicated?
> Better ideas?

BIOS should not check for a kernel version, it should check for a kerne=
l=20
capability. It may be happen that you (suse) or redhat or whoever add=20
patches to the kernel, and then behave differently than vanilla but yet=
=20
  have the same kernel version.

I asked that in another thread, if it was possible to standardize the=20
_OSI() strings, to that other kernels (BSD) can use it, too. Or even=20
have it in the ACPI standard. No answer...

>=20
>=20
>     Thomas
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
