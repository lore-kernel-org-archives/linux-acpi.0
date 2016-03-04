From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/4] ACPI: Change NFIT driver to insert new resource
Date: Thu, 03 Mar 2016 17:12:03 -0700
Message-ID: <1457050323.15454.131.camel@hpe.com>
References: <1456959056-12316-1-git-send-email-toshi.kani@hpe.com>
	 <1456959056-12316-5-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4ibLoKSe06P4WTHiQ6x=hoTfEmCvVKGv9hJ4Z7++2PN-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:56848 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773AbcCCXTX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 18:19:23 -0500
In-Reply-To: <CAPcyv4ibLoKSe06P4WTHiQ6x=hoTfEmCvVKGv9hJ4Z7++2PN-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2016-03-03 at 14:49 -0800, Dan Williams wrote:
> On Wed, Mar 2, 2016 at 2:50 PM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
=C2=A0:
> > diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> > index fb53db1..d97b53f 100644
> > --- a/drivers/acpi/nfit.c
> > +++ b/drivers/acpi/nfit.c
> > @@ -1571,6 +1571,30 @@ static int ars_status_process_records(struct
> > nvdimm_bus *nvdimm_bus,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> >=20
> > +static int acpi_nfit_insert_resource(struct acpi_nfit_desc *acpi_d=
esc,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct nd_region_desc *ndr_desc)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *res, *n=
d_res =3D ndr_desc->res;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t size =3D nd_res->=
end - nd_res->start + 1;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* No operation if the r=
egion is already registered as PMEM */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (region_intersects(nd=
_res->start, size, IORESOURCE_MEM,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
IORES_DESC_PERSISTENT_MEMORY) =3D=3D
> > REGION_INTERSECTS)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D devm_kzalloc(acp=
i_desc->dev, sizeof(*res), GFP_KERNEL);
>=20
> How about allocating this resource on the stack and then have
> devm_insert_resource handle the dynamic allocation (memdup) so we hav=
e
> one less failure point to handle in the driver.

I like the idea, but existing callers of insert_resource() allocate a
resource either statically or dynamically. =C2=A0It may be contained by=
 other
structure as well. =C2=A0So, I think devm_insert_resource() should be c=
onsistent
with insert_resource() on this regard.=C2=A0

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
