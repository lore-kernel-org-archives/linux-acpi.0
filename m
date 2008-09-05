From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Fri, 5 Sep 2008 12:48:15 +0200
Message-ID: <200809051248.16102.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <1220577437.4007.148.camel@yakui_zhao.sh.intel.com> <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59534 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbYIEKn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 06:43:56 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01803B89F1@PDSMSX501.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Friday, 5 of September 2008, Li, Shaohua wrote:
>=20
> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >owner@vger.kernel.org] On Behalf Of Zhao Yakui
> >Sent: Friday, September 05, 2008 9:17 AM
> >To: Matthew Garrett
> >Cc: Rafael J. Wysocki; Zhang, Rui; lenb@kernel.org; linux-
> >acpi@vger.kernel.org; andi@firstfloor.org
> >Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FC=
AS
> >table
> >
> >On Thu, 2008-09-04 at 13:07 +0100, Matthew Garrett wrote:
> >> On Thu, Sep 04, 2008 at 11:37:51AM +0200, Rafael J. Wysocki wrote:
> >> > > so it seems that the BIOS sets =EF=BB=BFfacs->xfirmware_waking=
_vector during
> >> > > POST, but uses =EF=BB=BF=EF=BB=BFfacs->firmware_waking_vector =
to get back during resume.
> >> >
> >> > So the BIOS is buggy, so let's add a quirk for it.
> >>
> >> Does the machine resume in Windows? If so, do we have any evidence=
 that
> >> Windows has a quirks list to handle this case? If not, then I susp=
ect
> >> that Windows sets both and this is what everyone has tested agains=
t.
> >The laptop can be resumed on windows.(XP & Vista). And we don't know
> >whether there exists the quirk list to handler this case on windows.
> >Maybe what you said is right.
> >In fact it is harmless when both 32bit and 64bit waking vector in FA=
CS
> >table are set. When the system is resumed, BIOS will transfer contro=
l to
> >the predefined waking vector. As we set the same waking vector, eith=
er
> >of them is OK.
> >
> >There exists the difference between 32bit and 64bit waking vector un=
less
> >the waking address is above 4GB. But in fact the waking address is b=
elow
> >1MB on most machines as the waking address needs to be accessed by B=
IOS.
> >
> >So in most cases the 32bit and 64bit waking vector are the same valu=
e.
> >BIOS can transfer control to either of them.
> There was discussion about this issue several months ago (intel's ml)=
, looks
> people forgot to take action after the discussion. The spec owner sai=
d 64bit
> vector is used in protected mode. That is if OS sets it, wakeup code =
is
> called in protected mode by BIOS.

Hm, that's interesting.  Do we have any examples of _working_ systems o=
n which
we set the 64-bit vector?

> So the 64-bit vector shouldn't be used.   =20

OK

So perhaps let's remove the setting of the 64-bit vector altogether (wi=
th an
appropriate comment in the source code) and see if that causes any regr=
essions
to happen.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
