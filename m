From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Can't get ACPI to work on a Panasonic Toughbook CF-52
Date: Tue, 15 Apr 2008 02:02:37 +0800
Message-ID: <1208196157.4031.61.camel@yakui_zhao.sh.intel.com>
References: <4801D253.40904@orle.de>
	 <9D7649D18729DE4BB2BD7B494F7FEDC20122C2F2@pdsmsx415.ccr.corp.intel.com>
	 <4802137E.9060804@orle.de>
	 <1208164382.4031.11.camel@yakui_zhao.sh.intel.com>
	 <480319F5.1060702@orle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41252 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbYDNKLg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 06:11:36 -0400
In-Reply-To: <480319F5.1060702@orle.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ralf Orlowski <ralf@orle.de>
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-04-14 at 10:46 +0200, Ralf Orlowski wrote:
> Hello,
>=20
> Zhao Yakui schrieb:
> > On Sun, 2008-04-13 at 16:06 +0200, Ralf Orlowski wrote:
> >> Hello,
> >>
> >> sure, that is no problem.
> >>
> >> Bye Ralf
> > Thanks for the info.
> > That the system can't be booted in ACPI mode is caused by the broke=
n
> > bios. And the bug is caused by the following definition:
> >=20
> >> Name (ASLB, 0x00) (It is defined in the scope of GFX0 device)
> >> OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
> > The correct definition should be the following:
> > OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)
> >=20
> >=20
> > Now there is another similar bug in the kernel bugzilla.
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D9915
> >=20
> > Will you please try the custom dsdt and see whether the system can =
be
> > booted with acpi enabled?
> > How to use the custom DSDT can be found in=20
> > http://www.lesswatts.org/projects/acpi/faq.php.
> >=20
>=20
> Thanks for your help.
> I just tried the DSDT I downloaded from=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D9915
Sorry that you can't use the custom DSDT downloaded from the bug9915.
You had better modify the DSDT based on your laptop.
To modify the following will be OK=20

 OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)  // This is incorre=
ct.
 The correct definition should be the following: =20
    OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)

> Now it gets a little bit further when booting with ACPI enabled, but =
at=20
> the end it still hangs. :-(
>=20
> I get several messages "Could not map memory", "AE_NO_MEMORY" and=20
> "Method parse/execution failed". And then the boot stops.
>=20
> Is there a way to write these messages somewhere before the system=20
> stops, so that I could post the exact messages here?
>=20
> But so far I'm still not able to start the system with ACPI enabled. =
:-(
>=20
>=20
> > Thanks.
> >=20
>=20
> Bye
>=20
> Ralf
>=20
> >> Zhao, Yakui schrieb:
> >>> Will you please try to boot the system with the option of "acpi=3D=
off"
> >>> and attach the output of acpidump, lspci -vxxx ? Thanks.
> >>>
> >>> -----Original Message----- From: linux-acpi-owner@vger.kernel.org
> >>> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Ralf Orlow=
ski=20
> >>> Sent: 2008=E5=B9=B44=E6=9C=8813=E6=97=A5 17:29 To: linux-acpi@vge=
r.kernel.org Subject: Can't
> >>> get ACPI to work on a Panasonic Toughbook CF-52
> >>>
> >>> Hello,
> >>>
> >>> I just got a new Panasonic Toughbook CF-52. I installed the syste=
m
> >>> with debian sid and except of the ACPI-Support the system runs fi=
ne
> >>> under linux. But so far I had no success to get ACPI working on t=
he
> >>> system.
> >>>
> >>> Today I installed kernel version 2.6.25-rc9 on the system, becaus=
e I
> >>>  read, there should be a patch included, that make ACPI work on m=
y=20
> >>> system. But so far it does not.
> >>>
> >>> The kernel runs fine with ACPI disabled, but with ACPI enabled th=
e
> >>> boot just stops with a message about ACPI interrupts.
> >>>
> >>> Does anyone know, what I could try, to get ACPI working, or how I
> >>> could find out more about the problem to may be help to find a
> >>> solution?
> >>>
> >>> Bye
> >>>
> >>> Ralf
> >>
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
