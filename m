From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Tue, 26 Feb 2008 17:26:14 +0100
Message-ID: <1204043174.3964.57.camel@hammer28.suse.de>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <20080220173248.GA22709@srcf.ucam.org>
	 <1203689263.4995.81.camel@queen.suse.de>
	 <20080222181000.GB32623@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:45806 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbYBZQ0R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 11:26:17 -0500
In-Reply-To: <20080222181000.GB32623@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Fri, 2008-02-22 at 18:10 +0000, Matthew Garrett wrote:=20
> On Fri, Feb 22, 2008 at 03:07:42PM +0100, Thomas Renninger wrote:
>=20
> > So to what Windows version are we compatible?
>=20
> Microsoft has been very good at keeping backwards compatibility for t=
his=20
> functionality, so the obvious aim is to be compatible with the curren=
t=20
> version of Windows and all previous versions. If necessary, we can=20
> switch to compatibility modes depending on whether the firmware reque=
sts=20
> XP or Vista or whatever.
>=20
> > Do you want to remove lower versions at some time?
>=20
> No.
>=20
> > What about Longhorn or whatever coming up?
>=20
> We aim to be compatible with it.
You want to be compatible with all Windowses that exist and ever will
get published?
Impossible!

> > Then these strings might branch into a server and a workstation Win=
dows,
> > to which one do you want to stay compatible, both again?
>=20
> Whichever one the firmware asks for.
>=20
> > All this does not make sense and it does not work.
>=20
> It makes perfect sense and I've no reason to think it doesn't work.
>=20
> > All this is an advantage for vendors who do not care about Linux, b=
ut it
> > makes life really hard for vendors who want to support it.
>=20
> No! We have the choice between providing a benefit to a subset of=20
> vendors at the cost of never being able to fix bugs, or just making=20
> everything work. Given the choice between making everything work and=20
> making Lenovo work, I'll go for making everything work.
But you will fail for sure.
It is so realistic like: "=EF=BB=BFWe aim to be compatible with all Win=
dows
versions that ever existed."
Supporting the one and the other version can and in reality is mutually
exclusive.

> > The _OSI interface is not thought for Linux kernel developers to st=
ay
> > compatible with Windows.
> > It got invented for vendors being able to provide hot-fixes for the=
ir
> > BIOS for Operating Systems they are willing to support.
>=20
> No! _OSI is (according to the spec) there to enable vendors to suppor=
t=20
> *features* provided by specific OSs, not to work around bugs in that =
OS.=20
> What does an _OSI of Linux mean? We don't have a well-defined feature=
=20
> set. We don't have a stable set of bugs. Our development model is=20
> inherently different from Windows, and providing this information jus=
t=20
> makes no sense.
Invented was wrong. After spec it indeed has another meaning, but you
unfortunately are right with: Microsoft defines the standards by their
implementations. In this case it probably were the vendors who need thi=
s
hook asking Microsoft to provide it (and we remove it for Linux...).

It is used by vendors being able to provide hot-fixes for their
BIOS for Operating Systems they are willing to support.
Please go through through some OSI declarations. I've done it (see at
the end), I just went through some for 20 minutes to get a bit of an
impression what kind of features and what kind of hacks have been added=
=2E
And I could only identify hacks (needs more evaluating, as soon as more
complicated functions are invoked it's getting difficult).
So you do not try to be feature, but bug compatible with all kind of
Windows versions.

I agree it made sense some years ago, when it was not clear for what
_OSI is/will get used by vendors and Microsoft, but now it leads to a
totally undefined behavior and confusion.

While _OSI("xy") can return true for several strings, current BIOSes
rely on the fact that only one Windows OS string returns true, e.g.
"Windows 2001 SP1". For most it fortunately does not matter as they all
override one variable to store the information. But not all! E.g. all
ThinkPads seem to store this in different values:
=EF=BB=BF\WNTF (Windows NT), \WXPF (Windows XP), \WSPV (Window XP Servi=
ce Pack
version), \WVIS (Vista), \WMEF (Millenium Edition), \W98F (98).

And they add different BIOS workarounds/hacks. The BIOS developers rely
on that only either of these are set (or WXPF + Service Pack variable).
So returning true for all kind of Windows Versions is a really bad idea
and we should move away from this asap.

Also removing old ones and switch to a new Version if a new one is used
(e.g. remove "Windows 2006" and switch to "Windows Longhorn" as soon as
it is available) does not make sense.

The problem is that _OSI is not used for features, but for BIOS fixes.
=EF=BB=BFI expect it works like that:
It seems all kind of ASL templates are copied together to a BIOS, and
made work as they should.
Then OSI hooks are added for all Windows OS it should support.
Later at a specific time of their product (when QA is heavily testing
each OS), they are able to only add hot-fixes for a specific OS (if onl=
y
a specific OS is affected) without the need of revalidating whether
other OSes are still running fine.

Len, can you put the acpidumps you received on a public ftp server, pls=
=2E
This should make it easy for others to reproduce or invalidate my
findings.

IMO there is only one long term solution:=20
Start removing old OSI strings returning true (all but "Windows 2006").
This should be no functional change on most machines.
On others (e.g. ThinkPads, probably more) chances are high, that we get
some things fixed up for free.

Then we should remove the "Windows 2006" string and fix up the rest.
=46irst, affected DSDTs should be evaluated in more detail to get a
picture how much could/would break.

If, and I doubt there are much, OSI is used for feature identification
or really fixes ASL statements in a sane way (hot-fixes are mostly ugly
hacks like "disable device capability" and similar..), those rare
machines can get a dmi entry to return true for the very Windows Versio=
n
that has the fix included: "Windows 2006", "Windows 2001 SP1".

> > So what should a vendor do if he has a BIOS hotfix for Windows 2003
> > only. The fix workarounds an old W2003 AML bug. But this fix will b=
reak
> > Linux and Vista on his machine. For Vista he can take care, Linux w=
ill
> > break. And you are going to try to implement a workaround for an ol=
d
> > W2003 OS bug (after people got angry because their machine they bou=
ght
> > with Linux pre-loaded does not boot anymore after a BIOS update)...
>=20
> Fine. So we define different behaviour depending on whether the firmw=
are=20
> asks for Vista or not. This isn't rocket science.

Here some examples:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
OSTB is the OS (only add this sleep if BIOS version is older than xy):
If (LAnd (LEqual (\_SB.PCI0.LPCB.INF, 0x01), LNot (LLess (\_SB.OSTB,
0x04))))
{
     Sleep (0x01F4)
}


I saw similar conditions for aquire and release statements. Looks like
sleep/serialization workarounds are needed on OSTB lower than 0x4?

=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
TPOS is the OS, maybe we should try to remove some of the early W$
Versions on PNP broken machines, I could imagine ACPI resource
management was rather broken on early W$ versions and we could fix up
some bugs:
Method (_CRS, 0, NotSerialized)
{
      If (LNot (LLess (TPOS, 0x04)))
      {
            CreateDWordField (MSRC, 0x1C, BARX)
            CreateDWordField (MSRC, 0x20, GALN)
            Store (0x1000, GALN)
            Store (\_SB.PCI0.Z009, Local0)
            And (Local0, 0xFFFFFFF0, BARX)
      }
      Return (MSRC)
}



=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
OSTP evaluates OSI, OSTB is the os version, again a resource fixup:

Name (_HID, EisaId ("PNP0A03"))
Method (_CRS, 0, NotSerialized)
=2E..
\_SB.OSTP ()
CreateDWordField (BUF0, 0x3E, VLEN)
CreateDWordField (BUF0, 0x36, VMAX)
CreateDWordField (BUF0, 0x32, VMIN)
ShiftLeft (VGA1, 0x09, Local0)
Add (VMIN, Local0, VMAX)
Store (Local0, VLEN)
Concatenate (GMEM (0x00), BUF0, Local1)
Concatenate (\_SB.PCI1.GETM (0x00), Local1, Local2)
If (LOr (LEqual (OSTB, 0x01), LEqual (OSTB, 0x02)))
{
     Concatenate (GMEM (0x01), Local2, Local3)
     Return (Local3)
}
Else
{
     Return (Local2)
}



=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
My favorite one (MSOS is the OS):
Method (CMRD, 1, NotSerialized)
{
    Acquire (SMIM, 0xFFFF)
    Store (Arg0, Local0)
    And (Local0, 0x7F, Local0)
    Store (Local0, SMID)
    Store (0x84, SMIC)
    Store (0x85, SMIC)
    Store (SMID, Local0)
    Release (SMIM)
    Return (Local0)
}

Method (HACK, 0, NotSerialized)
{
    Store (CMRD (0x37), Local0)
    And (Local0, 0xDF, Local0)
    CMWR (0x37, Local0)
    If (LEqual (MSOS, 0x04))
    {
        Store (CMRD (0x6F), Local0)
        Or (Local0, 0x04, Local0)
        CMWR (0x6F, Local0)
        Return (One)
    }
    Else
    {
        Store (CMRD (0x6F), Local0)
        And (Local0, 0xFB, Local0)
        CMWR (0x6F, Local0)
    }
}
=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



=EF=BB=BF=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Only acquire mutex and sleep if OS is newer than xy.
In this case it may make sense to provide a flag that we are
a newer Windows OS. But I am not sure.
If (LGreaterEqual (\WNTF, 0x02))
{
     Acquire (MCPU, 0xFFFF)
}
If (LGreaterEqual (\WNTF, 0x02))
{
     Sleep (0x64)
}



Also the behavior is totally undefined (as said above).
Some implementations override the previously set ones.
If the latest OS (in this case Windows 2006) is the last one, it's fine=
,
but this is pure luck that "Windows 2006" is the last one and on the
next BIOS Linux might get identified as Windows 2001...

If (_OSI ("Linux"))
{
    Store (0x03E8, OSYS)
}
If (_OSI ("Windows 2001"))
{
    Store (0x07D1, OSYS)
}
If (_OSI ("Windows 2001 SP1"))
{
    Store (0x07D1, OSYS)
}
If (_OSI ("Windows 2001 SP2"))
{
    Store (0x07D2, OSYS)
}
If (_OSI ("Windows 2006"))
{
    Store (0x07D6, OSYS)
}


Others do not override, but set different variables for the OS (quite
seldom, but like that we get all the added hacks...):


If (LEqual (\SCMP (\_OS, "Microsoft Windows"), Zero))
{
    Store (0x01, \W98F)
}
Else
{
     If (CondRefOf (\_OSI, Local0))
     {
         If (\_OSI ("Windows 2001"))
         {
                Store (0x01, \WNTF)
                Store (0x01, \WXPF)
                Store (0x00, \WSPV)
         }
     If (\_OSI ("Windows 2001 SP1"))
     {
         Store (0x01, \WSPV)
     }

     If (\_OSI ("Windows 2001 SP2"))
     {
         Store (0x02, \WSPV)
     }

     If (\_OSI ("Windows 2006"))
     {
         Store (0x01, \WVIS)
     }
}
Else
{
     If (LEqual (\SCMP (\_OS, "Microsoft Windows NT"), Zero))
     {
         Store (0x01, \WNTF)
     }
     Else
     {
          If (LEqual (\SCMP (\_OS, "Microsoft WindowsME: Millennium
Edition"), Zero))
     {
          Store (0x01, \WMEF)
          Store (0x01, \W98F)
     }
}

The latter is done on ThinkPads.
I wonder whether not returning _OSI("Windows XY") fixes the shutdowns o=
n
older ThinkPads. Those seem to run at an offset of 20 C above the real
temperature (could be a little EC write on Windows OS xy SP z, since
BIOS update W...).
And the right fix for it is not to blacklist ThinkPads to not return
true for all Windows versions, but to remove this unconditionally.

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
