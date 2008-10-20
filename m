From: Zhao Yakui <yakui.zhao@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Mon, 20 Oct 2008 11:07:36 +0800
Message-ID: <1224472056.3944.210.camel@yakui_zhao.sh.intel.com>
References: <1223885404.2735.183.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D830858031948BA@orsmsx503.amr.corp.intel.com>
	 <1223946036.2735.212.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803213EB4@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D83085803277F40@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D83085803278063@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D8308580327808C@orsmsx503.amr.corp.intel.com>
	 <1224211645.2735.283.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D830858032E0222@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbYJTDBs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 23:01:48 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858032E0222@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Sat, 2008-10-18 at 01:52 +0800, Moore, Robert wrote:
> >In order to test if global lock works or not,
> >we need to acquire the global lock in Linux while BIOS holds it, rig=
ht?
> >But I don't know how to make BIOS hold the global lock. :(
> >any ideas?
>=20
> No, BIOS does not need to be holding the lock. If you can successfull=
y acquire the global lock on the OS side, this will prove that the lock=
 is valid. From the OS, first the "pending" bit is set, and if the glob=
al lock is acquired successfully, it responds by setting the "owned" bi=
t. If this works correctly, the global lock works.
After the test we find that the global lock on both FACS tables can be
acquired on the OS side.=20
   After acquiring the global lock the OWNED bit is set.=20
   After releasing the global lock the OWNED bit is cleared.

The global lock is only the memory region that resides in FACS table.
How to realize it depends on the communication between OS and BIOS.
   After the system is switched from legacy mode to ACPI mode, OS will
check whether the OWNED bit is set before acquiring the global lock.=20
   If it is zero, OS will set the OWNED bit. In such case if BIOS also
expects to acquire the global lock, the pending bit is set. When OS
releases the global lock, OS will raise an event to BIOS by writing 1 t=
o
GBL_RLS bit of PM1_CTRL register. And BIOS can continue to acquire the
global lock.
   If it is set, it indicates that the global lock is acquired by BIOS.
The pending bit is set by OS. In such case when the global lock is
released by BIOS, it will raise an ACPI event to OS and OS can continue
to acquire the global lock.

So IMO it is difficult to verify whether the global lock work well on
the two FACS tables if BIOS doesn't hold the global lock.

thanks.
>=20
>=20
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Thursday, October 16, 2008 7:47 PM
> >To: Moore, Robert
> >Cc: Len Brown; linux-acpi; Lin, Ming M; Zhao, Yakui
> >Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> >
> >On Wed, 2008-10-15 at 16:21 -0600, Moore, Robert wrote:
> >> Rui,
> >>
> >> We need to find out *exactly* what is going on with this machine b=
efore
> >we do any coding.
> >>
> >> Here is what we need to know:
> >>
> >> For the FACS pointed to by the 32-bit FIRMWARE_CTRL field:
> >>
> >> 1) does the 32-bit wake vector work?
> >yes
> >
> >> 2) does the 64-bit wake vector work?
> >no. reboot upon resume.
> >
> >> 3) does the global lock work?
> >>
> >> For the FACS pointed to by the 64-bit X_FIRMWARE_CTRL field:
> >>
> >> 1) does the 32-bit wake vector work?
> >=EF=BB=BFno. reboot upon resume.
> >> 2) does the 64-bit wake vector work?
> >=EF=BB=BFno. reboot upon resume.
> >
> >well, we got a total different result on another box with two FACS
> >tables, yakui will update later.
> >
> >> 3) does the global lock work?
> >>
> >In order to test if global lock works or not,
> >we need to acquire the global lock in Linux while BIOS holds it, rig=
ht?
> >But I don't know how to make BIOS hold the global lock. :(
> >any ideas?
> >
> >thanks,
> >rui
> >
> >
> >>
> >> >-----Original Message-----
> >> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> >owner@vger.kernel.org] On Behalf Of Moore, Robert
> >> >Sent: Wednesday, October 15, 2008 3:13 PM
> >> >To: Zhang, Rui
> >> >Cc: Len Brown; linux-acpi; Lin, Ming M
> >> >Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> >> >
> >> >While we are trying to determine which is the "real" FACS, there =
is one
> >> >more goofy possibility that we should probably explore:
> >> >
> >> >How about if:
> >> >
> >> >1) the 64-bit X_FIRMWARE_WAKING_VECTOR is implemented in the FACS=
 that
> >is
> >> >pointed to by the 64-bit X_FIRMWARE_CTRL field in the FADT, and
> >> >
> >> >2) the 32-bit FIRMWARE_WAKING_VECTOR is implemented in the other =
=46ACS,
> >the
> >> >one pointed to by the 32-bit FIRMWARE_CTRL field in the FADT.
> >> >
> >> >This could be the mistake in reasoning that led to the two differ=
ent
> >FACS
> >> >tables in the first place.
> >> >
> >> >If this is true, then which FACS has the valid Global Lock?
> >> >
> >> >
> >> >
> >> >>-----Original Message-----
> >> >>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> >>owner@vger.kernel.org] On Behalf Of Moore, Robert
> >> >>Sent: Wednesday, October 15, 2008 1:56 PM
> >> >>To: Zhang, Rui
> >> >>Cc: Len Brown; linux-acpi; Lin, Ming M
> >> >>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> >> >>
> >> >>As usual with ACPI issues, the more we dig, the worse the proble=
m gets:
> >> >>
> >> >>Another potential problem is the Global Lock. If there are two F=
ACS
> >> >tables,
> >> >>it is probably the case that the Global Lock only works with one=
 of the
> >> >>tables.
> >> >>
> >> >>Please check on your machine if the global lock is working or no=
t.
> >> >>
> >> >>If it is the case that both the Firmware Waking Vector and the G=
lobal
> >Lock
> >> >>work with only one of the FACS tables, it would probably be best=
 to
> >> >>determine which one of the tables is the "real" FACS and just us=
e that
> >one
> >> >>(rather than use two tables.)
> >> >>
> >> >>To determine the "real" FACS, at initialization time we could tr=
y to
> >> >obtain
> >> >>the global lock -- and only the real table will get a response f=
rom the
> >> >>BIOS.
> >> >>
> >> >>I hope it is beyond imagination that a BIOS would be implemented=
 such
> >that
> >> >>the Global Lock is implemented in one table, and the Firmware Wa=
king
> >> >Vector
> >> >>is implemented in another.
> >> >>
> >> >>Bob
> >> >>
> >> >>
> >> >>>-----Original Message-----
> >> >>>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> >>>owner@vger.kernel.org] On Behalf Of Moore, Robert
> >> >>>Sent: Tuesday, October 14, 2008 2:13 PM
> >> >>>To: Zhang, Rui
> >> >>>Cc: Len Brown; linux-acpi; Lin, Ming M
> >> >>>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancemen=
t
> >> >>>
> >> >>>So, this apparently comes down to a problem where the FADT cont=
ains
> >two
> >> >>>different addresses for the FACS in the FIRMWARE_CTRL and
> >X_FIRMWARE_CTRL
> >> >>>fields. It would be a relatively simple fix to write the wake v=
ector
> >to
> >> >>>both tables if necessary. I don't see a need to go back to the =
RSDT
> >for
> >> >>>this case.
> >> >>>
> >> >>>
> >> >>>A couple of global comments:
> >> >>>
> >> >>>1) In general, it seems like a lot of overhead to load a second=
 set of
> >> >>>"inactive" tables from the RSDT -- especially if this is for de=
bug
> >only.
> >> >>>Not only the code to do it, but the dynamic memory for the seco=
nd root
> >> >>>table list and the memory mappings, potentially one for each ta=
ble in
> >the
> >> >>>RSDT.
> >> >>>
> >> >>>2) As far as acpidump -- I have plans to enhance this utility s=
o that
> >it
> >> >>is
> >> >>>OS-independent and will run on any host. The current version of
> >acpidump
> >> >>is
> >> >>>Linux-specific. So, I don't think acpidump is going away. If we=
 need a
> >> >>dump
> >> >>>of both the XSDT tables and the RSDT tables, we should be able =
to
> >modify
> >> >>>acpidump to perform this, and we will not need to add kernel co=
de or
> >use
> >> >>>kernel resources.
> >> >>>
> >> >>>Bob
> >> >>>
> >> >>>
> >> >>>>-----Original Message-----
> >> >>>>From: Zhang, Rui
> >> >>>>Sent: Monday, October 13, 2008 6:01 PM
> >> >>>>To: Moore, Robert
> >> >>>>Cc: Len Brown; linux-acpi
> >> >>>>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhanceme=
nt
> >> >>>>
> >> >>>>On Mon, 2008-10-13 at 11:02 -0600, Moore, Robert wrote:
> >> >>>>> >I found that there are two FACS tables on this platform,
> >> >>>>> >XSDT-->FADT1-->Xfacs-->FACS1
> >> >>>>> >        |----->facs-|
> >> >>>>> >                    |->FACS2
> >> >>>>> >RSDT-->FADT2-->facs-|
> >> >>>>> >Linux uses XSDT on this platform and sets the waking vector=
 in
> >FACS1
> >> >>>>> >when suspending.
> >> >>>>> >But it seems that the BIOS only cares for the waking vector=
 in
> >FACS2,
> >> >>>>>
> >> >>>>>
> >> >>>>> Is this possibly an issue of using the 32-bit wake vector ve=
rsus
> >the
> >> >>64-
> >> >>>>bit wake vector? (For example, perhaps the FACS1 has both vect=
ors and
> >> >the
> >> >>>>64-bit vector is used but fails. But the FACS2 only has the 32=
-bit
> >> >vector
> >> >>>>so it is used, and this works correctly with the BIOS.)
> >> >>>>=EF=BB=BFNo, I tested the patch from Rafael, which is the same=
 from the one
> >> >>>>here:
> >> >>>>http://www.acpica.org/bugzilla/attachment.cgi?id=3D813&action=3D=
view
> >> >>>>It doesn't work.
> >> >>>>
> >> >>>>> Or, is it actually the case where the two FACS tables have
> >different
> >> >>>wake
> >> >>>>vectors? Both the 32-bit vectors and the 64-bit vectors are
> >different?
> >> >>>>the wake vector is just a memory address where BIOS passes the
> >control
> >> >>>>to OS.
> >> >>>>As there are two different FACS tables located at different
> >addresses,
> >> >>>>surely the wake vectors are different. :)
> >> >>>>
> >> >>>>thanks,
> >> >>>>rui
> >>
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
