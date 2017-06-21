From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [v3] ACPI / PMIC: xpower: Add support for the GPI1 regulator to
 the OpRegion handler
Date: Wed, 21 Jun 2017 17:27:18 +0200
Message-ID: <CAJZ5v0hSSRpqk8-yEZ3OozK1V=LO-y5d0OUiNS2V-0bs0qK52Q@mail.gmail.com>
References: <20170514213539.20231-1-hdegoede@redhat.com> <3aaa700d-168a-9f4e-bf1b-06e3694359a8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38728 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFUQaN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2017 12:30:13 -0400
Received: by mail-it0-f42.google.com with SMTP id b205so6395828itg.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2017 09:30:13 -0700 (PDT)
In-Reply-To: <3aaa700d-168a-9f4e-bf1b-06e3694359a8@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jun 21, 2017 at 3:27 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 14-05-17 23:35, Hans de Goede wrote:
>>
>> Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
>> their 0x8d power OpRegion, add support for this.
>>
>> This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
>> fixes these errors causing these devices to not suspend.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> Changes in v2:
>> -Simplify reg == 0x92 handling (suggested by Andy Shevchenko)
>> -Add special handling for reg == 0x92 to intel_xpower_pmic_get_power() too
>> Changes in v3:
>> -Use defines for GPI1 reg and bits, rather then hardcoded hex values
>
>
> What is the status of this patch ? AFAICT this patch has not been
> merged yet, even though it has a Reviewe-by.
>
> Note this patch is necessary to fix suspend/resume on some devices,
> as such it would be nic if we can get this merged soon.

It will go into 4.13, sorry for the delay.

Thanks,
Rafael
