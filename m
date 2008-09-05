From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Fri, 05 Sep 2008 09:17:17 +0800
Message-ID: <1220577437.4007.148.camel@yakui_zhao.sh.intel.com>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
	 <200809041010.07058.rjw@sisk.pl> <1220519910.24775.260.camel@rzhang-dt>
	 <200809041137.52379.rjw@sisk.pl>  <20080904120719.GA9216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34101 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbYIEBDK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 21:03:10 -0400
In-Reply-To: <20080904120719.GA9216@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thu, 2008-09-04 at 13:07 +0100, Matthew Garrett wrote:
> On Thu, Sep 04, 2008 at 11:37:51AM +0200, Rafael J. Wysocki wrote:
> > > so it seems that the BIOS sets =EF=BB=BFfacs->xfirmware_waking_ve=
ctor during
> > > POST, but uses =EF=BB=BF=EF=BB=BFfacs->firmware_waking_vector to =
get back during resume.
> >=20
> > So the BIOS is buggy, so let's add a quirk for it.
>=20
> Does the machine resume in Windows? If so, do we have any evidence th=
at=20
> Windows has a quirks list to handle this case? If not, then I suspect=
=20
> that Windows sets both and this is what everyone has tested against.
The laptop can be resumed on windows.(XP & Vista). And we don't know
whether there exists the quirk list to handler this case on windows.=20
Maybe what you said is right.=20
In fact it is harmless when both 32bit and 64bit waking vector in FACS
table are set. When the system is resumed, BIOS will transfer control t=
o
the predefined waking vector. As we set the same waking vector, either
of them is OK.=20

There exists the difference between 32bit and 64bit waking vector unles=
s
the waking address is above 4GB. But in fact the waking address is belo=
w
1MB on most machines as the waking address needs to be accessed by BIOS=
=2E

So in most cases the 32bit and 64bit waking vector are the same value.
BIOS can transfer control to either of them.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
