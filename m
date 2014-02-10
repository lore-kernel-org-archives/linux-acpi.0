From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Tue, 11 Feb 2014 01:34:29 +0700
Message-ID: <CADnvcf+F1AmL4BNsGAhxObrgnSDm+_Nnrtg7TwnKtv9oyxYzdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:49431 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaBJSea (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 13:34:30 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so6598158pbb.34
        for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2014 10:34:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?6JOd5aSp5a6H?= <lantianyu1986@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Sorry, I've pressed wrong "Reply" button

---------- Forwarded message ----------
From: Alexander Mezin <mezin.alexander@gmail.com>
Date: 2014-02-10 16:38 GMT+07:00
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
To: Lan Tianyu <lantianyu1986@gmail.com>


2014-02-10 10:15 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
> 2014-02-10 Alexander Mezin <mezin.alexander@gmail.com>:
>> 2014-02-10 9:34 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>> 2014-02-10 Lan Tianyu <lantianyu1986@gmail.com>:
>>>> 2014-02-10 10:16 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
>>>>> 2014-02-10 8:29 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>>>> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>>>>>>> 2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>>>> Hi:
>>>>>>        What's the benefit of the second patch without this patch?
>>>>>> So far, bios sends the ACPI notify event of power change to AC driver and
>>>>>> the driver would change status and send uevent. That seems enough.
>>>>> Without second patch AC adapter's status isn't updated on my laptop.
>>>>
>>>> commit 50a2bc5429f can't fix this issue.
>>> Sorry. commit 50a2bc5429f can't fix this issue?
>> No, it doesn't solve the problem. But before it AC state didn't update
>> even when I run "acpi -a". There was no way other than reboot.
>
> Ok. You mean AC state didn't update before running "acpi -a" with commit
> 50a2bc5429f, right?
No. I mean AC state didn't update when I run "acpi -a", before I made commit
50a2bc5429f. Or maybe I just don't understand you.
>
> How do you check the AC state? via /sys/class/power_supply/ACXX/online?
No. I check it by looking at KDE's power manager icon. Reading
/sys/class/power_supply/AC/online has the same effect as "acpi -a"
(without 50a2bc5429f state doesn't update, with 50a2bc5429f - state updates,
and power manager also gets the notification).
Also, I checked it using UPower dbus interface and qbus.
The same results as with power manager.
>
> What does acpi_listen show when plug or unplug adaptor?
With second patch ("ACPI / battery: check AC adapter's state when
battery state changes"):
battery PNP0C0A:00 00000001 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
ac_adapter ACPI0003:00 00000000 00000000
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000000 00000001
battery PNP0C0A:00 00000080 00000001
 PNP0C14:00 00000080 00000000
processor LNXCPU:00 00000082 00000000
battery PNP0C0A:00 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000001

Without the patch - the same, but without lines starting with "ac_adapter".
