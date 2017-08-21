From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 14:25:02 +0200
Message-ID: <CAJZ5v0i_-Sb_o24EcmHN37cQ3fqVf53a+Yc_weX_1Mv7VAOw3g@mail.gmail.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com> <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:37435 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdHUMZD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2017 08:25:03 -0400
In-Reply-To: <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Aug 21, 2017 at 1:27 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Aug 18, 2017 at 01:46:40PM -0600, Toshi Kani wrote:
>> ACPI OEM ID / OEM Table ID / Revision can be used to identify
>> a platform based on ACPI firmware info.  acpi_blacklisted(),
>> intel_pstate_platform_pwr_mgmt_exists(), and some other funcs,
>> have been using similar check to detect a list of platforms
>> that require special handlings.
>>
>> Move the platform check in acpi_blacklisted() to a new common
>> utility function, acpi_match_platform_list(), so that other
>> drivers do not have to implement their own version.
>>
>> There is no change in functionality.
>>
>> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Borislav Petkov <bp@alien8.de>
>> ---
>>  drivers/acpi/blacklist.c |   83 ++++++++--------------------------------------
>>  drivers/acpi/utils.c     |   40 ++++++++++++++++++++++
>>  include/linux/acpi.h     |   19 +++++++++++
>>  3 files changed, 73 insertions(+), 69 deletions(-)
>
> ...
>
>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>> index b9d956c..998aaf5 100644
>> --- a/drivers/acpi/utils.c
>> +++ b/drivers/acpi/utils.c
>> @@ -816,3 +816,43 @@ static int __init acpi_backlight(char *str)
>>       return 1;
>>  }
>>  __setup("acpi_backlight=", acpi_backlight);
>> +
>> +/**
>> + * acpi_match_platform_list - Check if the system matches with a given list
>> + * @plat: pointer to acpi_platform_list table terminated by a NULL entry
>> + *
>> + * Return the matched index if the system is found in the platform list.
>> + * Otherwise, return a negative error code.
>> + */
>> +int acpi_match_platform_list(const struct acpi_platform_list *plat)
>> +{
>> +     struct acpi_table_header hdr;
>> +     int idx = 0;
>> +
>> +     if (acpi_disabled)
>> +             return -ENODEV;
>
> Btw, Rafael, should we do something like this:
>
> diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
> index 010b1c43df92..881b0d5b2838 100644
> --- a/drivers/acpi/acpica/tbxface.c
> +++ b/drivers/acpi/acpica/tbxface.c
> @@ -226,6 +226,9 @@ acpi_get_table_header(char *signature,
>         u32 j;
>         struct acpi_table_header *header;
>
> +       if (acpi_disabled)
> +               return (AE_ERROR);
> +
>         /* Parameter validation */
>
>         if (!signature || !out_table_header) {
> ---
>
> in order to avoid that sprinkling of if (acpi_disabled) everywhere?

Yes, let's catch this as early as possible.

Thanks,
Rafael
