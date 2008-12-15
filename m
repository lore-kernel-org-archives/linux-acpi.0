From: Lin Ming <ming.m.lin@intel.com>
Subject: Bug 11884 - _REG and _INI
Date: Mon, 15 Dec 2008 11:51:03 +0800
Message-ID: <1229313063.19540.86.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61698 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbYLODwU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Dec 2008 22:52:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

http://bugzilla.kernel.org/show_bug.cgi?id=3D11884=20

Method(\_SB._INI)
{
	//initialize package CUZO
}

Method(\_SB_.PCI0.LPCB.EC0_._REG)
{
	//access package CUZO
}

=46or this machine, =EF=BB=BF\_SB._INI must be run before =EF=BB=BF\_SB=
_.PCI0.LPCB.EC0_._REG

But currently early EC _REG method is run before _INI as below acpi_bus=
_init shows.

void __init acpi_bus_init(void)
         .....
         status =3D acpi_ec_ecdt_probe();
         /* Ignore result. Not having an ECDT is not fatal. */

         status =3D acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
         .....
}

=EF=BB=BFacpi_ec_ecdt_probe will install ec handler although no ECDT fo=
und in this machine.

Alexey,=20
How about that if there's no ECDT found, we do not install ec handler b=
efore =EF=BB=BFacpi_initialize_objects?

Lin Ming



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
