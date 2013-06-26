From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Re: Backlight dark and wireless button not working on Fujitsu E753
Date: Wed, 26 Jun 2013 11:17:15 +0200
Message-ID: <CAO_aot5vTdwGvnMuvsNZ+kA882WKVMADSUUpqpDRqL5XKtotuw@mail.gmail.com>
References: <CAO_aot70KoE=fvO11HJsg1OW-EGOreNVOcyjb8XsEMmbAbn=Pg@mail.gmail.com>
	<CAOLK0pyPKHJFq+wRJrwBiPvAJiLORfT5jA2FwQ7t1gk8wnn0Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:47917 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab3FZJRQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jun 2013 05:17:16 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so1364302qab.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2013 02:17:15 -0700 (PDT)
In-Reply-To: <CAOLK0pyPKHJFq+wRJrwBiPvAJiLORfT5jA2FwQ7t1gk8wnn0Gg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: linux-acpi@vger.kernel.org

Ok, thanks,
Here is a link FYI: https://bugzilla.kernel.org/show_bug.cgi?id=60161
However, acpidump does not give any useful output: "Linux version not
implemented yet"

Regards,

jhs

2013/6/25 Lan Tianyu <lantianyu1986@gmail.com>:
> 2013/6/25 Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
>>
>> Hi,
>>
>> on my Fujitsu Lifebook E753 I experienced some "regressions" with
>> current kernel versions compared to linux 3.5 (used in Ubuntu 12.04
>> for instance):
>> - on bootup backlight is extremely dark (I can change it though)
>> - the wireless button does not work any more
>> Today I did a bisect and found out, that the "regression" was
>> introduced with commit "a57f7f9175b8ccbc9df83ac13860488913115de4".
>> Searching the internet I read about a bootloader option
>> "acpi_osi="!Windows 2012" which solved the issue for me.
>> If you want/need some further information for a patch just tell me. I
>> don't have any insight into ACPI escpecially the new Windows8 changes
>> so if you can't do anything about it I apologize for the noise.
>>
> HI:
>        Could you apply a bug on the https://bugzilla.kernel.org with the
> output of  acpidump?
>
>> Regards
>>
>> jhs
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Best regards
> Tianyu Lan
