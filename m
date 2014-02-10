From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Mon, 10 Feb 2014 09:47:30 +0700
Message-ID: <CADnvcfLfJUPRZZ-uBk1=mb9a+63CaOX+M+M1osuUYDzyAA=qBg@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
	<CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
	<CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
	<CAOLK0pxeQN5gtr1qckdp+Y2Mbi8yih2U1_hQFedm18K4Mzw6_A@mail.gmail.com>
	<CADnvcf+7T8qDeRhwbwhmja9N1HeAzfF_oDSBpnUX59NTCRmkAg@mail.gmail.com>
	<CAOLK0pwE5m1RUOnnUTNQVHFB6WAcgvfR5twZCHDbvuOwZN_aNQ@mail.gmail.com>
	<CAOLK0pzjXyHh1ga1TwN9JWepUnNzqwRym9Sa5Rt3XF2et6DwpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39703 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbaBJCrb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Feb 2014 21:47:31 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so5605142pad.0
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 18:47:31 -0800 (PST)
In-Reply-To: <CAOLK0pzjXyHh1ga1TwN9JWepUnNzqwRym9Sa5Rt3XF2et6DwpA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-10 9:34 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
> 2014-02-10 Lan Tianyu <lantianyu1986@gmail.com>:
>> 2014-02-10 10:16 GMT+08:00 Alexander Mezin <mezin.alexander@gmail.com>:
>>> 2014-02-10 8:29 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>>>>> 2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>>>> Hi:
>>>>        What's the benefit of the second patch without this patch?
>>>> So far, bios sends the ACPI notify event of power change to AC driver and
>>>> the driver would change status and send uevent. That seems enough.
>>> Without second patch AC adapter's status isn't updated on my laptop.
>>
>> commit 50a2bc5429f can't fix this issue.
> Sorry. commit 50a2bc5429f can't fix this issue?
No, it doesn't solve the problem. But before it AC state didn't update
even when I run "acpi -a". There was no way other than reboot.
