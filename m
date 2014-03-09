From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [regression] linux-3.14.0-rc5-.. kernel does not switch power off
Date: Sun, 9 Mar 2014 18:34:05 +0100
Message-ID: <CADDKRnBpJiN2ayrHpx6K04Lan2S-tnH9nLg4LK=dOkAKVLbp3g@mail.gmail.com>
References: <CADDKRnCTBiGC2fkd1Utp7BY7vjORcHh4O9GgqfMP7iDfFkNKuw@mail.gmail.com>
	<4129487.hPye7CfaJv@vostro.rjw.lan>
	<4824481.V0Gqxh5Nec@vostro.rjw.lan>
	<34025658.DfioqOCCn3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:57729 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaCIReH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Mar 2014 13:34:07 -0400
In-Reply-To: <34025658.DfioqOCCn3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

2014-03-09 18:15 GMT+01:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Sunday, March 09, 2014 05:58:59 PM Rafael J. Wysocki wrote:
>> On Sunday, March 09, 2014 05:55:28 PM Rafael J. Wysocki wrote:
>> > On Sunday, March 09, 2014 05:12:56 PM J=C3=B6rg Otte wrote:
>> > > On shutdown power is not switched off. The harddisk is already d=
own.
>> > > Reboot is working.
>> > >
>> > > Last known good kernel is: 3.14.0-rc5-00265-gb01d4e6
>> > > First known bad kernel is: 3.14.0-rc5-00287-gca62eec
>> >
>> > Can you please tell me which commits those two kernels correspond =
to?
>>
>> And please post a boot log from the failing one.
>
> Never mind, I know what the problem is, commit 3130497f5bab (ACPI / s=
leep:
> pm_power_off needs more sanity checks to be installed) has to be reve=
rted.
>
> Sorry about the breakage and I'll send a revert patch shortly.
>
> Rafael
>

Works for me, thanks!
J=C3=B6rg
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
