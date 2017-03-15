From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Log Exceptions and Errors as warning while
 loading extra tables
Date: Wed, 15 Mar 2017 01:16:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE4A433@SHSMSX101.ccr.corp.intel.com>
References: <20170301103653.2296-1-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE446E2@SHSMSX101.ccr.corp.intel.com>
 <0518b7f7-8d08-0071-df54-af19806883ae@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE44EB1@SHSMSX101.ccr.corp.intel.com>
 <606dcada-7c56-89a6-24a0-ac8aaa1d980e@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE49617@SHSMSX101.ccr.corp.intel.com>
 <07925741-3500-8e69-cc78-cd5ec140c7c6@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE49E37@SHSMSX101.ccr.corp.intel.com>
 <9a6d4e50-41e7-28f6-b19d-f5f989da032d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdCOBQs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 21:16:48 -0400
In-Reply-To: <9a6d4e50-41e7-28f6-b19d-f5f989da032d@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi, Hans

> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while l=
oading extra tables
>=20
> Hi,
>=20
> On 14-03-17 09:15, Zheng, Lv wrote:
> > Hi, Hans
> >
> >> From: Hans de Goede [mailto:hdegoede@redhat.com]
> >> Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning whil=
e loading extra tables
> >>
> >> Hi,
> >>
> >> On 13-03-17 10:52, Zheng, Lv wrote:
> >>> Hi, Hans
> >>>
> >>> For log level issue, is this fix useful for you?
> >>> https://github.com/acpica/acpica/pull/121/commits/a505d3942
> >>
> >> That fixes reloading already loaded tables, the problem I'm
> >> getting errors about its loading a different table with identical
> >> contents.
> >>
> >> I will look into your suggestion to do something similar to
> >> AcpiTbInstallStandardTable using AcpiTbCompareTables for the
> >> SSDT tables. I will send a new patch when I can make some time
> >> to look into this.
> >
> > I just completed a prototype here:
> > https://github.com/acpica/acpica/pull/121
> >
> > I guess the original "duplicate table check" couldn't cover static SSDT=
s.
> > Actually the duplicate table check should be a sanity check of table lo=
ad.
> > And for table install, we should have a different sanity check like:
> > https://github.com/acpica/acpica/pull/121/commits/6e825cae5e5
> > I'm not sure if this is what you want.
>=20
> This checks for having 2 table_descriptors pointing to the same table
> (address in memory). But in my case there are 2 identical copies of
> the table at 2 different addresses in memory, so this won't work.
>=20
> After looking at this a bit myself, I think fixing this is actually
> quite easy (now that you've pointed me to acpi_tb_install_standard_table(=
)
>=20
> I've come up with the attached patch to fix this. I will give this a test
> spin and then submit it officially (assuming it works).

In the pull request, there are 4 fixes:
1. add table install sanity check by detecting duplicates with table addres=
s and table type.
2. extend table load sanity check to LoadTable opcode.
3. extend table load sanity check to static loaded SSDTs - I think this sho=
uld be able to cover your case.
4. if install/load sanity checks detect duplicate tables, they return AE_AL=
READY_EXISTS and the error is silently discarded.

That's the whole story for the pull request.
I think you only checked one of them.

Thanks and best regards
Lv
