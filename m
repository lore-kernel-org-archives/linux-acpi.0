From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Sat, 8 Feb 2014 15:33:10 +0700
Message-ID: <CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
	<CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44787 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaBHIdL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Feb 2014 03:33:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so4135559pab.5
        for <linux-acpi@vger.kernel.org>; Sat, 08 Feb 2014 00:33:10 -0800 (PST)
In-Reply-To: <CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>> Do the same thing as in acpi_ac_resume.
>>
>> BIOS on my laptop (HP Pavilion dv6-6179er) don't send proper
>> notifications when AC adapter is plugged/unplugged.
>> This change makes it possible to workaround the problem by using
>> acpid and a shell script.
>>
>> This patch has the same effect as
>> commit 50a2bc5429f07ec4d53df2d287b03bdbceb281bb
>> "ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY"
>>
>> Aforementioned commit could be reverted.
>
> Hi Alexander:
>              I don't think the previous commit can be reverted. AC driver
> should get system notify events(E,G bus check event) and  process them.
> Some drivers(E,G radeon) also need to know AC event and AC driver's
> notify handler sends the event to these drivers via block notifier call chain.
> Further more, this patch only works when the related sysfs interfaces are
> accessed. It's redundant with previous commit.

OK, I didn't think about other drivers and so.

Second patch works fine on its own (if old commit isn't reverted, of course),
I've tested it just now. Should I resend it as single patch?
