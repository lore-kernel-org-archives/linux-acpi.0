From: "Andreas Leppert" <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: RE: ACPI_OS_NAME: no battery or no ac_adapter
Date: Fri, 17 Sep 2004 19:23:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1570067295@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

if i understand you then you have enabled this (Microsoft Windows NT value=
 for the variable ACPI=5FOS=5FNAME) in your newest patch. i have installed the=
 patch, ACPI=5FOS=5FNAME is now in the include/acpi/acconfig.h.=20

ok, ac=5Fadapter events are possible, but why on hell is now /proc/acpi/batt=
ery/BAT0/state -> present rate always unknown (so acpi -V doesnt give me a=
ny battery information!) if i change the ACPI=5FOS=5FNAME to "Linux", acpi -V =
gives me information about the battery... but there aren't any ac=5Fadapter =
events!

where's the problem with this=3F it has to do something with the ACPI=5FOS=5FNAM=
E ...=20

perhaps something with my dsdt=3F really dont know. do you have any answers =
for this=3F

thanks again

"Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote on 17.09.04 19:12:05:
>=20
> In newer versions of ACPI CA, we have changed ACPI=5FOS=5FNAME to "Microsoft=
 Windows NT" for exactly this reason.
>=20
> Bob
>=20
>=20
> > hi,
> >=20
> > i've a strange problem on my fujitsu laptop.  If i compile my kernel u=
sing
> > acpi, everything works fine, but acpi -V doesn't change the value of
> > ac=5Fadapter info. it's always set to "on-line". it doesnt matter if the=

> > ac=5Fadapter is plugged in or not. always "on-line".
> >=20
> > then i found this:
> > http://sourceforge.net/mailarchive/message.php=3Fmsg=5Fid=3D8560832
> >=20
> > so i changed the value of ACPI=5FOS=5FNAME in my
> > /usr/src/linux/include/acpi/platform/aclinux.h from "Linux" to "Micros=
oft
> > Windows NT". Now, ac=5Fadapter changes its value from "on-line" to "off-=

> > line" if i unplug the ac=5Fadapter.
> >=20
> > But now, acpi -V doesnt show me any battery information. the line is j=
ust
> > omitted! so what to do=3F
> >=20
> > under http://andileppert.de/dsdtl.dsl you can find my dsdt. you will s=
ee
> > that there are a few =5FOS commands...  what can i do=3F this is a strange=

> > thing...
> >=20
> > thanks in advance
> > Andi Leppert
> > =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> > Mit WEB.DE FreePhone=AE mit h=F6chster Qualit=E4t ab 0 Ct./Min.
> > weltweit telefonieren! http://freephone.web.de/=3Fmc=3D021201
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> > Project Admins to receive an Apple iPod Mini FREE for your judgement o=
n
> > who ports your project to Linux PPC the best. Sponsored by IBM.
> > Deadline: Sept. 24. Go here: http://sf.net/ppc=5Fcontest.php
> > =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc=5Fcontest.php
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/=3Fmc=3D021193



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
