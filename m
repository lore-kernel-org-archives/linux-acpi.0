From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI_OS_NAME: no battery or no ac_adapter
Date: Fri, 17 Sep 2004 13:48:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05502071208@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andreas Leppert <wudmx-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It sounds like you are running into a new and different problem with the =
battery status.


> -----Original Message-----
> From: Andreas Leppert [mailto:wudmx-S0/GAf8tV78@public.gmane.org]
> Sent: Friday, September 17, 2004 10:23 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Moore, Robert
> Subject: RE: [ACPI] ACPI_OS_NAME: no battery or no ac_adapter
>=20
> if i understand you then you have enabled this (Microsoft Windows NT =
value
> for the variable ACPI_OS_NAME) in your newest patch. i have installed =
the
> patch, ACPI_OS_NAME is now in the include/acpi/acconfig.h.
>=20
> ok, ac_adapter events are possible, but why on hell is now
> /proc/acpi/battery/BAT0/state -> present rate always unknown (so acpi =
-V
> doesnt give me any battery information!) if i change the ACPI_OS_NAME =
to
> "Linux", acpi -V gives me information about the battery... but there
> aren't any ac_adapter events!
>=20
> where's the problem with this? it has to do something with the
> ACPI_OS_NAME ...
>=20
> perhaps something with my dsdt? really dont know. do you have any =
answers
> for this?
>=20
> thanks again
>=20
> "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote on 17.09.04 19:12:05:
> >
> > In newer versions of ACPI CA, we have changed ACPI_OS_NAME to =
"Microsoft
> Windows NT" for exactly this reason.
> >
> > Bob
> >
> >
> > > hi,
> > >
> > > i've a strange problem on my fujitsu laptop.  If i compile my =
kernel
> using
> > > acpi, everything works fine, but acpi -V doesn't change the value =
of
> > > ac_adapter info. it's always set to "on-line". it doesnt matter if =
the
> > > ac_adapter is plugged in or not. always "on-line".
> > >
> > > then i found this:
> > > http://sourceforge.net/mailarchive/message.php?msg_id=3D8560832
> > >
> > > so i changed the value of ACPI_OS_NAME in my
> > > /usr/src/linux/include/acpi/platform/aclinux.h from "Linux" to
> "Microsoft
> > > Windows NT". Now, ac_adapter changes its value from "on-line" to =
"off-
> > > line" if i unplug the ac_adapter.
> > >
> > > But now, acpi -V doesnt show me any battery information. the line =
is
> just
> > > omitted! so what to do?
> > >
> > > under http://andileppert.de/dsdtl.dsl you can find my dsdt. you =
will
> see
> > > that there are a few _OS commands...  what can i do? this is a =
strange
> > > thing...
> > >
> > > thanks in advance
> > > Andi Leppert
> > > _________________________________________________________
> > > Mit WEB.DE FreePhone=AE mit h=F6chster Qualit=E4t ab 0 Ct./Min.
> > > weltweit telefonieren! http://freephone.web.de/?mc=3D021201
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> > > Project Admins to receive an Apple iPod Mini FREE for your =
judgement
> on
> > > who ports your project to Linux PPC the best. Sponsored by IBM.
> > > Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> > Project Admins to receive an Apple iPod Mini FREE for your judgement =
on
> > who ports your project to Linux PPC the best. Sponsored by IBM.
> > Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> ________________________________________________________________
> Verschicken Sie romantische, coole und witzige Bilder per SMS!
> Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=3D021193



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
