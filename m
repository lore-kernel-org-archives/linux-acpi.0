From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: Re: new n800v dsdt successfully disassembled, patched and installed (WAS: disasm/compile doesn't work)
Date: Tue, 15 Oct 2002 12:16:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210151216.55983.bob@diamond.demon.co.uk>
References: <200210142147.04742.bob@diamond.demon.co.uk> <200210150907.09320.mark.pritchard-acpi@modus.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210150907.09320.mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>, acpi mail list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Mark

Thanks for the response.  I think the 800c, 800v and presario 2800 series=
 are=20
all the same in this area.  It was the external definitions which I was=20
missing.  I now have fan control working - yea!

I also have akpi monitoring the battery and ac state.  It needed some cha=
nges=20
to the makefile to get it made, I was using akpi-0.3.2.

I still have to figure out how I broke processor performance.  Working on=
=20
this.  I have changed a number of the C??? referernces to the correct dev=
ice,=20
eg FAN1 etc.  This isn't complete yet.

When the new table is loaded I get a number of errors, which I am still t=
rying=20
to track down.  eg=20
evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0,=20
AE_ALREADY_EXISTS
where PCI0 is C03C in your version
and
dsopcode-0497 [19] Ds_init_buffer_field  : Field size 1184 exceeds Buffer=
 siz
e 1088 (bits)
psparse-1155: *** Error: Method execution failed, AE_AML_BUFFER_LIMIT

Have you seen anything like this?

Regards

Bob

On Tuesday 15 October 2002 00:07, Mark Pritchard wrote:
> Hi Bob,
>
> I've been playing with ACPI over the last week or so with my Compaq Evo
> N800v which is very similar to your N800c (in fact, the compaq website
> seems to only differentiate them by maximum processor speed, max hdd an=
d
> screen type... http://www.compaq.com/products/notebooks/index.html)
>
> With some help from this group (and that email you wrote earlier), I've
> successfully disassembled and tweaked my dsdt. I now have battery statu=
s
> (which was my goal), but haven't mucked around with the other aspects o=
f
> ACPI (fan, processor speed etc).
>
> The details of what I did to make it work:
>
> 1) 2.4.19 patched to 2.4.20pre8
>
> 2) applied acpi-20021002 2.4.20pre8 patch from
> http://sourceforge.net/projects/acpi (direct download link is
> http://prdownloads.sourceforge.net/acpi/acpi-20021002-2.4.20-pre8.diff.=
gz?d
>ownload)
>
> 3) downloaded the iasl release from intel's site at
> http://developer.intel.com/technology/iapc/acpi/ with the direct downlo=
ad
> link being
> http://developer.intel.com/technology/iapc/acpi/downloads/iasl-linux-20=
0210
>02.tar.gz
>
> 4) disassembled my dsdt by:
>
> =09a) copying /proc/acpi/dsdt to a local file (dsdt.raw)
> =09b) running "iasl -d dsdt.raw" (this gives you the dsdt.dsl file you =
tweak
> below)
>
> 5) Tweaked the dsl file by doing the following:
>
> =09a) removed all "*" characters from the object names
> =09b) added external declarations for all missing objects
> =09c) commented out the alias line which complained about the missing l=
ink
> =09d) changed the store line which referenced the above alias line to u=
se the
> fully qualified path (I did try using the fqp on the alias, but no joy)
> =09e) changed the references from C11C to BAT1 and C11B to BAT2
>
> 6) Recompiled my dsdt with "iasl -tc -p new dsdt.dsl" to give me new.he=
x
> which is a C formatted representation of the compiled dsl (I ignored th=
e
> two warnings).
>
> 7) Copied new.hex to drivers/acpi/tables/compaq_evo_n800v.h under my ke=
rnel
> source tree.
>
> 8) Edited drivers/acpi/tables/tbgetall.c as follows:
>
> =09a) Included the new dsdt header
> =09b) Declared and set new ACPI_POINTER to hold a physical address rath=
er
> than the logical so I could pass it to acpi_tb_get_secondary_table()
> =09c) Changed the call to acpi_tb_get_secondary_table() to use the new =
dsdt
>
> 9) Configured the kernel with Power Management and all ACPI (except
> toshiba) options selected. Screen shots included in tarball mentioned
> below.
>
> 10) Rebuilt the kernel, crossed my fingers and jumped around for joy wh=
en I
> can now do:
>
> [pritchma@seth:pritchma]$ uname -a
> Linux seth.modus.com.au 2.4.20-pre8 #10 Mon Oct 14 14:39:22 EST 2002 i6=
86
> unknown
> [pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/info
> present:                 yes
> design capacity:         4179 mAh
> last full capacity:      4179 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 418 mAh
> design capacity low:     0 mAh
> capacity granularity 1:  100 mAh
> capacity granularity 2:  100 mAh
> model number:            Primary
> serial number:           3
> battery type:            4E4F494C
> OEM info:                 COMPAQ
> [pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            0 mA
> remaining capacity:      4179 mAh
> present voltage:         16615 mV
>
> Pull out the power:
>
> [pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/state
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            1400 mA
> remaining capacity:      4179 mAh
> present voltage:         16296 mV
>
> Looks good to me.
>
> I've uploaded a tarball to
> http://www.modus.com.au/scratch/compaq_n800v_acpi.tar.bz2
>
> It contains:
>
> * my original, changed and a diff of the disassembled dsdt
> * my original, changed and a diff of tbgetall.c
> * two screenshots of the kernel options I used
>
> Now for the disclaimer :) I knew nothing about ACPI a week ago, and muc=
ked
> around with this until it worked. The above may be everything you need =
to
> know, or not...but I do hope it sorts your problem out.
>
> I'm now off to work out why kacpi and akpi both hang at startup...or wr=
ite
> my own battery monitor!
>
> Cheers
>
> Mark Pritchard
>
> On Tue, 15 Oct 2002 06:47, Bob Lees wrote:
> > Hi
> >
> > This may have been asked/aired before, in which case I apologise.=20
> > However here goes.
> >
> > I have sort of successfully disassembled/decompiled the dsdt from my =
evo
> > 800c, using both pacpidump and iasl.  They both produce the same outc=
ome.
> > By "sort of" I mean that I cannot disassemble and immdeiately recompi=
le
> > without errors.  Some of them are basic to the compaq dsdt in that it
> > references *PNP???? rather than PNP????.  That is easy to fix.  The o=
ther
> > problem is that objects are disassembed which have no definition.  Th=
is
> > is much harder as it is not clear how these undefined objects should =
be
> > defined.  Is this a common problem and does a reasonable fix exist? a=
nd
> > if so help!
> >
> > For the present I have commented out the offending references, but th=
is
> > means that I have no fan control!! which may not be good in the long
> > term:)
> >
> > Regards
> >
> > Bob

--=20
Bob Lees
Diamond Consulting Services Ltd
Aylesbury, Bucks, HP17 8UG
Phone: +44 (0) 1296 747667
Fax: +44 (0) 1296 747557
email: bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
