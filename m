From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fw: [PATCH]: Correctly locate RSDP in EBDA
Date: Mon, 25 Jul 2005 15:19:57 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02315A42@orsmsx403.amr.corp.intel.com>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>, Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

There are two versions of this code in Linux, the ACPICA version and the
version in boot.c. It is very cumbersome to maintain two versions of
this sensitive code, and the version in boot.c should be removed.  The
ACPICA version (in tbxfroot.c) already handles EBDA and bad checksums
correctly.

Bob Moore


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andrew Morton
> Sent: Monday, July 25, 2005 3:13 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Udo A. Steinberg
> Subject: [ACPI] Fw: [PATCH]: Correctly locate RSDP in EBDA
>=20
>=20
>=20
> Begin forwarded message:
>=20
> Date: Wed, 20 Jul 2005 17:42:07 +0200
> From: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
> To: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Subject: [PATCH]: Correctly locate RSDP in EBDA
>=20
>=20
>=20
> ACPI spec. states that the location of the RSDP structure is found by
> searching
> * The first 1 KB of the Extended BIOS Data Area (EBDA).
> * The BIOS read-only memory space between 0E0000h and 0FFFFFh
>=20
> The EBDA scan looks wrong. The patch below against 2.6.12 should
correct
> this.
>=20
> -Udo.
>=20
> ---
>=20
> Calculate correct EBDA address for ACPI RSDP scan. The word at BIOS
Data
> Area
> 40:0E is the segment address of the EBDA.
>=20
> Signed-off-by: Udo A. Steinberg <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
>=20
> --- linux-2.6.12/arch/i386/kernel/acpi/boot.c.old       2005-07-20
> 17:28:32.000000000 +0200
> +++ linux-2.6.12/arch/i386/kernel/acpi/boot.c   2005-07-20
> 17:31:15.000000000 +0200
> @@ -648,7 +648,7 @@
>          * Scan memory looking for the RSDP signature. First search
EBDA
> (low
>          * memory) paragraphs and then search upper memory
(E0000-FFFFF).
>          */
> -       rsdp_phys =3D acpi_scan_rsdp (0, 0x400);
> +       rsdp_phys =3D acpi_scan_rsdp (*(u16*) 0x40E << 4, 0x400);
>         if (!rsdp_phys)
>                 rsdp_phys =3D acpi_scan_rsdp (0xE0000, 0x20000);
>=20



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
