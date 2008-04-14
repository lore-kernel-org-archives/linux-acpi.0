From: Ralf Orlowski <ralf@orle.de>
Subject: Re: Can't get ACPI to work on a Panasonic Toughbook CF-52
Date: Mon, 14 Apr 2008 10:46:45 +0200
Message-ID: <480319F5.1060702@orle.de>
References: <4801D253.40904@orle.de>	 <9D7649D18729DE4BB2BD7B494F7FEDC20122C2F2@pdsmsx415.ccr.corp.intel.com>	 <4802137E.9060804@orle.de> <1208164382.4031.11.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipx20135.ipxserver.de ([80.190.249.2]:1493 "EHLO
	ipx20135.ipxserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807AbYDNIqv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Apr 2008 04:46:51 -0400
In-Reply-To: <1208164382.4031.11.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

Hello,

Zhao Yakui schrieb:
> On Sun, 2008-04-13 at 16:06 +0200, Ralf Orlowski wrote:
>> Hello,
>>
>> sure, that is no problem.
>>
>> Bye Ralf
> Thanks for the info.
> That the system can't be booted in ACPI mode is caused by the broken
> bios. And the bug is caused by the following definition:
>=20
>> Name (ASLB, 0x00) (It is defined in the scope of GFX0 device)
>> OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
> The correct definition should be the following:
> OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)
>=20
>=20
> Now there is another similar bug in the kernel bugzilla.
> http://bugzilla.kernel.org/show_bug.cgi?id=3D9915
>=20
> Will you please try the custom dsdt and see whether the system can be
> booted with acpi enabled?
> How to use the custom DSDT can be found in=20
> http://www.lesswatts.org/projects/acpi/faq.php.
>=20

Thanks for your help.
I just tried the DSDT I downloaded from=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D9915

Now it gets a little bit further when booting with ACPI enabled, but at=
=20
the end it still hangs. :-(

I get several messages "Could not map memory", "AE_NO_MEMORY" and=20
"Method parse/execution failed". And then the boot stops.

Is there a way to write these messages somewhere before the system=20
stops, so that I could post the exact messages here?

But so far I'm still not able to start the system with ACPI enabled. :-=
(


> Thanks.
>=20

Bye

Ralf

>> Zhao, Yakui schrieb:
>>> Will you please try to boot the system with the option of "acpi=3Do=
ff"
>>> and attach the output of acpidump, lspci -vxxx ? Thanks.
>>>
>>> -----Original Message----- From: linux-acpi-owner@vger.kernel.org
>>> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Ralf Orlowsk=
i=20
>>> Sent: 2008=E5=B9=B44=E6=9C=8813=E6=97=A5 17:29 To: linux-acpi@vger.=
kernel.org Subject: Can't
>>> get ACPI to work on a Panasonic Toughbook CF-52
>>>
>>> Hello,
>>>
>>> I just got a new Panasonic Toughbook CF-52. I installed the system
>>> with debian sid and except of the ACPI-Support the system runs fine
>>> under linux. But so far I had no success to get ACPI working on the
>>> system.
>>>
>>> Today I installed kernel version 2.6.25-rc9 on the system, because =
I
>>>  read, there should be a patch included, that make ACPI work on my=20
>>> system. But so far it does not.
>>>
>>> The kernel runs fine with ACPI disabled, but with ACPI enabled the
>>> boot just stops with a message about ACPI interrupts.
>>>
>>> Does anyone know, what I could try, to get ACPI working, or how I
>>> could find out more about the problem to may be help to find a
>>> solution?
>>>
>>> Bye
>>>
>>> Ralf
>>


--=20
Ralf Orlowski                           voice: +49-8134-935781
Hadersried 27a                          car:   +49-173-5239069
85235 Odelzhausen                       mobil: +49-160-8577361
GERMANY                   E-mail: Ralf@orle.de (PGP available)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
