From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
 comply ACPI 6.1
Date: Tue, 01 Mar 2016 12:18:53 -0700
Message-ID: <1456859933.15454.83.camel@hpe.com>
References: <1456178130-26468-1-git-send-email-toshi.kani@hpe.com>
	 <1456178130-26468-2-git-send-email-toshi.kani@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
	 <1456850284.15454.23.camel@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
	 <1456853819.15454.45.camel@hpe.com>
	 <CAPcyv4hS44abMCs1sxdLW0YgMjP33Td0LbEWhXi9jqJ_ARU7CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4hS44abMCs1sxdLW0YgMjP33Td0LbEWhXi9jqJ_ARU7CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, "elliott@hpe.com" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2016-03-01 at 10:14 -0800, Dan Williams wrote:
> On Tue, Mar 1, 2016 at 9:36 AM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
> > On Tue, 2016-03-01 at 16:03 +0000, Moore, Robert wrote:
> > > We have a bunch of macros in include/acmacros.h -- like this:
> > >=20
> > > ACPI_MOVE_16_TO_16(d, s)
> >=20
> > There is a problem in using the ACPICA byte-swap macros.=C2=A0=C2=A0=
ACPI is
> > little-
> > endian arch, so the macros are set to perform byte-swappings when t=
he
> > CPU
> > arch is big-endian.=C2=A0=C2=A0This case, however, is the other way=
 around.=C2=A0=C2=A0The
> > fields in question are defined & stored as arrays of bytes.=C2=A0=C2=
=A0If you
> > treat
> > them as multi-bytes numeric values, then you need to byte-swap them
> > when
> > the CPU arch is little-endian because arrays of bytes have the same
> > addressing as big-endian.
> >=20
> > Another issue is that it is not clear who needs to perform the byte=
-
> > swapping among ACPICA and drivers.=C2=A0=C2=A0If ACPICA, drivers mu=
st agree that
> > these fields are always treated as multi-bytes numeric values despi=
te
> > of
> > the spec.=C2=A0=C2=A0If drivers, we need to make sure that only a s=
ingle driver
> > performs this byte-swapping one time as ACPI tables are global
> > structures.
> >=20
> > I think it is much clearer to define the structure according to the
> > ACPI
> > spec.
>=20
> I think the "ACPI tables are little-endian" assumption is pervasive
> throughout the implementation.
>=20
> Toshi, it seems all we need is conversions like:
>=20
> - sprintf(buf, "%#x\n", dcr->vendor_id);
> + sprintf(buf, "%#x\n", le16_to_cpu(dcr->vendor_id));
>=20
> ...for the values exported to userspace through sysfs, but otherwise
> leave the base table definitions as is.=C2=A0=C2=A0Will this suffice?

Yes, I am OK to go with this option to get it done.

We still need to add new fields into the structure. =C2=A0Is it OK to m=
ake this
change? =C2=A0If not, we will need to have a local structure to define =
the new
fields...

Thanks,
-Toshi
