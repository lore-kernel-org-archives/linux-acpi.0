From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ACPI: Change NFIT driver to set PMEM type to iomem
 entry
Date: Wed, 17 Feb 2016 11:00:20 -0700
Message-ID: <1455732020.2925.255.camel@hpe.com>
References: <1454439311-23690-1-git-send-email-toshi.kani@hpe.com>
	 <1454439311-23690-4-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4ik0GRYkYdaKvu4rPC9a+Q-e93uCZMpx1W8=Cvwwdh6jw@mail.gmail.com>
	 <1455316203.2925.132.camel@hpe.com>
	 <CAPcyv4i=TpX=V6mN0zrsqvUyonKY1WkbP=wJ0QqjQtj_kiSJQw@mail.gmail.com>
	 <1455674441.2925.204.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:43220 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQRHX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 12:07:23 -0500
In-Reply-To: <1455674441.2925.204.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>

On Tue, 2016-02-16 at 19:00 -0700, Toshi Kani wrote:
> On Fri, 2016-02-12 at 15:32 -0800, Dan Williams wrote:
> > On Fri, Feb 12, 2016 at 2:30 PM, Toshi Kani <toshi.kani@hpe.com> wr=
ote:
> > > On Fri, 2016-02-12 at 11:41 -0800, Dan Williams wrote:
> > > > On Tue, Feb 2, 2016 at 10:55 AM, Toshi Kani <toshi.kani@hpe.com=
>
> > > > wro
> =C2=A0:
> > > > Hmm, if we set the type on driver load, should we clear the typ=
e on
> > > > driver unload?
> > >=20
> > > I think this type update should stay for the life-cycle of this i=
omem
> > > entry itself since this range is PMEM even after the driver is
> > > unloaded.=C2=A0=C2=A0This is an extension of the boot-time iomem =
table
> > > initialization from e820/EFI, which allows ACPI to set a correct
> > > type.=C2=A0=C2=A0This is independent from driver's resource alloc=
ations.
> > >=20
> > > > Actually it might be more straightforward to specify a type at
> > > > request_region() time.=C2=A0=C2=A0That way it gets released at
> > > > release_region(). =C2=A0We're already setting a resource name a=
t
> > > > request_region time, adding a type annotation at the time seems
> > > > appropriate.
> > >=20
> > > I first considered simply setting "namespaceX.X" as PMEM.=C2=A0=C2=
=A0However,
> > > region_intersects() and its friends only check the top-level entr=
ies,
> > > not their children, of the iomem table.=C2=A0=C2=A0And I think a =
child should
> > > have the same type as the parent as I fixed it in patch 1/3.
> >=20
> > Did we investigate updating region_intersects() to check children?
> > When a child sub-divides a region with different types it may be th=
e
> > wrong answer to check the parent.=C2=A0=C2=A0Is there a problem wit=
h moving
> > checking to the child?
>=20
> Here are three options I can think of.
>=20
> 1) Set pmem type to "reserved" (This patch-set)
> =C2=A0- Add a new iomem_set_desc(), which sets a given type to a top-=
level
> entry. =C2=A0Change the ACPI NFIT driver to call it to set pmem type =
to
> "reserved" entry.
> =C2=A0- region_intersects() finds a pmem entry by checking top-level =
entries
> (no change).
>=20
> 2) Change region_intersects() to check children's type
> =C2=A0- Add a new request_region_ext(), which is an extension to
> request_region() to allow specifying a type of resource. =C2=A0It put=
s a new
> child entry under "reserved". =C2=A0Change the pmem driver to call th=
is func.
> =C2=A0- Change region_intersects() to check children's type for findi=
ng this
> child pmem entry.
>=20
> 3) Pmem driver to call insert_resource()
> =C2=A0- Change the pmem driver to call insert_resource(), which puts =
a new
> pmem entry as the parent of "reserved".
> =C2=A0- region_intersects() finds a pmem entry by checking top-level =
entries
> (no change).
> =C2=A0- Add a new release_resource_self(), which releases a given ent=
ry and
> keeps its children if any. =C2=A0Change the pmem driver to call it fo=
r
> release.

Thinking further, 3) needs to be modified as follows. =C2=A0insert_reso=
urce()
should only be allowed for producers of resource (ex. nfit), not consum=
ers
(ex. pmem). =C2=A0It also needs to export insert_resource().

3) NFIT driver to call insert_resource()
=C2=A0- Change the ACPI nfit driver to call insert_resource() when a ta=
rget
range is not marked as PMEM (i.e. "reserved") or not present in iomem.
=C2=A0This puts a new PMEM entry as the parent of "reserved".
=C2=A0- region_intersects() finds a pmem entry by checking top-level en=
tries (no
change).
=C2=A0- Add a new release_resource_self(), which releases a given entry=
 and
keeps its children if any. =C2=A0Change the nfit driver to call it for =
release.

> This patch-set implements 1). =C2=A0The pmem type is set to "reserved=
" for its
> life-cycle. =C2=A0This option is simplest.
>=20
> For 2), the changes to region_intersects() may be too complex for
> maintenance. =C2=A0

I should have said "region_intersects() may be overly complicated for t=
his
purpose and maintenance".

> Here are a few examples when region_intersects() is called
> with addr [1-10] where iomem has entry P and its children.
>=20
> Case A: P is fully covered by children C1 & C2. =C2=A0region_intersec=
ts()
> ignores P's type, but checks C1 and C2's.
> =C2=A0=C2=A0
> =C2=A0 P [1-10] + C1 [1-5]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ C2 [6-10]
>=20
> Case B: C2 is fully covered by C3, but P is not. =C2=A0region_interse=
cts()
> ignores C2's type, but checks P, C1, C3's.
>=20
> =C2=A0 P [1-10] + C1 [1-2]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ C2 [6-10] + C3 [6-10]
>=20
> I think region_intersects() will need to construct a flat table from =
the
> tree while making recursive calls to walk thru all children.
>=20
> 3) is similar to 2), but avoids the changes to region_intersects() si=
nce
> insert_resource() inserts a new entry as the parent to "reserved".

3) is actually similar to 1) as both options change the producer side.

> =C2=A0However, a new interface is necessary to put "reserved" back to=
 top-
> level when releasing the added entry.
>=20
> My recommendation is go with either 1) or 3). =C2=A0What do you think=
?

I think we should modify the producer side, so 1) or 3) are still my
recommendation.

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
