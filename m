From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [Lhms-devel] [PATCH 1/1]  patch to fix	acpi_memhotplug.c
Date: Fri, 18 Nov 2005 11:47:06 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0378BDDE@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The ACPICA code supports _OSI and will respond TRUE when shown the
"Windows 2001" string.
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of KAMEZAWA Hiroyuki
> Sent: Thursday, November 17, 2005 6:57 PM
> To: keith
> Cc: Yasunori Goto; Brown, Len; S, Naveen B; acpi-devel; external
hotplug
> mem list; Tolentino, Matthew E
> Subject: Re: [ACPI] Re: [Lhms-devel] [PATCH 1/1] patch to fix
> acpi_memhotplug.c
>=20
> keith wrote:
> >> >
> >>Could you show your AML tree around Memory ?
> >
> >
> > See attached SSDT.
> >
> Thanks, at the first look.....
>=20
> >         Device (ME00)
> >         {
> <snip>
> >             Method (_STA, 0, NotSerialized)
> >             {
> >                 If (CondRefOf (_OSI, Local0))
> >                 {
> >                     If (\_OSI ("Windows 2001"))
> >                     {
> >                         If (LAnd (LEqual (BADH, EADH), LEqual (BADL,
> EADL)))
> >                         {
> >                             Or (MEID, \_SB.MEMI, \_SB.MEMI)
> >                             Return (0x00)
> >                         }
> >                         Else
> >                         {
> >                             And (Not (MEID), \_SB.MEMI, \_SB.MEMI)
> >                             Return (0x0F)
> >                         }
> >                     }
> >                 }
> >
> >                 Return (0x00)
> >             }
> It seems memory device's  _STA never returns 0xF always returns 0x0.
> (Device is online and enabled) when OS is not Windows2001.
> All PNP0C80 decvices in this SSDT has same _STA function.
>=20
> So, I think why your hot add failes is _STA has no present bit.
> =3D=3D
> drivers/acpi/scan.c
>=20
> acpi_add_single_object()
> <snip>
>          case ACPI_BUS_TYPE_DEVICE:
>                  result =3D acpi_bus_get_status(device);  in
> drivers/acpi/bus.c
>                  if (ACPI_FAILURE(result) || !device->status.present)
{ <-
> ---(*)
>                          result =3D -ENOENT;
>                          goto end;
>                  }
>                  break;
> =3D=3D
>=20
> rewriting your DSDT would be sane approach.
>=20
> -- Kame
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
