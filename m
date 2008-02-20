From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel Version specific vendor override possibilities needed
	-	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 16:31:59 +0100
Message-ID: <1203521519.6019.254.camel@queen.suse.de>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <47BC0174.5050203@dbservice.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:54896 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764572AbYBTPcB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 10:32:01 -0500
In-Reply-To: <47BC0174.5050203@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, 2008-02-20 at 11:31 +0100, Tomas Carnecky wrote:
> Thomas Renninger wrote:
> > Hi,
> >=20
> > please correct me if I am wrong or missed something:
> >=20
> > osi=3Dlinux was an ability for vendors to provide Linux specific BI=
OS
> > updates/quirks.
> >=20
> > _OSI("Linux") returned true until kernel version 2.6.23 (included?)=
=2E
> > This has been replaced by rather huge black+white lists (at least t=
hey
> > most probably will grow huge) to get rid of it again.
> > Goal is to not return _OSI("Linux") as Intel identified it (after
> > inventing it? Doesn't really matter...) as "not the right thing to =
do"
> > as it does not consider fixes that might show up in specific kernel
> > versions in the future. This is the only reason I found, did I miss=
 one
> > or the other?
>=20
> "Linux" is way too generic. The kernels is such fast moving target th=
at=20
> changes with every other version. The idea is to replace _OSI("Linux"=
)=20
> with _OSI("Needs video POST after resume") etc. To allow the BIOS to=20
> figure out what _exactly_ it needs to do, rather then guessing based =
on=20
> the kernels version etc.
Ok, I see the point and I agree that kernel versions only is a bit
problematic. I still like it, because it seem to me the only way that i=
s
a bit generic.

So the suggestion is to introduce very specific strings (hopefully not
much) for specific milestones/patches similar to "Windows 2006 SP1" we
might have a "in-kernel graphics", but this hopefully will be the only
one... The string(s) are listed on acpi.sourceforge.com? Hmm, not sure
whether this is such a perfect idea or could work at all, maybe for ver=
y
extrem/huge changes.

But that is not enough. There is nothing wrong with giving the vendors
the possibility to check whether they are running on Linux.
Document the problem of future kernel versions for vendors.
I expect most of the if(linux) AML fixups from vendors make very much
sense to keep them forever.
=46or all the stuff like: Windows likes to have it this way, it violate=
s
all kinds of specifications for it, so for Linux we do it right and
provide a proper interface.

There are dozens of more arguments..

> A lot has been discussed in linux-acpi, though mostly hidden in relat=
ed=20
> threads. Ask Henrique, he's been trying to come up with a proper _OSI=
()=20
> interface. See for example this thread:
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg12262.html
>=20
> The idea to remove _OSI("Linux") it to get the hardware vendors to st=
op=20
> using it _now_, we don't want them to use it any longer. It will take=
=20
> some time to come up with a proper interface, but at least we'll have=
=20
> less legacy to deal with.
>=20
> > Some questions and suggestions:
> >=20
> > Is there already a replacement or will there pop up something soon,
> > which I may have missed?
>  >
> >=20
> > This is an interface to the outside world (out of the kernel... in =
this
> > case not to userspace via /proc /sys ioctl, but to the BIOS).
> > Such interfaces should have a very long lifetime, once they are
> > implemented. In this case it should have an even much longer life t=
ime
> > than any /sys or whatever userspace interface. Telling vendors that=
 this
> > will vanish and giving them time to remove it from their BIOSes or
> > better replace it with something else is the way to go here IMO.
> >=20
> >=20
> > The current policy is to just return zero on _OSI("Linux").
> > I don't get it why you do this.
> > You break machines on purpose.
> > Machines were vendors possibly have invested time to improve them f=
or
> > Linux.
> > Why don't you just announce it, write it down in Documentation, als=
o
> > write it to dmesg, instead of "pls send acpidump to acpi list",
> > something like: "osi=3Dlinux is deprecated and will get removed" (o=
k there
> > popped up a way too much of these, but maybe dmiblacklist the messa=
ge,
> > don't do any functional change for now...).
>=20
> Maybe that just didn't get outside of the linux-acpi mailinglist, but=
=20
> that that _OSI("Linux") is deprecated has been known for some time no=
w.=20
> But you are right, it was never publicly announced.
>=20
> First users were asked to try acpi_osi=3D!Linux (sometime in the .23/=
=2E24=20
> timeframe?)and see if it works better. Now !Linux is default, and the=
y=20
> are asked to try acpi_osi=3DLinux so that we can fill the blacklist.

It is not working like that!
You cannot provide an important interface.
Then realize that it is not exactly what it was intended for and just
rip it out.
While modifying sysfs and procfs without announcing must not happen, it
is by far not that bad.
Just keep it, tell the vendors that they should not use it, put in ugly
messages if they do (if you like black/white list the message...). If
this really should vanish, what is IMO a really bad idea.
But do not just remove it!

> > Why shouldn't I remove the whole dmi black/white listing from our
> > OpenSUSE kernel and return true for _OSI("Linux"), this probably fi=
xes a
> > lot machines and avoids bug reports (and annoyed users). I plan to =
do
> > this rather soon if I don't get some good arguments.
> >=20
> > IMO this should also be done mainline. It is a pity that 2.6.24 now=
 has
> > this. IMO this should even go back to a 2.6.24.X stable kernel.
> > Just let it in and announce to not use it and provide something els=
e
> > (this has time then...).
> >=20
> >=20
> > =EF=BB=BF-------------------
> > Here a suggestion for an enhanced Linux Operation System Identifica=
tion
> > interface for ACPI:
> >=20
> > For general BIOS hot-fixes a check for osi=3Dlinux is sufficient fo=
r
> > vendors and allows them to provide a fix without risking breakage o=
f
> > their Windows OS. This one should stay.
>=20
> No, it's not sufficient, it's useless. "Linux" - what should that sta=
nd=20
> for? How should the BIOS vendors interpret it?
That the Operating System is a Linux kernel?
> It's totally ambiguous.
I do not understand what is so ambiguous about that.
All more specific solutions should get embedded into this anyway, e.g.:
if (linux) {
   if(in-kernel_graphics)
      ...
   if(latest-hack)
      ...
}
> It was removed, and should stay removed.
I don't know whether it stays removed, I hope not.

I hope Len is realizing that all the work done the last weeks wasn't
really worth it and that there might come a lot more work. If you
already start black/white listing machines after some weeks, then there
are more out there. Currently unnecessarily broken. BTW, what should be
the final solution? You tell the vendor that he should remove the linux
quirk from their BIOSes for the future, best with the next BIOS update
and then you are going to fix it? (not sure whether fix it is the right
word, better hack/work around it) to make it work somehow?

Better stop wasting time on fixing things that have already been fixed
for Linux.
Also a lot users had to debug some BIOS issues to the root because the
policy was to not provide workaround boot parameters, sysfs interfaces
(e.g. thermal trip points) or other workarounds. There were discussions=
,
some disagreements, but in the end it made some sense.
I won't let OpenSUSE users run into such problems because of this one,
it just makes no sense.

There still were not much more arguments than "It's not the way to go",
there is no suggestion for an alternative also...

> BIOS can do _OSI("Windows 2006") because "Windows 2006" defines a=20
> non-moving target. MS will not change how Vista behaves without chang=
ing=20
> the string (they sometimes update the string in service packs).
>=20
> > =EF=BB=BFThe problem is you do not know in what kernel version this=
 might get
> > fixed at the time the BIOS is published with the "short term
> > workaround". While this knob is essential for vendors for pre-loads=
, it
> > might break the machine if the user is trying to install a newer Li=
nux
> > distribution with a newer Kernel where the problem got fixed. Then =
the
> > workaround might even slow down or break the system...
> > An example:
> > Lenovo wants to get rid of brightness switching via their old metho=
d
> > (int10?). But this needs in-kernel graphics driver support for Inte=
l
> > graphics cards. Therefore ibm_acpi currently simulates this, the
> > specified ACPI brightness interface cannot be used. In which kernel
> > version in-kernel graphics drivers will be supported and Lenovo can
> > safely throw out int10 brightness switching from their BIOSes is no=
t
> > known yet.
> >=20
> > I think an appropriate interface could look like this:
> > Give vendors the possibility of an "infinite" tag, like osi=3Dlinux
> > Combine this somehow with a kernel version interface.
> > Vendors later should be able to simply switch from infinite to
> > kernel_version < xy by just modifying a simple line.
> >=20
> >=20
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > AML example (when it's not yet known in which kernel version the fi=
x
> > will be):
> >=20
> > /* This will get filled with kernel the version */
> > Name (KERN, Package (0x3)
> > {
> >   0, 0, 0
> > })
> >=20
> > If (CondRefOf (_OSI, Local0))
> > {
> >     /* Are we running on linux? */
> >     If (_OSI ("Linux"))
> >     {
> > =EF=BB=BF=EF=BB=BF        Store (1, QURK)
> >     }
> > }
> >=20
> >=20
> > =EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > AML example (when it *is* known in which kernel version the fix wil=
l be,
> > say 2.6.27):
> >=20
> > =EF=BB=BF/* This will get filled with kernel the version */
> > Name (KERN, Package (0x3)
> > {
> >   0, 0, 0
> > })
> >=20
> > If (CondRefOf (_OSI, Local0))
> > {
> >     /* Are we running on linux? */
> >     If (_OSI ("Linux"))
> >     {
> >         /* Does linux already support kernel version query? */
> > =EF=BB=BF        If (CondRefOf (_LKV, Local0))
> >         {
> >              /* LKV (Linux Kernel Version) returns a package with 3=
 int
> >                 values */
> >              Store(_LKV, KERN)
> >              /* Only activate quirk if this is a 2.6=20
> >                 kernel with version less than 27 */
> >              If And(And(And((LEqual(Index(1, KERN), 2)),
> >                     =EF=BB=BF(LEqual(Index(2, KERN), 6)),
> > =EF=BB=BF                    =EF=BB=BF(LLess(Index(3, KERN), 27))))
> >              {
> > =EF=BB=BF=EF=BB=BF=EF=BB=BF                  Store (1, QURK)
> >         }
> >     }
> > }
> >=20
> > So the new thing here is:
> > Method(_LKV, 0, ..)
> > that needs to be implemented by the kernel and returns the kernel
> > version in a Package with three elements.
> >=20
> > Does this make sense?
> > Is it too complicated?
> > Better ideas?
>=20
> BIOS should not check for a kernel version, it should check for a ker=
nel=20
> capability. It may be happen that you (suse) or redhat or whoever add=
=20
> patches to the kernel, and then behave differently than vanilla but y=
et=20
>   have the same kernel version.
Yes this is indeed a problem for specific issues.
It would be sufficient for e.g. ACPI interpreter problems for which you
know that they are so intrusive, that they will never be backported int=
o
a half-way stable kernel.
>=20
> I asked that in another thread, if it was possible to standardize the=
=20
> _OSI() strings, to that other kernels (BSD) can use it, too. Or even=20
> have it in the ACPI standard. No answer...
What are your ideas?
It's not included in the link you added.

Thanks,

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
