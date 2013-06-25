From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: Backlight dark and wireless button not working on Fujitsu E753
Date: Tue, 25 Jun 2013 19:35:21 +0800
Message-ID: <CAOLK0pyPKHJFq+wRJrwBiPvAJiLORfT5jA2FwQ7t1gk8wnn0Gg@mail.gmail.com>
References: <CAO_aot70KoE=fvO11HJsg1OW-EGOreNVOcyjb8XsEMmbAbn=Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61951 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3FYLfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 07:35:22 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so27562238iea.17
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jun 2013 04:35:21 -0700 (PDT)
In-Reply-To: <CAO_aot70KoE=fvO11HJsg1OW-EGOreNVOcyjb8XsEMmbAbn=Pg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Cc: linux-acpi@vger.kernel.org

2013/6/25 Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
>
> Hi,
>
> on my Fujitsu Lifebook E753 I experienced some "regressions" with
> current kernel versions compared to linux 3.5 (used in Ubuntu 12.04
> for instance):
> - on bootup backlight is extremely dark (I can change it though)
> - the wireless button does not work any more
> Today I did a bisect and found out, that the "regression" was
> introduced with commit "a57f7f9175b8ccbc9df83ac13860488913115de4".
> Searching the internet I read about a bootloader option
> "acpi_osi="!Windows 2012" which solved the issue for me.
> If you want/need some further information for a patch just tell me. I
> don't have any insight into ACPI escpecially the new Windows8 changes
> so if you can't do anything about it I apologize for the noise.
>
HI:
       Could you apply a bug on the https://bugzilla.kernel.org with the
output of  acpidump?

> Regards
>
> jhs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
Best regards
Tianyu Lan
