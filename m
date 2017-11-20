From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ACPI / battery: add quirk for Asus GL502VSK and UX305LA
Date: Mon, 20 Nov 2017 16:24:32 +0800
Message-ID: <B100F55A-98C4-47D9-B177-2A5AA7F79A58@canonical.com>
References: <20170922082744.18988-1-kai.heng.feng@canonical.com>
 <CAAd53p7+EOCQyAPkAtUM306p821bqjK_UnD72KRDVYW9uuu9Cg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59825 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKTIYi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Nov 2017 03:24:38 -0500
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1eGhNd-0003qM-Nc
        for linux-acpi@vger.kernel.org; Mon, 20 Nov 2017 08:24:37 +0000
Received: by mail-pf0-f197.google.com with SMTP id i15so8326522pfa.15
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2017 00:24:37 -0800 (PST)
In-Reply-To: <CAAd53p7+EOCQyAPkAtUM306p821bqjK_UnD72KRDVYW9uuu9Cg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


> On 12 Oct 2017, at 1:16 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> On Fri, Sep 22, 2017 at 4:27 PM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> On Asus GL502VSK and UX305LA, ACPI incorrectly reports discharging when
>> battery is full and AC is plugged.
>> 
>> However rate_now is correct under this circumstance, hence we can use
>> "rate_now == 0" as a predicate to report battery full status correctly.
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1482390
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/acpi/battery.c | 29 ++++++++++++++++++++++++++++-
>> 1 file changed, 28 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 13e7b56e33ae..f9f008cf3da7 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -70,6 +70,7 @@ static async_cookie_t async_cookie;
>> static bool battery_driver_registered;
>> static int battery_bix_broken_package;
>> static int battery_notification_delay_ms;
>> +static int battery_full_discharging;
>> static unsigned int cache_time = 1000;
>> module_param(cache_time, uint, 0644);
>> MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
>> @@ -214,7 +215,10 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>                return -ENODEV;
>>        switch (psp) {
>>        case POWER_SUPPLY_PROP_STATUS:
>> -               if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
>> +               if (battery_full_discharging && battery->rate_now == 0 &&
>> +                   battery->state & ACPI_BATTERY_STATE_DISCHARGING)
>> +                       val->intval = POWER_SUPPLY_STATUS_FULL;
>> +               else if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
>>                        val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>                else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>>                        val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> @@ -1166,6 +1170,13 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
>>        return 0;
>> }
>> 
>> +static int __init
>> +battery_full_discharging_quirk(const struct dmi_system_id *d)
>> +{
>> +       battery_full_discharging = 1;
>> +       return 0;
>> +}
>> +
>> static const struct dmi_system_id bat_dmi_table[] __initconst = {
>>        {
>>                .callback = battery_bix_broken_package_quirk,
>> @@ -1183,6 +1194,22 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>>                        DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
>>                },
>>        },
>> +       {
>> +               .callback = battery_full_discharging_quirk,
>> +               .ident = "ASUS GL502VSK",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "GL502VSK"),
>> +               },
>> +       },
>> +       {
>> +               .callback = battery_full_discharging_quirk,
>> +               .ident = "ASUS UX305LA",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "UX305LA"),
>> +               },
>> +       },
>>        {},
>> };
>> 
> 
> Hi,
> 
> Is there any improvement I can make for this patch?

Another gentle ping…

> 
>> --
>> 2.14.1

