From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: Re: hacking DSDT [-WAS: freeze with 1.0.2]
Date: 23 Jul 2003 10:57:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058954278.1473.6.camel@darkstar.portugal>
References: <3F1CEAD9.8020103@paceblade.com>
	<200307222132.56267.mflt1@micrologica.com.hk>
	<3F1D53E6.5030806@paceblade.com>
	<200307230048.35698.mflt1@micrologica.com.hk>
	<3F1E501B.70603@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F1E501B.70603-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Cc: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>, swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi
http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt
read:
# Error 1051 - Access width of Field Unit extends beyond region limit

should be the same problem.=20


On Wed, 2003-07-23 at 10:06, Robert Woerle wrote:
>=20
>=20
> Michael Frank schrieb:
>=20
> >On Tuesday 22 July 2003 23:10, Robert Woerle wrote:
> > =20
> >
> >>Michael Frank schrieb:
> >>   =20
> >>
> >>>On Tuesday 22 July 2003 18:43, Robert Woerle wrote:
> >>>     =20
> >>>
> >>>>Michael Frank schrieb:
> >>>>       =20
> >>>>
> >
> >Had a lock at your dmesg's, this link setup is a much more beautiful exa=
mple=20
> >(a bigger mess) than my setup.=20
> >
> >The remaining problem is that multiple links are BIOS pre-assigned to IR=
Q5=20
> >(one even invalidly).=20
> >
> >The patch sent to you does not modify pre-assigned links, so what we hav=
e=20
> >to do is to scan all links and re-assign or disable the redundant ones, =
and
> >possibly modify the DSDT as there seems to be no choice other than IRQ5.
> >
> >Please send your bzip2'd DSDT (/proc/acpi/dsdt), and give me a bit of ti=
me...
> > =20
> >
> ok , i do now dig myself in the dsdt and try to figure something out ...
>=20
> i found the IRQ settings and wanted to change some irq`s so that the IRQ=20
> 5 gets used by one device alone ...
> but when i want to compile my dsdt with iasl it get the error
>=20
> dsdt.dsl  904:   FIELD(PUIC,DWordAcc, Lock, Preserve)
>    Error 1047 -                        ^ Access width is greater than=20
> region size
>=20
>=20
> do you know something ...  it happens also on my plain unchanged=20
> original dsdt !!!
>=20
>=20
> >
> >Regards
> >Michael

--=20
S=E9rgio Basto




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
