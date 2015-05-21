From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v3 02/21] libnd, nfit: initial libnd infrastructure and
 NFIT support
Date: Thu, 21 May 2015 13:44:18 -0600
Message-ID: <1432237458.29840.17.camel@misato.fc.hp.com>
References: <20150520205536.32249.89779.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <20150520205621.32249.39424.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <1432216514.26714.4.camel@misato.fc.hp.com>
	 <CAPcyv4ijJeBjX-vvMprDYwQx8PnPD3P5UJR2A-3wqNdd63p7Bg@mail.gmail.com>
	 <1432229114.28126.25.camel@misato.fc.hp.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE7C0@ORSMSX112.amr.corp.intel.com>
	 <1432231297.28704.8.camel@misato.fc.hp.com>
	 <CAPcyv4gjh_2Uy=gLN793=PTWh4X5e=A6tbtVTvaeLxEoHjxw0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:38347 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbbEUUDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 16:03:42 -0400
In-Reply-To: <CAPcyv4gjh_2Uy=gLN793=PTWh4X5e=A6tbtVTvaeLxEoHjxw0w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>

On Thu, 2015-05-21 at 12:06 -0700, Dan Williams wrote:
> On Thu, May 21, 2015 at 11:01 AM, Toshi Kani <toshi.kani@hp.com> wrot=
e:
> > On Thu, 2015-05-21 at 17:49 +0000, Moore, Robert wrote:
> >> What ACPICA has done here is to define these values consistently w=
ith the ToUUID ASL macro:
> >>
> >>
> >> Byte encoding of UUID/GUID strings into ACPI Buffer objects (use T=
oUUID from ASL):
> >>
> >>    Input UUID/GUID String format : aabbccdd-eeff-gghh-iijj-kkllmmn=
noopp
> >>      Expected output ACPI buffer : dd,cc,bb,aa, ff,ee, hh,gg, ii,j=
j, kk,ll,mm,nn,oo,pp
> >>
> >
> > I do not see any issue in this conversion, which is consistent with
> > ToUUID defined in ACPI spec.
> >
> > My point is that the string format of GUID is endian-neutral.  Wiki
> > pages and EFI spec agree on it.  EFI 2.5 spec, Table 225 (sorry not
> > Table 212, which is v2.4), is also clear about how String and Buffe=
r are
> > related with actual values of GUID.
>=20
> I think the critical point from the UEFI spec is the "It should also
> be noted that TimeLow, TimeMid, TimeHighAndVersion fields in the EFI
> are encoded as little endian".  That would imply the byte encoding
> of...
>=20
> { 0x92F701F6, 0x13B4, 0x405D, 0x91, 0x0B, 0x29, 0x93, 0x67, 0xE8, 0x2=
3, 0x4C }
>=20
> ...should be:
>=20
> { f6,01,f7,92,b4,13,5d,40,91,0b,29,93,67,e8,23,4c }

The above NFIT GUID as data values means:

EFI_GUID(0x92F701F6, 0x13B4, 0x405D, 0x91, 0x0B, 0x29, 0x93, 0x67, 0xE8=
,
0x23, 0x4C)

> Which implies the text conversion should be:
>=20
> "92f701f6-13b4-405d-910b-299367e8234c"

Nope.

EFI 2.5 spec, Appendix A "GUID and Time Formats" defines that:
(NOTE, I simplified the table 225 to fit in this email)
=3D=3D
This specification also defines a standard text representation of the
GUID. This format is also sometimes called the =E2=80=9Cregistry format=
=E2=80=9D. It
consists of 36 characters, as follows:

aabbccdd-eeff-gghh-iijj-kkllmmnnoopp
 :

Table 225. Text representation relationships
String	Offset In Buffer   EFI_GUID
aa	3                  Data1[24:31]
bb      2                  Data1[16:23]
cc      1                  Data1[8:15]
dd      0                  Data1[0:7]
 :
=3D=3D=3D

Therefore:

aa =3D Data1[21:31] =3D 92
bb =3D Data1[16:23] =3D F7
cc =3D Data1[8:15]  =3D 01
dd =3D Data1[0:7]   =3D F6

> ...not
>=20
> > +#define UUID_CONTROL_REGION             "f601f792-b413-5d40-910b-2=
99367e8234c"

Hence, the above string is correct.

ToUUD then stores the given string to Buffer according to "Offset In
Buffer" in the above table.

Another example, EFI 2.5 spec defines GPT partition GUID:

=3D=3D=3D
Table 19. Defined GPT Partition Entry - Partition Type GUIDs
EFI System Partition C12A7328-F81F-11D2-BA4B-00A0C93EC93B
=3D=3D=3D

The kernel defines it as:
#define PARTITION_SYSTEM_GUID \
    EFI_GUID( 0xC12A7328, 0xF81F, 0x11d2, \
              0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B)

Thanks,
-Toshi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
