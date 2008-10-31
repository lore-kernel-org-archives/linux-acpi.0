From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 5/6] ACPI: set waking vector in inactive facs table
Date: Fri, 31 Oct 2008 14:07:20 +0800
Message-ID: <1225433240.2665.32.camel@rzhang-dt>
References: <1223885434.2735.188.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D830858031949AF@orsmsx503.amr.corp.intel.com>
	 <1223946513.2735.219.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803277E3F@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16656 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYJaGIW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Oct 2008 02:08:22 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803277E3F@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>

On Thu, 2008-10-16 at 03:41 +0800, Moore, Robert wrote:
> I'll go ahead and implement the following:
>=20
> http://www.acpica.org/bugzilla/show_bug.cgi?id=3D731
>=20
>=20
> It looks like we have an issue on some machines where both the FIRMWA=
RE_CTRL and X_FIRMWARE_CTRL fields in the FADT are valid, but contain d=
ifferent addresses. In this case, we don't really know which one is the=
 real FACS.
>=20
> Currently, if the X_FIRMWARE_CTRL field is valid, we use it exclusive=
ly (as per the ACPI spec.) This doesn=E2=80=99t work when the =E2=80=9C=
real=E2=80=9D FACS is actually the one pointed to by the FIRMWARE_CTRL =
field.
>=20
> The proposed change for the case where both FACS pointers are valid i=
s to write the firmware waking vector value to both FACS tables.
>=20
yes, that's the problem I want to fix in this patch.
another problem is the global lock.
we may get an invalid global lock if the wrong FACS is used, right?
but currently we don't know which FACS is actually used by BIOS/Windows=
,
this patch could only fix the waking vector issue,

> We would have something like this:
>=20
> Set wake vector using FACS pointed to by X_FIRMWARE_CTRL
> If (FIRMWARE_CTRL is non-zero) AND (FIRMWARE_CTRL !=3D X_FIRMWARE_CTR=
L)
>     Set wake vector using FACS pointed to by FIRMWARE_CTRL
>=20
Yes. this could fix the problem too, but much more complex.
As we need to add both of the FACS tables to the
acpi_gbl_root_table_list, while the index of FACS table is hard coded
there, i.e. ACPI_TABLE_INDEX_FACS.

Bob, do you think we should fix the multiple FACS issue in some other
way, or just follow the proposal in this patch?

thanks,
rui
>=20
>=20
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Monday, October 13, 2008 6:09 PM
> >To: Moore, Robert
> >Cc: Len Brown; linux-acpi; Rafael J. Wysocki
> >Subject: RE: [PATCH 5/6] ACPI: set waking vector in inactive facs ta=
ble
> >
> >On Mon, 2008-10-13 at 11:46 -0600, Moore, Robert wrote:
> >> So, is this the bottom line of the hwsleep patch:
> >>
> >> If there is a second FACS in the system (pointed to by the unused =
RSDT),
> >then set the firmware waking vectors in BOTH FACS tables?
> >yes.
> >
> >there is another way to fix this issue.
> >as FADT1 exports two different FACS tables, setting the waking vecto=
rs
> >in both of them =EF=BB=BF(pointed to by fadt->facs and fadt->Xfadt) =
also works.
> >
> >I don't know which way is better.
> >
> >thanks,
> >rui
> >>
> >>
> >>
> >> >-----Original Message-----
> >> >From: Zhang, Rui
> >> >Sent: Monday, October 13, 2008 1:11 AM
> >> >To: Len Brown
> >> >Cc: linux-acpi; Moore, Robert; Rafael J. Wysocki; Zhang, Rui
> >> >Subject: [PATCH 5/6] ACPI: set waking vector in inactive facs tab=
le
> >> >
> >> >
> >> >RSDT and XSDT may export different FACS tables.
> >> >Some of the BIOSes only checks one of them when resuming.
> >> >And Linux reboots instead of resuming because BIOS can't find
> >> >the waking vector.
> >> >For example,
> >> >=EF=BB=BFI have a platform which suspends well, but always reboot=
s instead of
> >> >resuming when pressing the power button.
> >> >I found that there are two FACS tables on this platform,
> >> >XSDT-->FADT1-->Xfacs-->FACS1
> >> >        |----->facs-|
> >> >                    |->FACS2
> >> >RSDT-->FADT2-->facs-|
> >> >Linux uses XSDT on this platform and sets the waking vector in FA=
CS1
> >> >when suspending.
> >> >But it seems that the BIOS only cares for the waking vector in FA=
CS2,
> >> >thus it reboots when resuming because the waking vector is not se=
t at
> >all.
> >> >
> >> >Set the waking vector in inactive FACS table in this patch.
> >> >
> >> >Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >> >---
> >> > drivers/acpi/hardware/hwsleep.c |   20 ++++++++++++++++++++
> >> > drivers/acpi/tables/tbfadt.c    |    6 ++++--
> >> > 2 files changed, 24 insertions(+), 2 deletions(-)
> >> >
> >> >Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> >> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> >> >+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> >> >@@ -65,6 +65,7 @@ acpi_set_firmware_waking_vector(acpi_phy
> >> > {
> >> >        struct acpi_table_facs *facs;
> >> >        acpi_status status;
> >> >+       u32 table_index;
> >> >
> >> >        ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
> >> >
> >> >@@ -92,6 +93,25 @@ acpi_set_firmware_waking_vector(acpi_phy
> >> >                facs->xfirmware_waking_vector =3D physical_addres=
s;
> >> >        }
> >> >
> >> >+       /* set the firmware vector in the inactive facs table */
> >> >+       for (table_index =3D 0, facs =3D NULL; ; table_index++) {
> >> >+               status =3D acpi_get_inactive_table_by_index(table=
_index,
> >> >+                               ACPI_CAST_INDIRECT_PTR(struct
> >> >acpi_table_header,
> >> >+                                                       &facs));
> >> >+               if (status =3D=3D AE_TABLE_NOT_SUPPORTED)
> >> >+                       continue;
> >> >+               if (ACPI_FAILURE(status))
> >> >+                       break;
> >> >+
> >> >+               if (!ACPI_COMPARE_NAME(&facs->signature, ACPI_SIG=
_FACS))
> >> >+                       continue;
> >> >+
> >> >+               if (facs->version >=3D 1)
> >> >+                       facs->xfirmware_waking_vector =3D 0;
> >> >+               facs->firmware_waking_vector =3D (u32)physical_ad=
dress;
> >> >+               break;
> >> >+       }
> >> >+
> >> >        return_ACPI_STATUS(AE_OK);
> >> > }
> >> >
> >> >Index: linux-2.6/drivers/acpi/tables/tbfadt.c
> >> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >--- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
> >> >+++ linux-2.6/drivers/acpi/tables/tbfadt.c
> >> >@@ -290,11 +290,13 @@ static void acpi_tb_convert_fadt(void)
> >> >
> >> >        if (!acpi_gbl_FADT.Xfacs) {
> >> >                acpi_gbl_FADT.Xfacs =3D (u64) acpi_gbl_FADT.facs;
> >> >-       }
> >> >+       } else if (acpi_gbl_FADT.Xfacs !=3D acpi_gbl_FADT.facs)
> >> >+               ACPI_WARNING((AE_INFO, "32 bit FACS and 64 bit FA=
CS not
> >> >match\n"));
> >> >
> >> >        if (!acpi_gbl_FADT.Xdsdt) {
> >> >                acpi_gbl_FADT.Xdsdt =3D (u64) acpi_gbl_FADT.dsdt;
> >> >-       }
> >> >+       } else if (acpi_gbl_FADT.Xdsdt !=3D acpi_gbl_FADT.dsdt)
> >> >+               ACPI_WARNING((AE_INFO, "32 bit DSDT and 64 bit DS=
DT not
> >> >match\n"));
> >> >
> >> >        /*
> >> >         * For ACPI 1.0 FADTs (revision 1 or 2), ensure that rese=
rved
> >> >fields which
> >> >
> >>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
