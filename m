From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Bug 11884 - _REG and _INI
Date: Mon, 15 Dec 2008 15:27:50 +0800
Message-ID: <1229326070.3991.7.camel@yakui_zhao.sh.intel.com>
References: <1229313063.19540.86.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50417 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbYLOHTF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 02:19:05 -0500
In-Reply-To: <1229313063.19540.86.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2008-12-15 at 11:51 +0800, Lin Ming wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D11884=20
>=20
> Method(\_SB._INI)
> {
> 	//initialize package CUZO
> }
>=20
> Method(\_SB_.PCI0.LPCB.EC0_._REG)
> {
> 	//access package CUZO
> }
>=20
> For this machine, =EF=BB=BF\_SB._INI must be run before =EF=BB=BF\_SB=
_.PCI0.LPCB.EC0_._REG
>=20
> But currently early EC _REG method is run before _INI as below acpi_b=
us_init shows.
>=20
> void __init acpi_bus_init(void)
>          .....
>          status =3D acpi_ec_ecdt_probe();
>          /* Ignore result. Not having an ECDT is not fatal. */
>=20
>          status =3D acpi_initialize_objects(ACPI_FULL_INITIALIZATION)=
;
>          .....
> }
>=20
> =EF=BB=BFacpi_ec_ecdt_probe will install ec handler although no ECDT =
found in this machine.
>=20
> Alexey,=20
> How about that if there's no ECDT found, we do not install ec handler=
 before =EF=BB=BFacpi_initialize_objects?

I do some test with the help of KVM. In my test the ECDT table is
defined. And there also exists the EC device in DSDT table.Of course
there exists the _INI/_REG object under the scope of EC device. Under
the scope of \_SB.PCI0 there exists the _INI/_REG object.

>From the test result it seems that all the _INI objects are evaluated
before _REG object even when there exists the ECDT table.

Hi, Alexey
    Can the Lin Ming's proposal be considered based on the above test?=20

Thanks.

>=20
> Lin Ming
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
