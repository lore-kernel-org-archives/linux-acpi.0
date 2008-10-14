From: Zhao Yakui <yakui.zhao@intel.com>
Subject: RE: [PATCH 5/6] ACPI: set waking vector in inactive facs table
Date: Tue, 14 Oct 2008 09:07:07 +0800
Message-ID: <1223946427.3944.21.camel@yakui_zhao.sh.intel.com>
References: <1223885434.2735.188.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803194934@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24227 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbYJNBDD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 21:03:03 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803194934@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 2008-10-13 at 10:25 -0700, Moore, Robert wrote:
> >        if (!acpi_gbl_FADT.Xfacs) {
> >                acpi_gbl_FADT.Xfacs =3D (u64) acpi_gbl_FADT.facs;
> >-       }
> >+       } else if (acpi_gbl_FADT.Xfacs !=3D acpi_gbl_FADT.facs)
> >+               ACPI_WARNING((AE_INFO, "32 bit FACS and 64 bit FACS =
not
> >match\n"));
>=20
> I don't think you are handling the case where the 32-bit FACS address=
 is zero and the 64-bit address is non-zero. This is allowed and can ea=
sily happen if the address is > 4GB. Same with the DSDT addresses.
If the 32-bit FACS address is zero, it will be ignored and OS won't try
to access it again.


>+      } else if (acpi_gbl_FADT.Xfacs !=3D acpi_gbl_FADT.facs)
>+               ACPI_WARNING((AE_INFO, "32 bit FACS and 64 bit FACS no=
t
>match\n"));
  =20
   Maybe the above check is helpful. In the current ACPICA when the
64-bit address(XFACS) is not-zero, it will be always preferred. But on
some systems if only the waking vector in XFACS is used in OS while FAC=
S
is used in BIOS, maybe the system can't be resumed very well.
   If there exists such check, we can be prompted to try the RSDT
instead of XSDT when the 32 FACS and 64 bit XFACS don't match.
  =20
Best regard.
>=20
>=20
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Monday, October 13, 2008 1:11 AM
> >To: Len Brown
> >Cc: linux-acpi; Moore, Robert; Rafael J. Wysocki; Zhang, Rui
> >Subject: [PATCH 5/6] ACPI: set waking vector in inactive facs table
> >
> >
> >RSDT and XSDT may export different FACS tables.
> >Some of the BIOSes only checks one of them when resuming.
> >And Linux reboots instead of resuming because BIOS can't find
> >the waking vector.
> >For example,
> >=EF=BB=BFI have a platform which suspends well, but always reboots i=
nstead of
> >resuming when pressing the power button.
> >I found that there are two FACS tables on this platform,
> >XSDT-->FADT1-->Xfacs-->FACS1
> >        |----->facs-|
> >                    |->FACS2
> >RSDT-->FADT2-->facs-|
> >Linux uses XSDT on this platform and sets the waking vector in FACS1
> >when suspending.
> >But it seems that the BIOS only cares for the waking vector in FACS2=
,
> >thus it reboots when resuming because the waking vector is not set a=
t all.
> >
> >Set the waking vector in inactive FACS table in this patch.
> >
> >Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >---
> > drivers/acpi/hardware/hwsleep.c |   20 ++++++++++++++++++++
> > drivers/acpi/tables/tbfadt.c    |    6 ++++--
> > 2 files changed, 24 insertions(+), 2 deletions(-)
> >
> >Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> >+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> >@@ -65,6 +65,7 @@ acpi_set_firmware_waking_vector(acpi_phy
> > {
> >        struct acpi_table_facs *facs;
> >        acpi_status status;
> >+       u32 table_index;
> >
> >        ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
> >
> >@@ -92,6 +93,25 @@ acpi_set_firmware_waking_vector(acpi_phy
> >                facs->xfirmware_waking_vector =3D physical_address;
> >        }
> >
> >+       /* set the firmware vector in the inactive facs table */
> >+       for (table_index =3D 0, facs =3D NULL; ; table_index++) {
> >+               status =3D acpi_get_inactive_table_by_index(table_in=
dex,
> >+                               ACPI_CAST_INDIRECT_PTR(struct
> >acpi_table_header,
> >+                                                       &facs));
> >+               if (status =3D=3D AE_TABLE_NOT_SUPPORTED)
> >+                       continue;
> >+               if (ACPI_FAILURE(status))
> >+                       break;
> >+
> >+               if (!ACPI_COMPARE_NAME(&facs->signature, ACPI_SIG_FA=
CS))
> >+                       continue;
> >+
> >+               if (facs->version >=3D 1)
> >+                       facs->xfirmware_waking_vector =3D 0;
> >+               facs->firmware_waking_vector =3D (u32)physical_addre=
ss;
> >+               break;
> >+       }
> >+
> >        return_ACPI_STATUS(AE_OK);
> > }
> >
> >Index: linux-2.6/drivers/acpi/tables/tbfadt.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux-2.6.orig/drivers/acpi/tables/tbfadt.c
> >+++ linux-2.6/drivers/acpi/tables/tbfadt.c
> >@@ -290,11 +290,13 @@ static void acpi_tb_convert_fadt(void)
> >
> >        if (!acpi_gbl_FADT.Xfacs) {
> >                acpi_gbl_FADT.Xfacs =3D (u64) acpi_gbl_FADT.facs;
> >-       }
> >+       } else if (acpi_gbl_FADT.Xfacs !=3D acpi_gbl_FADT.facs)
> >+               ACPI_WARNING((AE_INFO, "32 bit FACS and 64 bit FACS =
not
> >match\n"));
> >
> >        if (!acpi_gbl_FADT.Xdsdt) {
> >                acpi_gbl_FADT.Xdsdt =3D (u64) acpi_gbl_FADT.dsdt;
> >-       }
> >+       } else if (acpi_gbl_FADT.Xdsdt !=3D acpi_gbl_FADT.dsdt)
> >+               ACPI_WARNING((AE_INFO, "32 bit DSDT and 64 bit DSDT =
not
> >match\n"));
> >
> >        /*
> >         * For ACPI 1.0 FADTs (revision 1 or 2), ensure that reserve=
d
> >fields which
> >
>=20
> NrybX=C7=A7v^)=DE=BA{.n+{ib{ay=1D=CA=87=DA=99,j=07fhz=1Ew=0Cj:+vwjm=07=
zZ+=DD=A2j"!

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
