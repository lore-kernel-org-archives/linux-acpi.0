From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: newbie
Date: Mon, 30 Dec 2002 19:28:07 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E36D@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pawel S. Veselov" <vps-DfbhUdzxHZh1tZTNRjcZhg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pawel,

The ACPI subsystem is indeed progressing on the 2.4 kernel, and the
maintainers (Andy Grover and others) keep a Bitkeeper tree of the latest
2.4.xx kernel with the latest ACPI changes.  Browse to
http://linux-acpi.bkbits.net/ to see the official source tree.  They are
also working with the 2.4 kernel maintainer (Marcelo Tosatti) to always
get the latest subsystem in the latest kernel version.  I think that
kernel tar files (for 2.4 and 2.5) are maintained on the sourceforge
site as well.

In addition, most major Linux distributors should have ACPI built into
their 2.4 kernels soon, if not already.

Regards,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: Pawel S. Veselov [mailto:vps-DfbhUdzxHZh1tZTNRjcZhg@public.gmane.org]=20
> Sent: Monday, December 30, 2002 4:25 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] newbie
>=20
>=20
> Hi !
>=20
> I just subscibed to this list. From watching some messages, I=20
> understand the ACPI is not really progressing in 2.4. kernel,=20
> s that correct ?
>=20
> The sourceforge webpages unfortunately don't contain much=20
> information on the developement status, neither about the sources.
>=20
> So, a few questions : is there an official sourcetree, or=20
> whatever is developed is in the 2.5.x kernel ?
>=20
> Is 2.4.x kernel is to be maintained with the latest ACPI=20
> changes ? If not, then is it posible to take the ACPI=20
> subsystem from 2.5 kernels and recompile with 2.4, or are=20
> there incompatible kernel interfaces involved ?
>=20
> The reason I got involved in ACPI is that I got HP Pavillion=20
> ze5155 laptop, and it doesn't have any APM, it's pure ACPI.=20
> Looks like power buttons is the only OSPM component that is=20
> processed correctly. Removing battery/ ac adaptor doesn't=20
> even trigger SCI (according to /proc/interrupts), so I guess=20
> not all of the statuses are enabled. Also, battery status=20
> returned is always 0x0f, so the battery is believed to be=20
> absent all the time. I'm not sure how to identify the ACPI=20
> bios, so I can report what kind is it. The motherboard is ALi=20
> M<something>, that's all I know.
>=20
> Thanks !
>     Pawel.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
