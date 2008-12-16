From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Bug 11884 - _REG and _INI
Date: Tue, 16 Dec 2008 09:07:46 +0800
Message-ID: <1229389666.3991.19.camel@yakui_zhao.sh.intel.com>
References: <1229313063.19540.86.camel@minggr.sh.intel.com>
	 <1229326070.3991.7.camel@yakui_zhao.sh.intel.com>
	 <494622E0.4020600@suse.de>  <494635B2.60001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33957 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbYLPA6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 19:58:55 -0500
In-Reply-To: <494635B2.60001@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-12-15 at 18:47 +0800, Alexey Starikovskiy wrote:
> It's not that simple... Here is relevant part of dmesg from my thinkp=
ad:
>=20
> ---------------------------------------------------------------------=
---
> ACPI Error (evregion-0315): No handler for Region [ECOR]=20
> (ffff8800bf814558) [EmbeddedControl] [20080926]
> ACPI Error (exfldio-0291): Region EmbeddedControl(3) has no handler=20
> [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed=20
> [\_SB_.PCI0.LPC_.EC__._INI] (Node ffff8800bf817300), AE_NOT_EXIST
> ACPI: EC: EC description table is found, configuring boot EC
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: EC: non-query interrupt received, switching to interrupt mode
> ACPI: EC: GPE =3D 0x1c, I/O: command/status =3D 0x66, data =3D 0x62
> ACPI: EC: driver started in interrupt mode
> ---------------------------------------------------------------------=
-----
There exists too much difference on different vendors.
In theory there exists the EC flag in AML code, which indicates whether
the EC operation region can be accessed.  After the EC _REG object is
evaluated, the EC flag will be set and it means that EC operation regio=
n
can be accessed. Before the EC _REG object is evaluated, it had better
be zero.
>From the above dmesg it seems that the above warning is related with o=
ne
of the two following factors:
   a. EC flag is initialized as one. In such case it means that EC
operation region can be accessed before EC initialization.
   b. EC flag is not used correctly in some methods.=20

At the same time from the above message we know that there exists the
ECDT table. So when there exists the ECDT table, we can continue to use
the current flowchart of EC initialization.

Can Lin ming's proposal be applied to the situation that there is no
ECDT table?=20

Thanks.
   =20
>=20
> Any other suggestions?
>=20
> Regards,
> Alex.
>=20
> Alexey Starikovskiy wrote:
> > Zhao Yakui wrote:
> >> On Mon, 2008-12-15 at 11:51 +0800, Lin Ming wrote:
> >>> http://bugzilla.kernel.org/show_bug.cgi?id=3D11884
> >>> Method(\_SB._INI)
> >>> {
> >>> //initialize package CUZO
> >>> }
> >>>
> >>> Method(\_SB_.PCI0.LPCB.EC0_._REG)
> >>> {
> >>> //access package CUZO
> >>> }
> >>>
> >>> For this machine, =EF=BB=BF\_SB._INI must be run before=20
> >>> =EF=BB=BF\_SB_.PCI0.LPCB.EC0_._REG
> >>>
> >>> But currently early EC _REG method is run before _INI as below=20
> >>> acpi_bus_init shows.
> >>>
> >>> void __init acpi_bus_init(void)
> >>> .....
> >>> status =3D acpi_ec_ecdt_probe();
> >>> /* Ignore result. Not having an ECDT is not fatal. */
> >>>
> >>> status =3D acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
> >>> .....
> >>> }
> >>>
> >>> =EF=BB=BFacpi_ec_ecdt_probe will install ec handler although no E=
CDT found=20
> >>> in this machine.
> >>>
> >>> Alexey, How about that if there's no ECDT found, we do not instal=
l=20
> >>> ec handler before =EF=BB=BFacpi_initialize_objects?
> >>
> >> I do some test with the help of KVM. In my test the ECDT table is
> >> defined. And there also exists the EC device in DSDT table.Of cour=
se
> >> there exists the _INI/_REG object under the scope of EC device. Un=
der
> >> the scope of \_SB.PCI0 there exists the _INI/_REG object.
> >>
> >>> From the test result it seems that all the _INI objects are evalu=
ated
> >> before _REG object even when there exists the ECDT table.
> >>
> >> Hi, Alexey
> >> Can the Lin Ming's proposal be considered based on the above test?=
=20
> > Hi Yakui,
> > His proposal needs to be considered even without your test (but the=
=20
> > test itself is quite helpful), just because HP does not violate the=
=20
> > ACPI spec, but ASUS notebooks without ECDT do violate it (and fake=20
> > ECDT workaround is there for them).
> >
> > Thanks,
> > Alex.
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
