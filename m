From: Jeff Wu <zlinuxkernel@gmail.com>
Subject: Re: [PATCH] ACPI:add _STA evaluating at do_acpi_find_child()
Date: Fri, 24 May 2013 16:22:19 +0800
Message-ID: <CAPb2CANbHikhbp3Hu+nqDwxLhS3hc687khyw8rWU=ivoXh3j1A@mail.gmail.com>
References: <1369135173-4457-1-git-send-email-jeff.wu@amd.com>
	<2230710.zxq3zIVHyr@vostro.rjw.lan>
	<CAOLK0pxMgxBA8rwMTDXxZYq6uX6zpBXOpCPK=jpAwEybbV5yOQ@mail.gmail.com>
	<1904822.ijPZMuCUgG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57106 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3EXIWU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2013 04:22:20 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so11222702ief.40
        for <linux-acpi@vger.kernel.org>; Fri, 24 May 2013 01:22:19 -0700 (PDT)
In-Reply-To: <1904822.ijPZMuCUgG@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Lan Tianyu <lantianyu1986@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lekensteyn@gmail.com, Sergio Perez <dagobertstaler@gmail.com>, shane.huang@amd.com, Aaron Lu <aaron.lwe@gmail.com>

2013/5/24 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, May 23, 2013 08:56:32 PM Lan Tianyu wrote:
>> 2013/5/23 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Wednesday, May 22, 2013 03:42:04 PM Jeff Wu wrote:
>> >> 2013/5/22 Lan Tianyu <lantianyu1986@gmail.com>:
>> >> > 2013/5/22 Jeff Wu <zlinuxkernel@gmail.com>:
>> >> >> 2013/5/21 Lan Tianyu <lantianyu1986@gmail.com>:
>> >> >>>> From: Jeff Wu <zlinuxkernel@gmail.com>
>> >> >>> Will this affect other devices? Since the device maybe disabled during
>> >> >>> do binding with ACPI.
>> >> >>> After some operations, the device would be enabled.
>> >> >> At our platforms, DEV1 use for win8,DEV2 use for win7,DEV1 use for Linux.
>> >> >> If these devices are disabled when do init, they will always be
>> >> >> disabled ,so, work fine.
>> >> >>
>> >> >> At some of the platforms, the devices may be disabled during do the
>> >> >> first binding ,if their status are changed,do they not do re-binding ?
>> >> > Currently, the glue binding operation takes place when the device  is
>> >> > created. In my mind, there is no re-binding operation after the device being
>> >> > created, Unless the device being removed and created again.
>> >> Thank you very much.
>> >> So, as your suggestion, it is a better solution to add a new function
>> >> for the same _ADR devices,
>> >
>> > I don't really think this is a good idea, because then it won't be clear when
>> > to use which version.
>> Ok. How about make them as one function?.
>> New function will return all the children's handle with same _ADR and the number
>> of children. The caller should check the number. If the number is 1 and then
>> do eveything that now have done. If the number is larger than 1. It should
>> select one according their strategy.
>
> Why do you think that the callers may have different strategies?  They are
> subsystems, not drivers.
>
>> There is another such issue. In this case, the first child should be selected.
>> http://www.spinics.net/lists/linux-acpi/msg39739.html
>
> No, that's about something different.

Thanks, Rafel and Lan,TianYu

>
> Thanks,
> Rafael
>
>
>> > Your patch kind of makes sense (although we don't need to initialize both
>> > local variables to 0), but the Tianyu's concern is valid in principle either.
>> >
>> > Perhaps it would be better to make do_acpi_find_child() return the disabled
>> > device if its the only one matching or the first enabled matching device
>> > otherwise?
>> >
>> > Rafael
>> >
>> >
>>
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
