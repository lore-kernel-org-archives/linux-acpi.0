From: Zhao Yakui <yakui.zhao@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Fri, 17 Oct 2008 13:15:21 +0800
Message-ID: <1224220521.3944.157.camel@yakui_zhao.sh.intel.com>
References: <1223885404.2735.183.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D830858031948BA@orsmsx503.amr.corp.intel.com>
	 <1223946036.2735.212.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803213EB4@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D83085803277F40@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D83085803278063@orsmsx503.amr.corp.intel.com>
	 <4911F71203A09E4D9981D27F9D8308580327808C@orsmsx503.amr.corp.intel.com>
	 <1224211645.2735.283.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11059 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYJQFJq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 01:09:46 -0400
In-Reply-To: <1224211645.2735.283.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Fri, 2008-10-17 at 10:47 +0800, Zhang Rui wrote:
> On Wed, 2008-10-15 at 16:21 -0600, Moore, Robert wrote:
> > Rui,
> >=20
> > We need to find out *exactly* what is going on with this machine be=
fore we do any coding.
> >=20
> > Here is what we need to know:
> >=20
> > For the FACS pointed to by the 32-bit FIRMWARE_CTRL field:
> >=20
> > 1) does the 32-bit wake vector work?
> yes
>=20
> > 2) does the 64-bit wake vector work?
> no. reboot upon resume.
>=20
> > 3) does the global lock work?
> >=20
> > For the FACS pointed to by the 64-bit X_FIRMWARE_CTRL field:
> >=20
> > 1) does the 32-bit wake vector work?
> =EF=BB=BFno. reboot upon resume.
> > 2) does the 64-bit wake vector work?
> =EF=BB=BFno. reboot upon resume.
>=20
> well, we got a total different result on another box with two FACS
> tables, yakui will update later.
In my hand there is another SDV box with the two FACS table. One is
obtained from Firmware_CTRL.  Another is obtained from XFirmware_CTRL.
=46or the FACS pointed by the 32 bit Firmware_CTRL filed:
1) does the 32-bit wake vector work?
Yes. The system can be resumed very well.
2) does the 64-bit wake vector work?
  No. The system can't be resumed.=20

=46or the FACS pointed by the 64-bit X_Firmware_CTRL filed:
   1) does the 32-bit wake vector work
   Yes. It can be resumed very well.
    2) does the 64-bit wake vector work?
     No. It can't be resumed.

Best regards.
   Yakui.
> >=20
> >
> >=20
> In order to test if global lock works or not,
> we need to acquire the global lock in Linux while BIOS holds it, righ=
t?
> But I don't know how to make BIOS hold the global lock. :(
> any ideas?
>=20
> thanks,
> rui=20
>=20
>=20
> >=20
> > >-----Original Message-----
> > >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > >owner@vger.kernel.org] On Behalf Of Moore, Robert
> > >Sent: Wednesday, October 15, 2008 3:13 PM
> > >To: Zhang, Rui
> > >Cc: Len Brown; linux-acpi; Lin, Ming M
> > >Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> > >
> > >While we are trying to determine which is the "real" FACS, there i=
s one
> > >more goofy possibility that we should probably explore:
> > >
> > >How about if:
> > >
> > >1) the 64-bit X_FIRMWARE_WAKING_VECTOR is implemented in the FACS =
that is
> > >pointed to by the 64-bit X_FIRMWARE_CTRL field in the FADT, and
> > >
> > >2) the 32-bit FIRMWARE_WAKING_VECTOR is implemented in the other F=
ACS, the
> > >one pointed to by the 32-bit FIRMWARE_CTRL field in the FADT.
> > >
> > >This could be the mistake in reasoning that led to the two differe=
nt FACS
> > >tables in the first place.
> > >
> > >If this is true, then which FACS has the valid Global Lock?
> > >
> > >
> > >
> > >>-----Original Message-----
> > >>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > >>owner@vger.kernel.org] On Behalf Of Moore, Robert
> > >>Sent: Wednesday, October 15, 2008 1:56 PM
> > >>To: Zhang, Rui
> > >>Cc: Len Brown; linux-acpi; Lin, Ming M
> > >>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> > >>
> > >>As usual with ACPI issues, the more we dig, the worse the problem=
 gets:
> > >>
> > >>Another potential problem is the Global Lock. If there are two FA=
CS
> > >tables,
> > >>it is probably the case that the Global Lock only works with one =
of the
> > >>tables.
> > >>
> > >>Please check on your machine if the global lock is working or not=
=2E
> > >>
> > >>If it is the case that both the Firmware Waking Vector and the Gl=
obal Lock
> > >>work with only one of the FACS tables, it would probably be best =
to
> > >>determine which one of the tables is the "real" FACS and just use=
 that one
> > >>(rather than use two tables.)
> > >>
> > >>To determine the "real" FACS, at initialization time we could try=
 to
> > >obtain
> > >>the global lock -- and only the real table will get a response fr=
om the
> > >>BIOS.
> > >>
> > >>I hope it is beyond imagination that a BIOS would be implemented =
such that
> > >>the Global Lock is implemented in one table, and the Firmware Wak=
ing
> > >Vector
> > >>is implemented in another.
> > >>
> > >>Bob
> > >>
> > >>
> > >>>-----Original Message-----
> > >>>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > >>>owner@vger.kernel.org] On Behalf Of Moore, Robert
> > >>>Sent: Tuesday, October 14, 2008 2:13 PM
> > >>>To: Zhang, Rui
> > >>>Cc: Len Brown; linux-acpi; Lin, Ming M
> > >>>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> > >>>
> > >>>So, this apparently comes down to a problem where the FADT conta=
ins two
> > >>>different addresses for the FACS in the FIRMWARE_CTRL and X_FIRM=
WARE_CTRL
> > >>>fields. It would be a relatively simple fix to write the wake ve=
ctor to
> > >>>both tables if necessary. I don't see a need to go back to the R=
SDT for
> > >>>this case.
> > >>>
> > >>>
> > >>>A couple of global comments:
> > >>>
> > >>>1) In general, it seems like a lot of overhead to load a second =
set of
> > >>>"inactive" tables from the RSDT -- especially if this is for deb=
ug only.
> > >>>Not only the code to do it, but the dynamic memory for the secon=
d root
> > >>>table list and the memory mappings, potentially one for each tab=
le in the
> > >>>RSDT.
> > >>>
> > >>>2) As far as acpidump -- I have plans to enhance this utility so=
 that it
> > >>is
> > >>>OS-independent and will run on any host. The current version of =
acpidump
> > >>is
> > >>>Linux-specific. So, I don't think acpidump is going away. If we =
need a
> > >>dump
> > >>>of both the XSDT tables and the RSDT tables, we should be able t=
o modify
> > >>>acpidump to perform this, and we will not need to add kernel cod=
e or use
> > >>>kernel resources.
> > >>>
> > >>>Bob
> > >>>
> > >>>
> > >>>>-----Original Message-----
> > >>>>From: Zhang, Rui
> > >>>>Sent: Monday, October 13, 2008 6:01 PM
> > >>>>To: Moore, Robert
> > >>>>Cc: Len Brown; linux-acpi
> > >>>>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancemen=
t
> > >>>>
> > >>>>On Mon, 2008-10-13 at 11:02 -0600, Moore, Robert wrote:
> > >>>>> >I found that there are two FACS tables on this platform,
> > >>>>> >XSDT-->FADT1-->Xfacs-->FACS1
> > >>>>> >        |----->facs-|
> > >>>>> >                    |->FACS2
> > >>>>> >RSDT-->FADT2-->facs-|
> > >>>>> >Linux uses XSDT on this platform and sets the waking vector =
in FACS1
> > >>>>> >when suspending.
> > >>>>> >But it seems that the BIOS only cares for the waking vector =
in FACS2,
> > >>>>>
> > >>>>>
> > >>>>> Is this possibly an issue of using the 32-bit wake vector ver=
sus the
> > >>64-
> > >>>>bit wake vector? (For example, perhaps the FACS1 has both vecto=
rs and
> > >the
> > >>>>64-bit vector is used but fails. But the FACS2 only has the 32-=
bit
> > >vector
> > >>>>so it is used, and this works correctly with the BIOS.)
> > >>>>=EF=BB=BFNo, I tested the patch from Rafael, which is the same =
from the one
> > >>>>here:
> > >>>>http://www.acpica.org/bugzilla/attachment.cgi?id=3D813&action=3D=
view
> > >>>>It doesn't work.
> > >>>>
> > >>>>> Or, is it actually the case where the two FACS tables have di=
fferent
> > >>>wake
> > >>>>vectors? Both the 32-bit vectors and the 64-bit vectors are dif=
ferent?
> > >>>>the wake vector is just a memory address where BIOS passes the =
control
> > >>>>to OS.
> > >>>>As there are two different FACS tables located at different add=
resses,
> > >>>>surely the wake vectors are different. :)
> > >>>>
> > >>>>thanks,
> > >>>>rui
> >=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
