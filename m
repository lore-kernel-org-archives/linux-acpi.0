From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Re: Backlight dark and wireless button not working on Fujitsu E753
Date: Thu, 13 Feb 2014 10:03:42 +0100
Message-ID: <CAO_aot4X84XDptXmxPdgYxWwzPXh1b9aEJY=CB-UUaEhYFSRSg@mail.gmail.com>
References: <CAO_aot70KoE=fvO11HJsg1OW-EGOreNVOcyjb8XsEMmbAbn=Pg@mail.gmail.com>
	<CAOLK0pyPKHJFq+wRJrwBiPvAJiLORfT5jA2FwQ7t1gk8wnn0Gg@mail.gmail.com>
	<CAO_aot5vTdwGvnMuvsNZ+kA882WKVMADSUUpqpDRqL5XKtotuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:60873 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbaBMJDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2014 04:03:43 -0500
Received: by mail-vb0-f51.google.com with SMTP id j16so2241561vbh.10
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2014 01:03:42 -0800 (PST)
In-Reply-To: <CAO_aot5vTdwGvnMuvsNZ+kA882WKVMADSUUpqpDRqL5XKtotuw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,
I'd like to ask again about the wireless key problem. First I was
told, that the fujitsu_laptop module would be responsible for this,
but recently I looked into this again and discovered, that it made no
difference whether the module was loaded or not. When booting with
"acpi_osi="!Windows 2012" the key would work. It still does not work
without the boot option though.
I found a bug report at launchpad
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1159690) where
several users with laptops from different manufacturers (Asus, HP,
Fujitsu) report the same problem. So I'd conclude this has nothing to
do with fujitsu_laptop, has it?
Is there anything that could be done about this or do I simply have to
stay with the named boot option?

Regards,

jhs


2013-06-26 11:17 GMT+02:00 Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>:
> Ok, thanks,
> Here is a link FYI: https://bugzilla.kernel.org/show_bug.cgi?id=60161
> However, acpidump does not give any useful output: "Linux version not
> implemented yet"
>
> Regards,
>
> jhs
>
> 2013/6/25 Lan Tianyu <lantianyu1986@gmail.com>:
>> 2013/6/25 Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
>>>
>>> Hi,
>>>
>>> on my Fujitsu Lifebook E753 I experienced some "regressions" with
>>> current kernel versions compared to linux 3.5 (used in Ubuntu 12.04
>>> for instance):
>>> - on bootup backlight is extremely dark (I can change it though)
>>> - the wireless button does not work any more
>>> Today I did a bisect and found out, that the "regression" was
>>> introduced with commit "a57f7f9175b8ccbc9df83ac13860488913115de4".
>>> Searching the internet I read about a bootloader option
>>> "acpi_osi="!Windows 2012" which solved the issue for me.
>>> If you want/need some further information for a patch just tell me. I
>>> don't have any insight into ACPI escpecially the new Windows8 changes
>>> so if you can't do anything about it I apologize for the noise.
>>>
>> HI:
>>        Could you apply a bug on the https://bugzilla.kernel.org with the
>> output of  acpidump?
>>
>>> Regards
>>>
>>> jhs
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>> Best regards
>> Tianyu Lan
