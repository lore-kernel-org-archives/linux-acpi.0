From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 0/7] ACPICA: Tables: Cleanup table sanity checks
Date: Thu, 16 Mar 2017 06:50:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE4AE59@SHSMSX101.ccr.corp.intel.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
 <77ba7bff-d1e8-e430-c422-961eb07ff296@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE4AD50@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdCPGuS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 02:50:18 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE4AD50@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Hans de Goede <hdegoede@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Box, David E" <david.e.box@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lv Zheng <zetalog@gmail.com>, "devel@acpica.org" <devel@acpica.org>

Hi,

> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> Subject: Re: [Devel] [RFC PATCH 0/7] ACPICA: Tables: Cleanup table sanity=
 checks
>=20
> Hi,
>=20
> > From: Hans de Goede [mailto:hdegoede@redhat.com]
> > Subject: Re: [RFC PATCH 0/7] ACPICA: Tables: Cleanup table sanity check=
s
> >
> > Hi,
> >
> > On 15-03-17 07:36, Lv Zheng wrote:
> > > Originally AML table sanity check is only done for Load opcode, as
> > > acpi_tb_compare_tables() is only invoked in
> > > acpi_tb_install_standard_table(). While LoadTable opcode cannot be co=
vered
> > > as it directly invokes acpi_tb_load_table() without invoking
> > > acpi_tb_install_standard_table(). Furthermore, standard table load al=
so
> > > cannot be covered as acpi_ns_load_table() is invoked instead of
> > > acpi_tb_install_standard_table() and acpi_tb_load_table().
> > >
> > > So it becomes a problem if a duplicate table is in RSDT/XSDT, there i=
s no
> > > such check implemented for static load tables and LoadTable opcode.
> > >
> > > This patchset combines code paths (in return reduces some redundant c=
ode
> > > blocks and enhances checks/locks) so that duplicate table detection c=
an be
> > > applied to all cases.
> >
> > I can confirm that this series fixes the errors I was seeing on my
> > GPD win machine.
>=20
> Ok, thanks for the test and the report.
>=20
> > Note as explained in my reply to Robert I believe that
> > the last patch from the series can be dropped:
> >
> > "On 15-03-17 04:05, Moore, Robert wrote:
> >  > And I would suppose a refinement would be:
> >  >
> >  > Compare headers
> >  > If headers match, compare entire tables.
> >
> > The existing memcmp already does that since the header is in the
> > front, and memcmp will stop on the first difference, so there
> > is no need to change anything."
> >
> > As Robert mentions we really a should compare the entire table
> > if the checksums match since an 8 bit checksum is really weak and
> > if we want to do that a simple memcmp will suffice as that will
> > already exit directly if the checksum mismatches as the checksum
> > is before the actual data.
>=20
> Maybe the suggestion is made on the previous fact.
> The previous design prevents such duplicate tables from being
> installed. It surely is able to prevent same table from being
> installed twice.
> Under the previous design, we should do the duplicate table
> detection in acpi_tb_verify_temp_table() which is exact the API used
> before the table is installed to the global table list.
> But there is a special logic for table install:
> Linux can only use limited slots to map ACPI tables.
> Thus most of the time, we can only map the table header.
>=20
> The series now follows your idea, split sanity checks into 2 levels:
> 1. for table install, only check "address" and "memory types"
> 2. for table load, check "table content" to detect duplicate tables
> And since the table load doesn't have similar restriction, we seem
> to be able to map the whole table to compare.
>=20
> And I noticed comments in acpi_tb_compare_tables(). It looks like
> comparing the Whole table rather than comparing the table header is
> a design decision made several years ago due to some reasons.
>=20
> As such:
> 1. With new design, we are able to compare the whole table
> 2. Comparing whole table rather than comparing table header looks
>    like a determined design choice
> I made it the last patch and a separate one so that we can drop
> it at any time.

Dropped and the pull request is updated:
https://github.com/acpica/acpica/pull/121
If everything works smoothly, you'll see it fixed by next ACPICA release.

Thanks
Lv

> > >
> > > Lv Zheng (7):
> > >   ACPICA: Tables: Cleanup table handler invokers
> > >   ACPICA: Tables: Add sanity check for load_table opcode
> > >   ACPICA: Tables: Add sanity check for table install
> > >   ACPICA: Tables: Fix an unwanted exception for table reloading
> > >   ACPICA: Tables: Enable acpi_ut_is_aml_table() for all ACPICA module=
s
> > >   ACPICA: Tables: Add sanity check for static table load
> > >   ACPICA: Tables: Change table comparison using table header for stat=
ic
> > >     load tables
> > >
> > >  drivers/acpi/acpica/actables.h |   7 +-
> > >  drivers/acpi/acpica/acutils.h  |   4 +-
> > >  drivers/acpi/acpica/exconfig.c |   2 +-
> > >  drivers/acpi/acpica/nsload.c   |  18 ---
> > >  drivers/acpi/acpica/tbdata.c   | 288 +++++++++++++++++++++++++++++++=
+++++-----
> > >  drivers/acpi/acpica/tbinstal.c | 197 ++++++----------------------
> > >  drivers/acpi/acpica/tbxfload.c |  46 +------
> > >  drivers/acpi/acpica/utmisc.c   |  27 ++--
> > >  include/acpi/actbl.h           |   1 +
> > >  9 files changed, 325 insertions(+), 265 deletions(-)
> > >
> _______________________________________________
> Devel mailing list
> Devel@acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
