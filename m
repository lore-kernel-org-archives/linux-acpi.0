From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI_OS_NAME: no battery or no ac_adapter
Date: Fri, 17 Sep 2004 10:10:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05502070E15@orsmsx403.amr.corp.intel.com>
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

In newer versions of ACPI CA, we have changed ACPI_OS_NAME to "Microsoft =
Windows NT" for exactly this reason.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andreas Leppert
> Sent: Friday, September 17, 2004 6:04 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] ACPI_OS_NAME: no battery or no ac_adapter
>=20
> hi,
>=20
> i've a strange problem on my fujitsu laptop.  If i compile my kernel =
using
> acpi, everything works fine, but acpi -V doesn't change the value of
> ac_adapter info. it's always set to "on-line". it doesnt matter if the
> ac_adapter is plugged in or not. always "on-line".
>=20
> then i found this:
> http://sourceforge.net/mailarchive/message.php?msg_id=3D8560832
>=20
> so i changed the value of ACPI_OS_NAME in my
> /usr/src/linux/include/acpi/platform/aclinux.h from "Linux" to =
"Microsoft
> Windows NT". Now, ac_adapter changes its value from "on-line" to "off-
> line" if i unplug the ac_adapter.
>=20
> But now, acpi -V doesnt show me any battery information. the line is =
just
> omitted! so what to do?
>=20
> under http://andileppert.de/dsdtl.dsl you can find my dsdt. you will =
see
> that there are a few _OS commands...  what can i do? this is a strange
> thing...
>=20
> thanks in advance
> Andi Leppert
> _________________________________________________________
> Mit WEB.DE FreePhone=AE mit h=F6chster Qualit=E4t ab 0 Ct./Min.
> weltweit telefonieren! http://freephone.web.de/?mc=3D021201
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement =
on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
