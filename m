From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: ACPI regression with 3.19+
Date: Tue, 03 Mar 2015 09:32:42 +0800
Message-ID: <54F50F3A.5090508@linux.intel.com>
References: <54F18BD9.8040200@punnoor.de> <1674953.ShOInfAyGW@vostro.rjw.lan> <1425323240.1125.17.camel@gmail.com> <2682430.9eTeHiC8BR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928AbbCCBcq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Mar 2015 20:32:46 -0500
In-Reply-To: <2682430.9eTeHiC8BR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hudd <hedede.l@gmail.com>
Cc: Prakash Punnoor <prakash@punnoor.de>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2015/3/3 6:03, Rafael J. Wysocki wrote:
> On Monday, March 02, 2015 10:07:20 PM Hudd wrote:
>> On Sun, 2015-03-01 at 01:00 +0100, Rafael J. Wysocki wrote:
>>> On Saturday, February 28, 2015 10:35:21 AM Prakash Punnoor wrote:
>>>> This is a multi-part message in MIME format.
>>>> --------------080704070901080904040008
>>>> Content-Type: text/plain; charset=3Dutf-8
>>>> Content-Transfer-Encoding: 7bit
>>>>
>>>> Hallo,
>>>>
>>>> my system won't boot with current GIT kernel (see attached screens=
hot).
>>>> The system seems somewhat frozen (cannot ssh into it), but magic s=
ysrq
>>>> still works. I bisected the problem to commit
>>>> 593669c2ac0fe18baee04a3cd5539a148aa48574.
>>>
>>> Thanks for reporting, we're working on it.
>>
>> Hello folks,
>>
>> I've tried out 4.0-rc1, and it does not boot  on  my  system.   It  =
just
>> freezes without any messages (The only message I see is =E2=80=9CLoa=
ding initial
>> ramdisk=E2=80=9D from GRUB).  I bisected the problem down to the sam=
e commit  as
>> in this  report.
>>
>> # first bad commit: [593669c2ac0fe18baee04a3cd5539a148aa48574]
>> x86/PCI/ACPI: Use common ACPI resource interfaces to simplify implem=
entation
>=20
> So at the moment I'm inclined to revert it.  Clearly, it wasn't thoug=
ht
> through enough, so my suggestion would be to revert it for 4.0 and tr=
y again
> in the next cycle and be more careful this time.
>=20
> Gerry, would it cause problems to happen if I reverted this one?
Hi Rafael,
	I will send out a patch today for this issue. On Thomas
Voegtle's system, the issue is caused by that BIOS report incorrect
length for ACPI address space descriptor. For example,
[    0.761553] acpi: address space [80000000-d0716ffe] len 50717000
[    0.767572] ACPI: invalid or unassigned resource mem
[0000000080000000 - 00000000d0716ffe] length [0000000050717000]

BIOS should report length of 0x50716fff instead of 0x50717000.
So seems we need to relax the length check code to workaround
such bios issues.

Will send out a patch for it soon.
Thanks!
Gerry
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
