From: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Subject: Re: new n800v dsdt successfully disassembled, patched and installed (WAS: disasm/compile doesn't work)
Date: Tue, 15 Oct 2002 09:07:44 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210150907.09320.mark.pritchard-acpi@modus.com.au>
References: <200210142147.04742.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210142147.04742.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>, acpi mail list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Bob,

I've been playing with ACPI over the last week or so with my Compaq Evo N=
800v=20
which is very similar to your N800c (in fact, the compaq website seems to=
=20
only differentiate them by maximum processor speed, max hdd and screen=20
type... http://www.compaq.com/products/notebooks/index.html)

With some help from this group (and that email you wrote earlier), I've=20
successfully disassembled and tweaked my dsdt. I now have battery status=20
(which was my goal), but haven't mucked around with the other aspects of =
ACPI=20
(fan, processor speed etc).

The details of what I did to make it work:

1) 2.4.19 patched to 2.4.20pre8

2) applied acpi-20021002 2.4.20pre8 patch from=20
http://sourceforge.net/projects/acpi (direct download link is=20
http://prdownloads.sourceforge.net/acpi/acpi-20021002-2.4.20-pre8.diff.gz=
?download)

3) downloaded the iasl release from intel's site at=20
http://developer.intel.com/technology/iapc/acpi/ with the direct download=
=20
link being =20
http://developer.intel.com/technology/iapc/acpi/downloads/iasl-linux-2002=
1002.tar.gz

4) disassembled my dsdt by:

=09a) copying /proc/acpi/dsdt to a local file (dsdt.raw)
=09b) running "iasl -d dsdt.raw" (this gives you the dsdt.dsl file you tw=
eak=20
below)

5) Tweaked the dsl file by doing the following:

=09a) removed all "*" characters from the object names
=09b) added external declarations for all missing objects
=09c) commented out the alias line which complained about the missing lin=
k
=09d) changed the store line which referenced the above alias line to use=
 the=20
fully qualified path (I did try using the fqp on the alias, but no joy)
=09e) changed the references from C11C to BAT1 and C11B to BAT2

6) Recompiled my dsdt with "iasl -tc -p new dsdt.dsl" to give me new.hex =
which=20
is a C formatted representation of the compiled dsl (I ignored the two=20
warnings).

7) Copied new.hex to drivers/acpi/tables/compaq_evo_n800v.h under my kern=
el=20
source tree.

8) Edited drivers/acpi/tables/tbgetall.c as follows:

=09a) Included the new dsdt header
=09b) Declared and set new ACPI_POINTER to hold a physical address rather=
 than=20
the logical so I could pass it to acpi_tb_get_secondary_table()=20
=09c) Changed the call to acpi_tb_get_secondary_table() to use the new ds=
dt

9) Configured the kernel with Power Management and all ACPI (except toshi=
ba)=20
options selected. Screen shots included in tarball mentioned below.

10) Rebuilt the kernel, crossed my fingers and jumped around for joy when=
 I=20
can now do:

[pritchma@seth:pritchma]$ uname -a
Linux seth.modus.com.au 2.4.20-pre8 #10 Mon Oct 14 14:39:22 EST 2002 i686=
=20
unknown
[pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         4179 mAh
last full capacity:      4179 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 418 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           3
battery type:            4E4F494C
OEM info:                 COMPAQ
[pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      4179 mAh
present voltage:         16615 mV

Pull out the power:

[pritchma@seth:pritchma]$ cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1400 mA
remaining capacity:      4179 mAh
present voltage:         16296 mV

Looks good to me.

I've uploaded a tarball to=20
http://www.modus.com.au/scratch/compaq_n800v_acpi.tar.bz2

It contains:

* my original, changed and a diff of the disassembled dsdt
* my original, changed and a diff of tbgetall.c
* two screenshots of the kernel options I used

Now for the disclaimer :) I knew nothing about ACPI a week ago, and mucke=
d=20
around with this until it worked. The above may be everything you need to=
=20
know, or not...but I do hope it sorts your problem out.

I'm now off to work out why kacpi and akpi both hang at startup...or writ=
e my=20
own battery monitor!

Cheers

Mark Pritchard

On Tue, 15 Oct 2002 06:47, Bob Lees wrote:
> Hi
>
> This may have been asked/aired before, in which case I apologise.  Howe=
ver
> here goes.
>
> I have sort of successfully disassembled/decompiled the dsdt from my ev=
o
> 800c, using both pacpidump and iasl.  They both produce the same outcom=
e. =20
> By "sort of" I mean that I cannot disassemble and immdeiately recompile
> without errors.  Some of them are basic to the compaq dsdt in that it
> references *PNP???? rather than PNP????.  That is easy to fix.  The oth=
er
> problem is that objects are disassembed which have no definition.  This=
 is
> much harder as it is not clear how these undefined objects should be
> defined.  Is this a common problem and does a reasonable fix exist? and=
 if
> so help!
>
> For the present I have commented out the offending references, but this
> means that I have no fan control!! which may not be good in the long te=
rm:)
>
> Regards
>
> Bob



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
