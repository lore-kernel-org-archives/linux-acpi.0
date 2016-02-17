From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ACPI: Change NFIT driver to set PMEM type to iomem
 entry
Date: Tue, 16 Feb 2016 19:00:41 -0700
Message-ID: <1455674441.2925.204.camel@hpe.com>
References: <1454439311-23690-1-git-send-email-toshi.kani@hpe.com>
	 <1454439311-23690-4-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4ik0GRYkYdaKvu4rPC9a+Q-e93uCZMpx1W8=Cvwwdh6jw@mail.gmail.com>
	 <1455316203.2925.132.camel@hpe.com>
	 <CAPcyv4i=TpX=V6mN0zrsqvUyonKY1WkbP=wJ0QqjQtj_kiSJQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4i=TpX=V6mN0zrsqvUyonKY1WkbP=wJ0QqjQtj_kiSJQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2016-02-12 at 15:32 -0800, Dan Williams wrote:
> On Fri, Feb 12, 2016 at 2:30 PM, Toshi Kani <toshi.kani@hpe.com> wrot=
e:
> > On Fri, 2016-02-12 at 11:41 -0800, Dan Williams wrote:
> > > On Tue, Feb 2, 2016 at 10:55 AM, Toshi Kani <toshi.kani@hpe.com> =
wro
=C2=A0:
> > > Hmm, if we set the type on driver load, should we clear the type =
on
> > > driver unload?
> >=20
> > I think this type update should stay for the life-cycle of this iom=
em
> > entry itself since this range is PMEM even after the driver is
> > unloaded.=C2=A0=C2=A0This is an extension of the boot-time iomem ta=
ble
> > initialization from e820/EFI, which allows ACPI to set a correct
> > type.=C2=A0=C2=A0This is independent from driver's resource allocat=
ions.
> >=20
> > > Actually it might be more straightforward to specify a type at
> > > request_region() time.=C2=A0=C2=A0That way it gets released at
> > > release_region(). =C2=A0We're already setting a resource name at
> > > request_region time, adding a type annotation at the time seems
> > > appropriate.
> >=20
> > I first considered simply setting "namespaceX.X" as PMEM.=C2=A0=C2=A0=
However,
> > region_intersects() and its friends only check the top-level entrie=
s,
> > not their children, of the iomem table.=C2=A0=C2=A0And I think a ch=
ild should
> > have the same type as the parent as I fixed it in patch 1/3.
>=20
> Did we investigate updating region_intersects() to check children?
> When a child sub-divides a region with different types it may be the
> wrong answer to check the parent.=C2=A0=C2=A0Is there a problem with =
moving
> checking to the child?

Here are three options I can think of.

1) Set pmem type to "reserved" (This patch-set)
=C2=A0- Add a new iomem_set_desc(), which sets a given type to a top-le=
vel
entry. =C2=A0Change the ACPI NFIT driver to call it to set pmem type to
"reserved" entry.
=C2=A0- region_intersects() finds a pmem entry by checking top-level en=
tries (no
change).

2) Change region_intersects() to check children's type
=C2=A0- Add a new request_region_ext(), which is an extension to
request_region() to allow specifying a type of resource. =C2=A0It puts =
a new
child entry under "reserved". =C2=A0Change the pmem driver to call this=
 func.
=C2=A0- Change region_intersects() to check children's type for finding=
 this
child pmem entry.

3) Pmem driver to call insert_resource()
=C2=A0- Change the pmem driver to call insert_resource(), which puts a =
new pmem
entry as the parent of "reserved".
=C2=A0- region_intersects() finds a pmem entry by checking top-level en=
tries (no
change).
=C2=A0- Add a new release_resource_self(), which releases a given entry=
 and
keeps its children if any. =C2=A0Change the pmem driver to call it for =
release.


This patch-set implements 1). =C2=A0The pmem type is set to "reserved" =
for its
life-cycle. =C2=A0This option is simplest.

=46or 2), the changes to region_intersects() may be too complex for
maintenance. =C2=A0Here are a few examples when region_intersects() is =
called
with addr [1-10] where iomem has entry P and its children.

Case A: P is fully covered by children C1 & C2. =C2=A0region_intersects=
()
ignores P's type, but checks C1 and C2's.
=C2=A0=C2=A0
=C2=A0 P [1-10] + C1 [1-5]
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ C2 [6-10]

Case B: C2 is fully covered by C3, but P is not. =C2=A0region_intersect=
s()
ignores C2's type, but checks P, C1, C3's.

=C2=A0 P [1-10] + C1 [1-2]
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ C2 [6-10] + C3 [6-10]

I think region_intersects() will need to construct a flat table from th=
e
tree while making recursive calls to walk thru all children.

3) is similar to 2), but avoids the changes to region_intersects() sinc=
e
insert_resource() inserts a new entry as the parent to "reserved".
=C2=A0However, a new interface is necessary to put "reserved" back to t=
op-level
when releasing the added entry.

My recommendation is go with either 1) or 3). =C2=A0What do you think?

Thanks,
-Toshi
