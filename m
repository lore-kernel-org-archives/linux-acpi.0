From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bug 11884 - _REG and _INI
Date: Mon, 15 Dec 2008 13:47:14 +0300
Message-ID: <494635B2.60001@gmail.com>
References: <1229313063.19540.86.camel@minggr.sh.intel.com> <1229326070.3991.7.camel@yakui_zhao.sh.intel.com> <494622E0.4020600@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:43464 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYLOKrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Dec 2008 05:47:22 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1450514fkq.5
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2008 02:47:20 -0800 (PST)
In-Reply-To: <494622E0.4020600@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

It's not that simple... Here is relevant part of dmesg from my thinkpad=
:

-----------------------------------------------------------------------=
-
ACPI Error (evregion-0315): No handler for Region [ECOR]=20
(ffff8800bf814558) [EmbeddedControl] [20080926]
ACPI Error (exfldio-0291): Region EmbeddedControl(3) has no handler=20
[20080926]
ACPI Error (psparse-0524): Method parse/execution failed=20
[\_SB_.PCI0.LPC_.EC__._INI] (Node ffff8800bf817300), AE_NOT_EXIST
ACPI: EC: EC description table is found, configuring boot EC
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE =3D 0x1c, I/O: command/status =3D 0x66, data =3D 0x62
ACPI: EC: driver started in interrupt mode
-----------------------------------------------------------------------=
---

Any other suggestions?

Regards,
Alex.

Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
>> On Mon, 2008-12-15 at 11:51 +0800, Lin Ming wrote:
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3D11884
>>> Method(\_SB._INI)
>>> {
>>> //initialize package CUZO
>>> }
>>>
>>> Method(\_SB_.PCI0.LPCB.EC0_._REG)
>>> {
>>> //access package CUZO
>>> }
>>>
>>> For this machine, =EF=BB=BF\_SB._INI must be run before=20
>>> =EF=BB=BF\_SB_.PCI0.LPCB.EC0_._REG
>>>
>>> But currently early EC _REG method is run before _INI as below=20
>>> acpi_bus_init shows.
>>>
>>> void __init acpi_bus_init(void)
>>> .....
>>> status =3D acpi_ec_ecdt_probe();
>>> /* Ignore result. Not having an ECDT is not fatal. */
>>>
>>> status =3D acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
>>> .....
>>> }
>>>
>>> =EF=BB=BFacpi_ec_ecdt_probe will install ec handler although no ECD=
T found=20
>>> in this machine.
>>>
>>> Alexey, How about that if there's no ECDT found, we do not install=20
>>> ec handler before =EF=BB=BFacpi_initialize_objects?
>>
>> I do some test with the help of KVM. In my test the ECDT table is
>> defined. And there also exists the EC device in DSDT table.Of course
>> there exists the _INI/_REG object under the scope of EC device. Unde=
r
>> the scope of \_SB.PCI0 there exists the _INI/_REG object.
>>
>>> From the test result it seems that all the _INI objects are evaluat=
ed
>> before _REG object even when there exists the ECDT table.
>>
>> Hi, Alexey
>> Can the Lin Ming's proposal be considered based on the above test?=20
> Hi Yakui,
> His proposal needs to be considered even without your test (but the=20
> test itself is quite helpful), just because HP does not violate the=20
> ACPI spec, but ASUS notebooks without ECDT do violate it (and fake=20
> ECDT workaround is there for them).
>
> Thanks,
> Alex.
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
