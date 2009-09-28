From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [git pull request] ACPI & driver patches for Linux-2.6.32-rc0
Date: Tue, 29 Sep 2009 02:12:59 +0400
Message-ID: <4AC134EB.1050705@suse.de>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain> <4ABCB2CA.4020709@mandriva.org> <d3f22a0909261902o5e48c2a0lab56fca21edf8c5b@mail.gmail.com> <1254016503.17697.21.camel@minggr.sh.intel.com> <alpine.LFD.2.00.0909270348570.16783@localhost.localdomain> <4AC11A0F.2030806@mandriva.org> <4AC12015.4040508@suse.de> <4AC12B4D.30508@mandriva.org> <4AC12E51.8050501@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36918 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbZI1WM6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2009 18:12:58 -0400
In-Reply-To: <4AC12E51.8050501@mandriva.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Thomas Backlund =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Thomas Backlund wrote:
>> Alexey Starikovskiy wrote:
>>> Thomas Backlund =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> Now this is a Acer TravelMate 5720G laptop with the latest 1.35 bi=
os.
>>>> Distro is Mandriva Linux Cooker, and arch is x86_64
>>>>
>>>> Attached is output of "grep ACPI /var/log/dmesg"
>>>> dmesg-acpi-20090903
>>>> - all acpi patches as of 2.6.32-rc1
>>> This one does not have errors you've mentioned earlier, could you=20
>>> find dmesg with them?
>>
>> Ah, sorry about that...
>> I should have done dmesg|grep ACPI to get the errors... it would hav=
e=20
>> shown this too:
>> tg3 0000:02:00.0: wake-up capability disabled by ACPI
>> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl]=20
>> (20090903/evregion-424)
>> ACPI Error (psparse-0537): Method parse/execution failed=20
>> [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
>> ACPI Error (psparse-0537): Method parse/execution failed=20
>> [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
>> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
>>
>>
>>
>>>> dmesg-acpi-20090903-ec-2.6.31
>>>> - all acpi patches as of 2.6.32-rc1
>>>> - ec.c from 2.6.31.1
>>>>
>>>>
>>>> Should I start bisecting, or do you have any other suggestion?
>>> There is only one patch which touch ec.c,=20
>>> 2a84cb9852f52c0cd1c48bca41a8792d44ad06cc. You may try to revert it,=
=20
>>> and see.
>>>
>>
>> Isn't that what pretty much what I did when I built a kernel with th=
e=20
>> 2.6.31.1 ec.c ?
>>
>> Anyway, after I applied your patch you just posted on acpi-devel:
>> ACPI: EC: Rewrite DMI checks
>>
>> to the 2.6.32-rc1 tree the:
>>
>>> -ACPI Error (psargs-0359): [\_PR_.CPU0.CSTX] Namespace lookup=20
>>> failure, AE_NOT_FOUND
>>> -ACPI Error (psparse-0537): Method parse/execution failed=20
>>> [\_SB_.PCI0.LPCB.EC0_._Q2F] (Node ffff88013f81c1a0), AE_NOT_FOUND
>>
>> does not show up at boot anymore, and so far I haven't seen the othe=
r=20
>> errors either...
>>
>> I'll post a follow-up if they show up again...
>>
>=20
> Bah...
> I spoke too soon:
>=20
Could you please turn on timing information in printk ?=20
Please also uncomment "#define DEBUG" in ec.c

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
