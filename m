From: Thomas Renninger <trenn@suse.de>
Subject: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 02:44:20 +0100
Message-ID: <1203471860.3358.177.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57687 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881AbYBTBoX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 20:44:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

Hi,

please correct me if I am wrong or missed something:

osi=3Dlinux was an ability for vendors to provide Linux specific BIOS
updates/quirks.

_OSI("Linux") returned true until kernel version 2.6.23 (included?).
This has been replaced by rather huge black+white lists (at least they
most probably will grow huge) to get rid of it again.
Goal is to not return _OSI("Linux") as Intel identified it (after
inventing it? Doesn't really matter...) as "not the right thing to do"
as it does not consider fixes that might show up in specific kernel
versions in the future. This is the only reason I found, did I miss one
or the other?

Some questions and suggestions:

Is there already a replacement or will there pop up something soon,
which I may have missed?

This is an interface to the outside world (out of the kernel... in this
case not to userspace via /proc /sys ioctl, but to the BIOS).
Such interfaces should have a very long lifetime, once they are
implemented. In this case it should have an even much longer life time
than any /sys or whatever userspace interface. Telling vendors that thi=
s
will vanish and giving them time to remove it from their BIOSes or
better replace it with something else is the way to go here IMO.


The current policy is to just return zero on _OSI("Linux").
I don't get it why you do this.
You break machines on purpose.
Machines were vendors possibly have invested time to improve them for
Linux.
Why don't you just announce it, write it down in Documentation, also
write it to dmesg, instead of "pls send acpidump to acpi list",
something like: "osi=3Dlinux is deprecated and will get removed" (ok th=
ere
popped up a way too much of these, but maybe dmiblacklist the message,
don't do any functional change for now...).

Why shouldn't I remove the whole dmi black/white listing from our
OpenSUSE kernel and return true for _OSI("Linux"), this probably fixes =
a
lot machines and avoids bug reports (and annoyed users). I plan to do
this rather soon if I don't get some good arguments.

IMO this should also be done mainline. It is a pity that 2.6.24 now has
this. IMO this should even go back to a 2.6.24.X stable kernel.
Just let it in and announce to not use it and provide something else
(this has time then...).


=EF=BB=BF-------------------
Here a suggestion for an enhanced Linux Operation System Identification
interface for ACPI:

=46or general BIOS hot-fixes a check for osi=3Dlinux is sufficient for
vendors and allows them to provide a fix without risking breakage of
their Windows OS. This one should stay.


=EF=BB=BFThe problem is you do not know in what kernel version this mig=
ht get
fixed at the time the BIOS is published with the "short term
workaround". While this knob is essential for vendors for pre-loads, it
might break the machine if the user is trying to install a newer Linux
distribution with a newer Kernel where the problem got fixed. Then the
workaround might even slow down or break the system...
An example:
Lenovo wants to get rid of brightness switching via their old method
(int10?). But this needs in-kernel graphics driver support for Intel
graphics cards. Therefore ibm_acpi currently simulates this, the
specified ACPI brightness interface cannot be used. In which kernel
version in-kernel graphics drivers will be supported and Lenovo can
safely throw out int10 brightness switching from their BIOSes is not
known yet.

I think an appropriate interface could look like this:
Give vendors the possibility of an "infinite" tag, like osi=3Dlinux
Combine this somehow with a kernel version interface.
Vendors later should be able to simply switch from infinite to
kernel_version < xy by just modifying a simple line.



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
AML example (when it's not yet known in which kernel version the fix
will be):

/* This will get filled with kernel the version */
Name (KERN, Package (0x3)
{
  0, 0, 0
})

If (CondRefOf (_OSI, Local0))
{
    /* Are we running on linux? */
    If (_OSI ("Linux"))
    {
=EF=BB=BF=EF=BB=BF        Store (1, QURK)
    }
}


=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
AML example (when it *is* known in which kernel version the fix will be=
,
say 2.6.27):

=EF=BB=BF/* This will get filled with kernel the version */
Name (KERN, Package (0x3)
{
  0, 0, 0
})

If (CondRefOf (_OSI, Local0))
{
    /* Are we running on linux? */
    If (_OSI ("Linux"))
    {
        /* Does linux already support kernel version query? */
=EF=BB=BF        If (CondRefOf (_LKV, Local0))
        {
             /* LKV (Linux Kernel Version) returns a package with 3 int
                values */
             Store(_LKV, KERN)
             /* Only activate quirk if this is a 2.6=20
                kernel with version less than 27 */
             If And(And(And((LEqual(Index(1, KERN), 2)),
                    =EF=BB=BF(LEqual(Index(2, KERN), 6)),
=EF=BB=BF                    =EF=BB=BF(LLess(Index(3, KERN), 27))))
             {
=EF=BB=BF=EF=BB=BF=EF=BB=BF                  Store (1, QURK)
        }
    }
}

So the new thing here is:
Method(_LKV, 0, ..)
that needs to be implemented by the kernel and returns the kernel
version in a Package with three elements.

Does this make sense?
Is it too complicated?
Better ideas?


    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
