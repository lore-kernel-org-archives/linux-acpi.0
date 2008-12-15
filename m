From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Bug 11884 - _REG and _INI
Date: Mon, 15 Dec 2008 12:26:56 +0300
Message-ID: <494622E0.4020600@suse.de>
References: <1229313063.19540.86.camel@minggr.sh.intel.com> <1229326070.3991.7.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50812 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbYLOJ1A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Dec 2008 04:27:00 -0500
In-Reply-To: <1229326070.3991.7.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Zhao Yakui wrote:
> On Mon, 2008-12-15 at 11:51 +0800, Lin Ming wrote:
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D11884=20
>>
>> Method(\_SB._INI)
>> {
>> 	//initialize package CUZO
>> }
>>
>> Method(\_SB_.PCI0.LPCB.EC0_._REG)
>> {
>> 	//access package CUZO
>> }
>>
>> For this machine, =EF=BB=BF\_SB._INI must be run before =EF=BB=BF\_S=
B_.PCI0.LPCB.EC0_._REG
>>
>> But currently early EC _REG method is run before _INI as below acpi_=
bus_init shows.
>>
>> void __init acpi_bus_init(void)
>>          .....
>>          status =3D acpi_ec_ecdt_probe();
>>          /* Ignore result. Not having an ECDT is not fatal. */
>>
>>          status =3D acpi_initialize_objects(ACPI_FULL_INITIALIZATION=
);
>>          .....
>> }
>>
>> =EF=BB=BFacpi_ec_ecdt_probe will install ec handler although no ECDT=
 found in this machine.
>>
>> Alexey,=20
>> How about that if there's no ECDT found, we do not install ec handle=
r before =EF=BB=BFacpi_initialize_objects?
>=20
> I do some test with the help of KVM. In my test the ECDT table is
> defined. And there also exists the EC device in DSDT table.Of course
> there exists the _INI/_REG object under the scope of EC device. Under
> the scope of \_SB.PCI0 there exists the _INI/_REG object.
>=20
>>From the test result it seems that all the _INI objects are evaluated
> before _REG object even when there exists the ECDT table.
>=20
> Hi, Alexey
>     Can the Lin Ming's proposal be considered based on the above test=
?=20
Hi Yakui,
His proposal needs to be considered even without your test (but the tes=
t itself is quite helpful),=20
just because HP does not violate the ACPI spec, but ASUS notebooks with=
out ECDT do violate it=20
(and fake ECDT workaround is there for them).

Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
