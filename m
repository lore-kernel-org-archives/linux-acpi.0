From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: 3.9-rc3+: reports battery as 0 mWh capacity on thinkpad x60
Date: Mon, 25 Mar 2013 22:20:11 +0800
Message-ID: <51505D1B.1050900@gmail.com>
References: <20130323114011.GA11092@amd.pavel.ucw.cz> <87zjxu9spk.fsf@nemi.mork.no> <20130323202155.GC18732@amd.pavel.ucw.cz> <6726347.ehkcE9iAxU@vostro.rjw.lan> <20130324092733.GA3071@amd.pavel.ucw.cz> <514F83F8.9000604@fold.natur.cuni.cz> <CAOLK0pxtpgDdvHFRMDw3791HjWrF0wiheLv4oVW_cg2SVCrLqQ@mail.gmail.com> <515024AF.2040508@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34264 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816Ab3CYOUS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Mar 2013 10:20:18 -0400
In-Reply-To: <515024AF.2040508@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

=E4=BA=8E 2013/3/25 18:19, Martin Mokrejs =E5=86=99=E9=81=93:
> Hi Lan,
>    this is actually a bug of Pavel, he had the problem. I just wanted=
 to show
> him what works on 3.7.10 in my case (yes, different files are on my s=
ystem).
> If you feel the *missing* files are a problem, I can try some newer k=
ernels
> on my computer (Dell Vostro 3550), sure. I am attaching the files any=
way
> but I think 300kB won't make it into the email lists.
> Martin
Hi Martin:
	Thanks for reminder.

Hi  Pavel:
	Could you provide following info and apply a acpi battery
bug on the https://bugzilla.kernel.org? This can help others
to trace the bug.

>> Which version you found the issue? could you provide the
>>output of dmesg on it and acpidump? They will give us more
>>clues since acpi battery driver just exposes data from Bios.


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
