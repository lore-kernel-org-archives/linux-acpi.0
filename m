From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI: RSDP - ERROR: Invalid checksum
Date: Tue, 28 Jun 2005 08:19:41 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E01F2DB9A@orsmsx403.amr.corp.intel.com>
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
To: Klaus Muth <muth-5lHx5lHeYlQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Does this work under windows?
Please post a memory dump of the area in question, I would be very
interested to see it.
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Klaus Muth
> Sent: Tuesday, June 28, 2005 12:25 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI: RSDP - ERROR: Invalid checksum
>=20
> Am Donnerstag, 9. Juni 2005 11:13 schrieb Klaus Muth:
>=20
> > It seems to happen, that the IBM BIOS contains just the string "RSD
PTR
> "
> > exactly at a 16-Byte-Boundary before the real RSDP block, so the
wrnog
> > address is returned and acpi_table_init() in drivers/acpi/tables.c
fails
> to
> > checksum this block of course.
> [... 2.4 kernel finding the real RSDP ...]
> > Is there any patch to do the same with a vanilla 2.6 Kernel?
>=20
> Ahem. Did I hit a FAQ? If so: I could not find the answer. Could just
> someone
> be so kind to point me in the right direction?
>=20
> TIA
> --
> Klaus Muth
> HAGOS eG                      Industriestr. 62      fon: (+49) 711
78805-
> 86
> EDV-Programmierung            70565  Stuttgart      fax: (+49) 711
78805-
> 35
> http://www.hagos.de               Germany
> mailto:muth-5lHx5lHeYlQ@public.gmane.org
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. =
http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
