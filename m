From: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Subject: RE: ACPI HOWTO
Date: Tue, 18 May 2004 09:50:53 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B774920D825C2D4880A3C1B0D6EF94189A5063@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Several tech HowTos are maturing via direct input from users using
a wiki of some sort.  The ones I have used and seen however
suffer from poor organization.

I would suggest readers of this group pound out some kind of
a framework (outline?) that someone could host on a wiki where
everyone/anyone can ask questions and provide answers.

So, here is my attempt at getting it started:

[Note:  This may not be the best solution.  Perhaps most of this
information is already available or has been answered in this
list.  Because ACPI is so tied to kernel drivers and is changing
at an enourmous rate the "structure" of a HOWTO may not be the
most effective use of developer's time.  It won't hurt me if my
idea is torn to shreds or worse (better?) a one line link that
says look here for 95% of the answers to these questions.]

What is ACPI?  Maybe terse definition is all that is needed with
   pointers to Intel standard, and some others.

If ACPI is an Intel standard does it work with Athlon or other
   hardware?

Where does ACPI fit in ...
   Replacement for APM
   A) the boot process of ...
        A1) any PC?
             What is happening (is ACPI or APM involved) before
             the BIOS interrupt screen happens?
             What is happening between the BIOS and the Linux
             Loader (LILO or Grub, etc.)  i.e., can a multi-kernel
             system allow booting either APM or ACPI?=20
        A2) battery powered PC?
             What controls battery charge when nothing else is
             running?
             What is going on when I hit the power button and
             lights flash but then nothing?  [A lo-o-ong power
             button press causes a normal boot.]
   B) standby =3D S2?
        I think it went into S2 ok, but I can't wake it up?
   C) Suspend to RAM =3D S3?
        I think it went into S3 ok, but I can't wake it up?
   D) Suspend to DISK =3D S4?
        D1) Are there any alternatives to APM and ACPI?
             provide link to swsusp(2)?
   E) Emergency shutdown =3D S5?

What modules does the kernel need to have ACPI work?
   Provide a link to /usr/src/linux/Documentation/pm.txt
   and maybe others.

How can I tell if these modules are installed?
   grep ACPI /usr/src/linux/.config

What do these filesystems do and how are they useful?

   /proc/acpi
   /sys/power
   /sys/firmware/acpi

I get ... error when booting.  What can/should I do?
and
what kernel parameters may I use to force ACPI do things?

     I'm convinced my machine has a bios error.  How can
     tell if a new bios is available?  If not, how can I
     persuade my manufacturer to fix the problem with a
     bios upgrade?

I get ... error when going into or resuming from S2/S3/S4.

    Answer: First simplify your problem by not running X,
    rmmoding networking modules before standby/suspend, etc.

How does kernel ACPI interface with user programs?
   link to acpid, maybe others.

Specific ACPI questions/info about ...
      A) battery
	B) processor
      C) fan
      D) AC adapter
      E) buttons
      F) thermal
      G) maybe dsdt, embedded_controller, power_resource, etc.
=09

I think I have found an acpi bug.  How do I report it?
What logs, kernel debug parameters to enhance logs, etc.
are important to the acpi developers?

I got acpi working (finally) on ... notebook PC.  Does anyone else
care?  Should I report success to linux-on-laptops or tuxmobile?

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Emma Jane Hogbin
> Sent: Tuesday, May 18, 2004 7:37 AM
> To: acpi
> Subject: Re: [ACPI] ACPI HOWTO
>=20
> On Mon, May 17, 2004 at 08:13:05PM -0400, John Belmonte wrote:
> > Certainly ACPI is a complex system, and transitioning from APM is=20
> > difficult.  These topics are worthy of documentation=20
> efforts like yours.=20
> >  However, it may be better to start such a document with=20
> "Be sure you=20
> > are using the latest 2.4 or 2.6 kernel", provide a reference to=20
> > documents which may assist users in upgrading their kernel,=20
> and focus on=20
> > ACPI configuration and troubleshooting itself.
>=20
> Agreed. At this point I've started introducing the 2.6.x series
> information into the document; however, I've actually wrecked my own
> laptop to try and get the new information in. I used to have=20
> a perfectly
> functional laptop, now that I've got the 2.6.5 kernel I'm=20
> having problems
> with not only ACPI, but also my wireless card and my printers. Even in
> 2.4.22 ACPI has never worked perfectly for me and it was virtually
> impossible for me to extend the documentation past what my laptop was
> capable of doing.
>=20
> Although I'm happy to compile and write documentation on a=20
> subject that I
> know little about, I am not willing to release documentation=20
> that I am not
> able to test for myself. I've asked for help from a number of=20
> different
> places and have gotten no response other than from this=20
> email. I recently
> received email from one person about a specific bug. When I=20
> asked them for=20
> further information about the problem he told me to just put=20
> in the documentation
> that users should upgrade their BIOS--as if everyone already=20
> knew how to
> do this. I certainly don't and I can't imagine I'm the only one.
>=20
> I understand that everyone is busy. I know I certainly am.=20
> While I'm happy
> to work on bringing the documentation up to date, I cannot do=20
> it without
> help.
>=20
> emma
>=20
> --=20
> Emma Jane Hogbin
> [[ 416 417 2868 ][ www.xtrinsic.com ]]
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=3D2562&alloc_id=3D6184&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
