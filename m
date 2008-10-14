From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Tue, 14 Oct 2008 09:19:40 +0800
Message-ID: <1223947180.2735.228.camel@rzhang-dt>
References: <1223885404.2735.183.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7649 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbYJNB3A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 21:29:00 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-10-13 at 15:56 -0600, Moore, Robert wrote:
> I'd like to try and summarize this, correct me on any mistakes.
>=20
> 1) If the XSDT exists, we use this, as per the ACPI specification. Ho=
wever, we will also get all tables within the RSDT and mark them as the=
 "inactive" table set.
Right.
>=20
> Acpidump
=EF=BB=BFIf the patch set is applied, we don't need acpidump any more
as we can get all the table info at /sys/firmware/acpi/tables/.
>  will now get both the "active" and "inactive" tables?
yes.

>=20
> 2) In the FACS firmware waking vector case, we set the vector in both=
 the "active" FACS and the "inactive" FACS.
Right.
>=20
> Again, please note that we have changed the ACPICA interface to set t=
he firmware wake vector - splitting into two.
hmm, when will this change be shipped to Linux?
BTW: Rafael has already proposed a patch which always clears 64 bit wak=
e
vector and uses the 32 bit one.
http://marc.info/?l=3Dlinux-acpi&m=3D122370808622832&w=3D2

thanks,
rui
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
