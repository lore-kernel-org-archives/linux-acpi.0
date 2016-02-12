From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ACPI: Change NFIT driver to set PMEM type to iomem
 entry
Date: Fri, 12 Feb 2016 15:30:03 -0700
Message-ID: <1455316203.2925.132.camel@hpe.com>
References: <1454439311-23690-1-git-send-email-toshi.kani@hpe.com>
	 <1454439311-23690-4-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4ik0GRYkYdaKvu4rPC9a+Q-e93uCZMpx1W8=Cvwwdh6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4ik0GRYkYdaKvu4rPC9a+Q-e93uCZMpx1W8=Cvwwdh6jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2016-02-12 at 11:41 -0800, Dan Williams wrote:
> On Tue, Feb 2, 2016 at 10:55 AM, Toshi Kani <toshi.kani@hpe.com> wrot=
e:
> > Change acpi_nfit_register_region() to call iomem_set_desc() with
> > IORES_DESC_PERSISTENT_MEMORY for NFIT_SPA_PM ranges found in ACPI
> > NFIT table.
> >=20
> > When FW sets E820_PMEM in e820 and EFI_PERSISTENT_MEMORY in EFI,
> > this code simply sets PMEM type again to "Persistent Memory" entrie=
s
> > in the iomem table.=C2=A0=C2=A0When FW sets reserved type for persi=
stent
> > memory ranges, it sets PMEM type to "reserved" entries covering
> > PMEM ranges.
> >=20
> > This allows the EINJ driver, which calls region_intersects() with
> > IORES_DESC_PERSISTENT_MEMORY to check persistent memory ranges,
> > to work continuously even if FW sets reserved type to persistent
> > memory in e820 and EFI.
> >=20
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > =C2=A0drivers/acpi/nfit.c |=C2=A0=C2=A0=C2=A0=C2=A06 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> > index ad6d8c6..add04f0 100644
> > --- a/drivers/acpi/nfit.c
> > +++ b/drivers/acpi/nfit.c
> > @@ -1781,6 +1781,12 @@ static int acpi_nfit_register_region(struct
> > acpi_nfit_desc *acpi_desc,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nvdimm_bus =3D acpi=
_desc->nvdimm_bus;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (nfit_spa_type(s=
pa) =3D=3D NFIT_SPA_PM) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rc =3D iomem_set_desc(spa->address, spa->length=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0IORES_DESC_PERSISTENT_MEMORY);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev_dbg(acpi_desc->dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"error setting iomem de=
sc: %d\n", rc);
> > +
>=20
> Hmm, if we set the type on driver load, should we clear the type on
> driver unload?

I think this type update should stay for the life-cycle of this iomem e=
ntry
itself since this range is PMEM even after the driver is unloaded. =C2=A0=
This is
an extension of the boot-time iomem table initialization from e820/EFI,
which allows ACPI to set a correct type. =C2=A0This is independent from=
 driver's
resource allocations.

> Actually it might be more straightforward to specify a type at
> request_region() time.=C2=A0=C2=A0That way it gets released at releas=
e_region().
> We're already setting a resource name at request_region time, adding =
a
> type annotation at the time seems appropriate.

I first considered simply setting "namespaceX.X" as PMEM. =C2=A0However=
,
region_intersects() and its friends only check the top-level entries, n=
ot
their children, of the iomem table. =C2=A0And I think a child should ha=
ve the
same type as the parent as I fixed it in patch 1/3.

Thanks,
-Toshi
