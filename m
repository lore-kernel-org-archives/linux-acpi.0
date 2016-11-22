From: AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH] ACPI: Override rev for DELL Latitude 3350
Date: Tue, 22 Nov 2016 10:51:05 +0800
Message-ID: <CAFv23Q=_QxSk-hp_7ByqJrXASYP8G5c2vVamicizX-byxNdOQg@mail.gmail.com>
References: <1479694025-13372-1-git-send-email-acelan.kao@canonical.com> <1714152.bx2Aa0D83s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36697 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbcKVCvG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2016 21:51:06 -0500
Received: by mail-qk0-f173.google.com with SMTP id n21so5964705qka.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Nov 2016 18:51:06 -0800 (PST)
In-Reply-To: <1714152.bx2Aa0D83s@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

Hi Rafael,

The patch you mentioned is pretty the same as mine,
I'm happy to see that patch goes into upstream.
Please keep doing this, thanks.

Best regards,
AceLan Kao.


2016-11-22 6:43 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Monday, November 21, 2016 10:07:05 AM AceLan Kao wrote:
>> The ethernet network fails to work on DELL Latitude 3350 after this commit
>>    ea7d521 Revert 'Revert "ACPICA: Permanently set _REV to the value '2'."'
>>
>> dmesg shows
>>    r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>>    r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>>    pci 0000:00:1c.2: PCI INT C: failed to register GSI
>>    pci 0000:00:1c.2: Error enabling bridge (-16), continuing
>>    r8169 0000:03:00.0: PCI INT A: failed to register GSI
>>    r8169 0000:03:00.0 (unnamed net_device) (uninitialized): enable failure
>>    r8169: probe of 0000:03:00.0 failed with error -16
>>
>> So override the ACPI _REV for this machine to fix the issue.
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>
> I have something similar queued up in linux-next.  Care to look at that?
>
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=708f5dcc21ae9b35f395865fc154b0105baf4de4
>
>> ---
>>  drivers/acpi/blacklist.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>> index bdc67ba..a8c10f2 100644
>> --- a/drivers/acpi/blacklist.c
>> +++ b/drivers/acpi/blacklist.c
>> @@ -160,6 +160,14 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
>>                     DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
>>               },
>>       },
>> +     {
>> +      .callback = dmi_enable_rev_override,
>> +      .ident = "DELL Latitude 3350",
>> +      .matches = {
>> +                   DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +                   DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3350"),
>> +             },
>> +     },
>>  #endif
>>       {}
>>  };
>>
>
> Thanks,
> Rafael
>
