From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ACPICA: use designated initializers
Date: Wed, 29 Mar 2017 14:16:50 -0700
Message-ID: <CAGXu5jJk2+_r_72B=yqz9=s=S3VY6v8o7jis7e6YMhy2tSJgHw@mail.gmail.com>
References: <20161217010425.GA140581@beast> <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 18, 2016 at 10:06 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: Kees Cook [mailto:keescook@chromium.org]
>> Subject: [PATCH] ACPICA: use designated initializers
>>
>> Prepare to mark sensitive kernel structures for randomization by making
>> sure they're using designated initializers. These were identified during
>> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
>> extracted from grsecurity.
>
> This commit is not suitable for ACPICA upstream.
> It's not portable. Please drop.

What compilers are building this that do not support designated
initializers? Also, couldn't this be made into a macro so it could be
supported in either case?

#ifdef __GNUC__
# define ACPI_SLEEP_FUNCTIONS(legacy, extended) { \
    .legacy_function = legacy, \
    .extended_function = extended, \
}
#else
# define ACPI_SLEEP_FUNCTIONS(legacy, extended) { legacy, extended }
#endif

...

 static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
        ACPI_SLEEP_FUNCTIONS(
               ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
               acpi_hw_extended_sleep),
...


-Kees

>
> Thanks
> Lv
>
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
>> index f76e0eab32b8..25cd5c66e102 100644
>> --- a/drivers/acpi/acpica/hwxfsleep.c
>> +++ b/drivers/acpi/acpica/hwxfsleep.c
>> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
>>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
>>
>>  static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
>> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
>> -      acpi_hw_extended_sleep},
>> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
>> -      acpi_hw_extended_wake_prep},
>> -     {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extended_wake}
>> +     { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
>> +       .extended_function = acpi_hw_extended_sleep },
>> +     { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
>> +       .extended_function = acpi_hw_extended_wake_prep },
>> +     { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
>> +       .extended_function = acpi_hw_extended_wake }
>>  };
>>
>>  /*
>> --
>> 2.7.4
>>
>>
>> --
>> Kees Cook
>> Nexus Security



-- 
Kees Cook
Pixel Security
