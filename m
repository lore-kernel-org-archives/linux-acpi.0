From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: Suspend/resume regression between 2.6.26 and 2.6.27-rc1
Date: Thu, 16 Oct 2008 10:39:47 +0100
Message-ID: <48F70BE3.1050009@tuffmail.co.uk>
References: <1223625973.2735.142.camel@rzhang-dt>	 <200810101441.14123.rjw@sisk.pl> <1224143818.3944.68.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:30271 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYJPJj5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 05:39:57 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1151857eyi.37
        for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2008 02:39:55 -0700 (PDT)
In-Reply-To: <1224143818.3944.68.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, mingo@elte.hu

Zhao Yakui wrote:
> On Fri, 2008-10-10 at 14:41 +0200, Rafael J. Wysocki wrote:
>> On Friday, 10 of October 2008, Zhang Rui wrote:
>>> Hi, len,
>>>
>>> this is the ACPI regression test result based on the latest ACPI te=
st branch.
>>>
>>> 1. on =EF=BB=BFAcer:(AMD CPU, VIA chipset. 64 bit kernel)
>>> =EF=BB=BFWhen doing S3 test, after pressing the power button, the s=
ystem
>>> reboots instead of resuming. But if S3 is done after S4, the system=
 can
>>> resume very well after pressing power button or using the RTC
>>> alarm.
>>> Note that this is an upstream regression as it can be reproduced on
>>> linus' tree.
>>> Yakui is investigating this issue.
>> We had some reports of the second suspend (S3) failure too, where th=
e second
>> attempt to suspend to RAM (or to resume from it) failed after a succ=
essful
>> one.  I wonder if that's related.
> Some suspend/resume tests are done on one Acer laptop(AMD CPU, VIA
> chipset, 64-bit kernel).
>    The system will be rebooted when pressing power button after the b=
ox
> enters S3 state. But if S3 is done after doing S4, the system can be
> resumed very well after pressing power button.This issue can be
> reproduced on the upstream kernel.
>=20
> After the further test we can confirm that this is a regression. The
> 2.6.26 kernel can work well on this box. But the 2.6.27-rc1 will fail=
=2E
>=20
> After using the git-bisect it is confirmed that the commit
> 736f12bff9d9e7b4e895c64f73b190c8383fc2a1 is good.=20
>     >commit 736f12bff9d9e7b4e895c64f73b190c8383fc2a1
>     >Author: Glauber Costa <gcosta@redhat.com>
>     > Date:   Tue May 27 20:14:51 2008 -0700
>        >x86: don't use gdt_page openly.
>=20
> And the commit=20
> 55f262391a2365d657a00ed68edd1a51bca66af5 is bad.=20
>    >commit 55f262391a2365d657a00ed68edd1a51bca66af5
>    >Author: Yinghai Lu <yhlu.kernel@gmail.com>
>    >Date:   Wed Jun 25 17:54:23 2008 -0700
>     >x86: rename setup_32.c to setup.c
>=20
>   The patches between the above two commits are related with X86. Whe=
n
> using git-bisect between the above two commits, we will get the
> compiling errors(For example: some files don't exist) or the kernel
> panic. So we can't continue using git-bisect to identify which commit
> the regression is caused by.

There's a known fix for the kernel panic.  It's referenced at <http://b=
ugzilla.kernel.org/show_bug.cgi?id=3D11237#c25>.  That should help you =
bisect down to a smaller range.  Hopefully you can rule out the commit =
that caused^Wexposed Bug #11237, which is really a nasty BIOS bug.

HTH
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
