From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 7 Sep 2012 03:18:36 -0400
Message-ID: <20120907071836.GB16591@gchen.bj.intel.com>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5812 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2IGHVO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 03:21:14 -0400
Content-Disposition: inline
In-Reply-To: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Len Brown <lenb@kernel.org>, ying.huang@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, tony.luck@intel.com, linux-acpi@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2012 at 07:40:31AM +0100, Jan Beulich wrote:
> Date:	Fri, 07 Sep 2012 07:40:31 +0100
> From: Jan Beulich <JBeulich@suse.com>
> To: Len Brown <lenb@kernel.org>
> Cc: ying.huang@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
>  linux-acpi@vger.kernel.org
> Subject: [PATCH] GHES: correct page protection flags in
>  ghes_ioremap_pfn_...()
> X-Mailer: Novell GroupWise Internet Agent 12.0.0=20
>=20
> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
> translation otherwise done in PV guests. (The offending commit was
> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)
>

Oh, right. In virtual environment, physical address is virtualized, too.
We need to tell *ioremap* to map in proper address space. But I want
to do if you can update all related mappings for APEI tables? I'm not sure
if all APEI tables are affected by this issue.

>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>=20
> ---
>  drivers/acpi/apei/ghes.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- 3.6-rc4/drivers/acpi/apei/ghes.c
> +++ 3.6-rc4-ghes-ioremap-prot/drivers/acpi/apei/ghes.c
> @@ -206,7 +206,7 @@ static void __iomem *ghes_ioremap_pfn_nm
> =20
>  	vaddr =3D (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
>  	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
> -			   pfn << PAGE_SHIFT, PAGE_KERNEL);
> +			   pfn << PAGE_SHIFT, PAGE_KERNEL_IO);
> =20
>  	return (void __iomem *)vaddr;
>  }
> @@ -217,7 +217,7 @@ static void __iomem *ghes_ioremap_pfn_ir
> =20
>  	vaddr =3D (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
>  	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
> -			   pfn << PAGE_SHIFT, PAGE_KERNEL);
> +			   pfn << PAGE_SHIFT, PAGE_KERNEL_IO);
> =20
>  	return (void __iomem *)vaddr;
>  }
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSZ/MAAoJEI01n1+kOSLHAhYP/3z8luSF/eNEVqfR1wBMI9X0
iItSa7jgTBaDPq+znDViGxdDjWb1BJjuP4ESLrOP5CjpITeQI8vGxkm5TsZevlPy
K8GX/zWsPeYymHa+fw/6cwW0oJPeBPBGtfPaZY85hSIo9K986oPw2CT19KvNYM2G
EgrsUccpBwbP1z+ldWSQutf3j2VZYnSb+47MgW7x8G7HperShaYNjBNiqRsYwStL
Oe3cy3WyWYbhvAdf3muk/dp4OD1A/FRAbKy1rCQSkTVWiplBA3vvols8nAmyF4eM
jpP/6CmbEzU1vBYRleAWcx/+9kuBRvczfIgUwMn1R+kFMRXL93MhiOm169x0M3jB
w7ExZMcF4WGfT+O6kdqWb1zb0Rtkg+68kmtFADD2t/PuOdOxTXr3cSOH7WeGNUMR
lN4Tx5BLqxxxTErUx+Yp3aOVLHILHlT8jdwiw0hEiBonEG183U7aBGX85Q3i7oi4
L08VBk+H4j0s2YbCKOzMIUp/ICXYvXRZnClAax//05KpBSJiRfivcqkhjxl2wYEh
K/8dPJUf2sRiHkb4ZTtqlrVBCOwmJGJfnY/2kOtDEDKf1KUs4r9Q9K1nYCfAsMX7
6vzrRCsCBJ2wsgMd26JtoaRUpsCH7GSt0OMvmCAxfYbRmDLuJe1aG2O2mz1lC6Yx
iU39wqfpma5GSaHb7VJl
=+odb
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
