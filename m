From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 4/5] ACPI video: support reversed _BCL method
Date: Wed, 11 Mar 2009 09:42:55 +0800
Message-ID: <1236735775.2820.160.camel@rzhang-dt>
References: <1236672211.2820.122.camel@rzhang-dt>
	 <20090310171136.GD2527@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55967 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658AbZCKBmB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 21:42:01 -0400
In-Reply-To: <20090310171136.GD2527@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, 2009-03-11 at 01:11 +0800, Matthew Garrett wrote:
> On Tue, Mar 10, 2009 at 04:03:31PM +0800, Zhang Rui wrote:
> > sort the _BCL packge in case it's reversed.
>=20
> What code actually uses this? A later patch seems to check it in the=20
> indexed case, but I can't find a reference to using it in the=20
> non-indexed case.
>=20
It's just used in the indexed case.

In bug http://bugzilla.kernel.org/show_bug.cgi?id=3D12249

                 Name (PCTG, Package (0x10)
                {
                    0x64,
                    0x5A,
                    0x55,
                    0x50,
                    0x4B,
                    0x46,
                    0x41,
                    0x3C,
                    0x37,
                    0x32,
                    0x2D,
                    0x28,
                    0x23,
                    0x1E,
                    0x19,
                    0x14
                })

                    Method (_BCL, 0, NotSerialized)
                    {
                        Return (PCTG)
                    }
                    Method (_BQC, 0, NotSerialized)
                    {
                        Return (LBTN)
                    }

device->brightness->levels[] =3D {0x64, 0x5A, 0x14, 0x19,..., 0x5a, 0x6=
4};

The index value returned by _BQC is the index in the PCTG package.
if the _BCL package is in a reversed order, we can not use this index t=
o
get the value in =EF=BB=BFdevice->brightness->levels[].
=46or example, if the current brightness is 0x64, _BQC returns 0 in thi=
s
case, but we can not translate this to value 0x14, we need a flag to
tell us that _BCL is reversed.

But in the non-indexed case, _BQC always returns a percentage that can
be used directly by ACPI video driver, i.e. we don't need to parse
device->brightness->levels to get the real value. so we don't need to
check the =EF=BB=BFdevice->brightness->flags._BCL_reversed bit.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
