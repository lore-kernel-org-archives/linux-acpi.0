From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI: RSDP - ERROR: Invalid checksum
Date: Wed, 29 Jun 2005 09:05:47 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E01F61BAC@orsmsx403.amr.corp.intel.com>
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


Thanks for the memory dump.  I will look at this against the ACPI spec
and get back to you.

I think that we may need to change the memory scan code (in tbxfroot.c)
to search for the first "RSD PTR" string with an associated table that
has a valid checksum. I also think that this has been requested before.

Bob

> -----Original Message-----
> From: Klaus Muth [mailto:muth-5lHx5lHeYlQ@public.gmane.org]
> Sent: Wednesday, June 29, 2005 1:42 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Moore, Robert
> Subject: Re: [ACPI] ACPI: RSDP - ERROR: Invalid checksum
>=20
> Am Mittwoch, 29. Juni 2005 09:30 schrieb Klaus Muth:
>=20
> > Hups. How do I retreive that? I've got no idea :(.
> Argh! Little bit of googling helps around "no idea"s...
>=20
> For every one else facing my problem:
>   dd if=3D/dev/mem of=3D~/mem bs=3D1k count=3D1k
>   xxd mem > dump


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
