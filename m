From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: Compaq Evo N800c and ACPI
Date: Sat, 12 Oct 2002 12:23:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210121223.52928.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi All

Having just acquired a Compaq EVO N800c, I have been trying to get acpi=20
working.  I have SuSE 8.1 loaded and pretty much everything worked out of=
 the=20
box apart from acpi.  Which looking at this list won't come as surprise t=
o a=20
number of you.

I have finally got a number of things going by following kevin's notes, s=
ee =20
http://www.scrye.com/~kevin/presario-2800.html.  Thank's Kevin. The Evo 8=
00s=20
and the Presario 2800s appear to have very similar DSDT.

Now comes the difficult bit:)  When going through the disassembly/assembl=
y=20
path a number of variables are undefined and also an Alias line causes a=20
complier error.  This is with the latest iasl (iasl-linux-20021002) compi=
ler=20
from Intel's site.  As noted in a previous posting to this list commentin=
g=20
these out or defining them external (how do you do that by the way) allow=
s=20
compilation.  I have tried both iasl in disassembler mode and pacpidump a=
nd=20
both give the same result. =20

These variables relate to fan control as far as I can tell and are to do =
with=20
accessing the fan state and controlling it.  Now has anybody figured out =
how=20
these should be defined to be effective or know how I might go about figu=
ring=20
this out?  I think this is part of the embedded controller, but I don't k=
now=20
where to find the definition for this.

Any help gratefully received

Regards

Bob
--=20
Bob Lees
Diamond Consulting Services Ltd
Chestnut Farm, Dinton
Aylesbury
Bucks, HP17 8UG
Phone: +44 (0) 1296 747667
Fax: +44 (0) 1296 747557
email: bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
