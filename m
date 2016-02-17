From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ACPI: Change NFIT driver to set PMEM type to iomem
 entry
Date: Wed, 17 Feb 2016 15:56:00 -0700
Message-ID: <1455749760.2925.291.camel@hpe.com>
References: <1454439311-23690-1-git-send-email-toshi.kani@hpe.com>
	 <1454439311-23690-4-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4ik0GRYkYdaKvu4rPC9a+Q-e93uCZMpx1W8=Cvwwdh6jw@mail.gmail.com>
	 <1455316203.2925.132.camel@hpe.com>
	 <CAPcyv4i=TpX=V6mN0zrsqvUyonKY1WkbP=wJ0QqjQtj_kiSJQw@mail.gmail.com>
	 <1455674441.2925.204.camel@hpe.com>	<1455732020.2925.255.camel@hpe.com>
	 <CAPcyv4hSJCzUdt-7SjWoT49NSSnv4nzpC=K0rq1E6DWTb6ctkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4hSJCzUdt-7SjWoT49NSSnv4nzpC=K0rq1E6DWTb6ctkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2016-02-17 at 11:34 -0800, Dan Williams wrote:
> On Wed, Feb 17, 2016 at 10:00 AM, Toshi Kani <toshi.kani@hpe.com> wro=
te:
> > On Tue, 2016-02-16 at 19:00 -0700, Toshi Kani wrote:
> > > On Fri, 2016-02-12 at 15:32 -0800, Dan Williams wrote:
> > > > On Fri, Feb 12, 2016 at 2:30 PM, Toshi Kani <toshi.kani@hpe.com=
>
> > > > wrote:
=C2=A0:
> > > Here are three options I can think of.
> > >=20
> > > 1) Set pmem type to "reserved" (This patch-set)
> > > =C2=A0- Add a new iomem_set_desc(), which sets a given type to a =
top-level
> > > entry.=C2=A0=C2=A0Change the ACPI NFIT driver to call it to set p=
mem type to
> > > "reserved" entry.
> > > =C2=A0- region_intersects() finds a pmem entry by checking top-le=
vel
> > > entries (no change).
> > >=20
> > > 2) Change region_intersects() to check children's type
> > > =C2=A0- Add a new request_region_ext(), which is an extension to
> > > request_region() to allow specifying a type of resource.=C2=A0=C2=
=A0It puts a
> > > new child entry under "reserved".=C2=A0=C2=A0Change the pmem driv=
er to call
> > > this func.
> > > =C2=A0- Change region_intersects() to check children's type for f=
inding
> > > this child pmem entry.
> > >=20
> > > 3) Pmem driver to call insert_resource()
> > > =C2=A0- Change the pmem driver to call insert_resource(), which p=
uts a new
> > > pmem entry as the parent of "reserved".
> > > =C2=A0- region_intersects() finds a pmem entry by checking top-le=
vel
> > > entries (no change).
> > > =C2=A0- Add a new release_resource_self(), which releases a given=
 entry
> > > and keeps its children if any.=C2=A0=C2=A0Change the pmem driver =
to call it for
> > > release.
> >=20
> > Thinking=C2=A0further,=C2=A03)=C2=A0needs=C2=A0to=C2=A0be=C2=A0modi=
fied=C2=A0as=C2=A0follows.=C2=A0=C2=A0insert_resource(
> > ) should only be allowed for producers of resource (ex. nfit), not
> > consumers (ex. pmem).=C2=A0=C2=A0It also needs to export insert_res=
ource().
> >=20
> > 3) NFIT driver to call insert_resource()
> > =C2=A0- Change the ACPI nfit driver to call insert_resource() when =
a target
> > range is not marked as PMEM (i.e. "reserved") or not present in iom=
em.
> > =C2=A0This puts a new PMEM entry as the parent of "reserved".
> > =C2=A0- region_intersects() finds a pmem entry by checking top-leve=
l entries
> > (no change).
> > =C2=A0- Add a new release_resource_self(), which releases a given e=
ntry and
> > keeps its children if any.=C2=A0=C2=A0Change the nfit driver to cal=
l it for
> > release.
> >=20
> > > This patch-set implements 1).=C2=A0=C2=A0The pmem type is set to =
"reserved" for
> > > its life-cycle.=C2=A0=C2=A0This option is simplest.
> > >=20
> > > For 2), the changes to region_intersects() may be too complex for
> > > maintenance.
> >=20
> > I should have said "region_intersects() may be overly complicated f=
or
> > this purpose and maintenance".
> >=20
> > > Here are a few examples when region_intersects() is called
> > > with addr [1-10] where iomem has entry P and its children.
> > >=20
> > > Case A: P is fully covered by children C1 & C2.=C2=A0=C2=A0region=
_intersects()
> > > ignores P's type, but checks C1 and C2's.
> > >=20
> > > =C2=A0 P [1-10] + C1 [1-5]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+ C2 [6-10]
> > >=20
> > > Case B: C2 is fully covered by C3, but P is not.=C2=A0=C2=A0regio=
n_intersects()
> > > ignores C2's type, but checks P, C1, C3's.
> > >=20
> > > =C2=A0 P [1-10] + C1 [1-2]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+ C2 [6-10] + C3 [6-10]
> > >=20
> > > I think region_intersects() will need to construct a flat table f=
rom
> > > the tree while making recursive calls to walk thru all children.
> > >=20
> > > 3) is similar to 2), but avoids the changes to region_intersects(=
)
> > > since insert_resource() inserts a new entry as the parent to
> > > "reserved".
> >=20
> > 3) is actually similar to 1) as both options change the producer si=
de.
> >=20
> > > =C2=A0However, a new interface is necessary to put "reserved" bac=
k to top-
> > > level when releasing the added entry.
> > >=20
> > > My recommendation is go with either 1) or 3).=C2=A0=C2=A0What do =
you think?
> >=20
> > I think we should modify the producer side, so 1) or 3) are still m=
y
> > recommendation.
> >=20
>=20
> I think 3 is the most promising option.=C2=A0=C2=A0It aligns the acpi=
/nfit
> driver closer with the acpi/pci_root driver that is also doing
> insert_resource() for each root bridge, and removing those resources
> when the bridge is disabled/removed.
>=20
> I'd still want to maintain the ability of nfit to be built as a
> module, so we would need to split the resource registration into a
> separate built-in object file from nfit.ko.

Sounds good. =C2=A0I will implement 3), and add an ACPI built-in wrappe=
r
function to call insert_resource().

Thanks!
-Toshi
