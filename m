From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Mon, 10 Feb 2014 09:29:21 +0800
Message-ID: <CAOLK0pxeQN5gtr1qckdp+Y2Mbi8yih2U1_hQFedm18K4Mzw6_A@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
	<CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
	<CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:65298 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaBJB3V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Feb 2014 20:29:21 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so9537386qcy.40
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 17:29:21 -0800 (PST)
In-Reply-To: <CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
> 2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
>> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>>> Do the same thing as in acpi_ac_resume.
>>>
>>> BIOS on my laptop (HP Pavilion dv6-6179er) don't send proper
>>> notifications when AC adapter is plugged/unplugged.
>>> This change makes it possible to workaround the problem by using
>>> acpid and a shell script.
>>>
>>> This patch has the same effect as
>>> commit 50a2bc5429f07ec4d53df2d287b03bdbceb281bb
>>> "ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY"
>>>
>>> Aforementioned commit could be reverted.
>>
>> Hi Alexander:
>>              I don't think the previous commit can be reverted. AC driver
>> should get system notify events(E,G bus check event) and  process them.
>> Some drivers(E,G radeon) also need to know AC event and AC driver's
>> notify handler sends the event to these drivers via block notifier call chain.
>> Further more, this patch only works when the related sysfs interfaces are
>> accessed. It's redundant with previous commit.
>
> OK, I didn't think about other drivers and so.
>
> Second patch works fine on its own (if old commit isn't reverted, of course),
> I've tested it just now. Should I resend it as single patch?

Hi:
       What's the benefit of the second patch without this patch?
So far, bios sends the ACPI notify event of power change to AC driver and
the driver would change status and send uevent. That seems enough.

BTW, battery status update normally is also triggered by ACPI notify event.
-- 
Best regards
Tianyu Lan
