From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Tue, 14 Oct 2008 09:00:36 +0800
Message-ID: <1223946036.2735.212.camel@rzhang-dt>
References: <1223885404.2735.183.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D830858031948BA@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12836 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759545AbYJNBIK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 21:08:10 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858031948BA@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-10-13 at 11:02 -0600, Moore, Robert wrote:
> >I found that there are two FACS tables on this platform,
> >XSDT-->FADT1-->Xfacs-->FACS1
> >        |----->facs-|
> >                    |->FACS2
> >RSDT-->FADT2-->facs-|
> >Linux uses XSDT on this platform and sets the waking vector in FACS1
> >when suspending.
> >But it seems that the BIOS only cares for the waking vector in FACS2=
,
>=20
>=20
> Is this possibly an issue of using the 32-bit wake vector versus the =
64-bit wake vector? (For example, perhaps the FACS1 has both vectors an=
d the 64-bit vector is used but fails. But the FACS2 only has the 32-bi=
t vector so it is used, and this works correctly with the BIOS.)
=EF=BB=BFNo, I tested the patch from Rafael, which is the same from the=
 one
here:
http://www.acpica.org/bugzilla/attachment.cgi?id=3D813&action=3Dview
It doesn't work.

> Or, is it actually the case where the two FACS tables have different =
wake vectors? Both the 32-bit vectors and the 64-bit vectors are differ=
ent?
the wake vector is just a memory address where BIOS passes the control
to OS.
As there are two different FACS tables located at different addresses,
surely the wake vectors are different. :)

thanks,
rui

>=20
>=20
>=20
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Monday, October 13, 2008 1:10 AM
> >To: Len Brown
> >Cc: linux-acpi; Zhang, Rui; Moore, Robert
> >Subject: [PATCH 0/6] ACPI: acpi table management enhancement
> >
> >hi all,
> >
> >this is the patch set I made recently for ACPI table management
> >enhancement.
> >
> >Patch 01 introduces a new mechanism for ACPI inactive table manageme=
nt.
> >with this patch applied, Linux gets the address of the unused root
> >table, and parses this root table to get the inactive tables when
> >needed.
> >e.g. if Linux is using XSDT on a laptop, tables from RSDT will be
> >maintain by this mechanism.
> >
> >Patch 02 introduces a new interface to get certain inactive table,
> >which is needed by Patch 03.
> >
> >Patch 03 gets the inactive tables and creates sysfs I/F for these
> >tables.
> >
> >Patch 04 creates the sysfs I/F for dynamic loaded tables.
> >so that users can get all the ACPI tables
> >under /sys/firmware/acpi/tables,
> >which was done by the acpidump tool manually before.
> >
> >Patch 05 fixes a suspend/hibernation bug.
> >I have a platform which suspends well, but always reboots instead of
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
t
> >all.
> >I set the waking vector in inactive FACS table to fix it in this pat=
ch.
> >
> >Patch 06 is a refreshed version of =EF=BB=BFPeter Gruber's patch whi=
ch stops
> >using empty file names for acpi tables in sysfs I/F.
> >
> >Note:
> >In this patch set, all the tables in the inactive root table are
> >recognized as inactive tables even if it's also in the active root
> >table.
> >i.e. some tables are shown twice in /sys/firmware/acpi/tables,
> >both as active and inactive tables.
> >Take my laptop for example,
> >#ls /sys/firmware/acpi/tables/
> >APIC  APIC_inactive  ASF!  ASF!_inactive  DSDT  DSDT_inactive  FACP
> >FACP_inactive
> >FACS  FACS_inactive  MCFG  MCFG_inactive  SSDT_dynamic
> >
> >In my case, FACP and FACP_inactive are different tables exported by =
XSDT
> >and RSDT.
> >but MCFG and MCFG_inactive are the same table because they point to =
the
> >same physical address.
> >
> >I don't think the duplicate tables should be ignored because:
> >If only the unduplicated inactive tables is shown, we are not able t=
o
> >get a full list of the tables exported by the inactive root table,
> >which is important for debugging in some cases.
> >
> >any comments are welcome. :)
> >
> >
> >thanks,
> >rui
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
