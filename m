From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Mon, 10 Feb 2014 11:15:27 +0800
Message-ID: <CAOLK0pxqobCw7Qhz4MRavFmyKf0SjAddMACTj6W5j5ZXBHKx1A@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
	<CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
	<CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
	<CAOLK0pxeQN5gtr1qckdp+Y2Mbi8yih2U1_hQFedm18K4Mzw6_A@mail.gmail.com>
	<CADnvcf+7T8qDeRhwbwhmja9N1HeAzfF_oDSBpnUX59NTCRmkAg@mail.gmail.com>
	<CAOLK0pwE5m1RUOnnUTNQVHFB6WAcgvfR5twZCHDbvuOwZN_aNQ@mail.gmail.com>
	<CAOLK0pzjXyHh1ga1TwN9JWepUnNzqwRym9Sa5Rt3XF2et6DwpA@mail.gmail.com>
	<CADnvcfLfJUPRZZ-uBk1=mb9a+63CaOX+M+M1osuUYDzyAA=qBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:53405 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaBJDP1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Feb 2014 22:15:27 -0500
Received: by mail-qc0-f172.google.com with SMTP id c9so9778933qcz.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 19:15:27 -0800 (PST)
In-Reply-To: <CADnvcfLfJUPRZZ-uBk1=mb9a+63CaOX+M+M1osuUYDzyAA=qBg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-10 Alexander Mezin <mezin.alexander@gmail.com>:
> 2014-02-10 9:34 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>> 2014-02-10 Lan Tianyu <lantianyu1986@gmail.com>:
>>> 2014-02-10 10:16 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
>>>> 2014-02-10 8:29 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>>> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>>>>>> 2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>>> Hi:
>>>>>        What's the benefit of the second patch without this patch?
>>>>> So far, bios sends the ACPI notify event of power change to AC driver and
>>>>> the driver would change status and send uevent. That seems enough.
>>>> Without second patch AC adapter's status isn't updated on my laptop.
>>>
>>> commit 50a2bc5429f can't fix this issue.
>> Sorry. commit 50a2bc5429f can't fix this issue?
> No, it doesn't solve the problem. But before it AC state didn't update
> even when I run "acpi -a". There was no way other than reboot.

Ok. You mean AC state didn't update before running "acpi -a" with commit
50a2bc5429f, right?

How do you check the AC state? via /sys/class/power_supply/ACXX/online?

What does acpi_listen show when plug or unplug adaptor?

-- 
Best regards
Tianyu Lan
