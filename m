From: Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH] acpi: respect const qualifier
Date: Fri, 25 Apr 2014 18:02:22 +0300
Message-ID: <CAGBcZGc0vQG2W3-q2uLGLHSCm2jNXuW0EB293GZCkU7LJq8xqg@mail.gmail.com>
References: <1397750006-17463-1-git-send-email-semen.protsenko@linaro.org>
	<3334700.hi79274ifW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:41708 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbaDYPCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 11:02:22 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so2305163igc.2
        for <linux-acpi@vger.kernel.org>; Fri, 25 Apr 2014 08:02:22 -0700 (PDT)
In-Reply-To: <3334700.hi79274ifW@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> This is not a mainline kernel problem, surely?

Correct, this warning is just example of possible issue that can be
occurred because of missing "const" qualifier. Actually I saw this
warning in Linaro ACPI kernel (intended for ARMv8 AArch64
architecture).

But I believe that this issue should be fixed in mainline kernel,
because it can cause the same warning in the future.

On 21 April 2014 23:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, April 17, 2014 06:53:26 PM Semen Protsenko wrote:
>> This patch fixes next warning:
>>
>> <------------------------------- cut here --------------------------=
------->
>> drivers/acpi/property.c: In function =E2=80=98acpi_free_properties=E2=
=80=99:
>> drivers/acpi/property.c:35:2: warning: passing argument 1 of =E2=80=98=
acpi_os_free=E2=80=99
>>                               discards =E2=80=98const=E2=80=99 quali=
fier from pointer
>>                               target type [enabled by default]
>>
>>   ACPI_FREE(adev->properties);
>> <------------------------------- cut here --------------------------=
------->
>
> This is not a mainline kernel problem, surely?
>
>>
>> The problem is next:
>>
>>  - acpi_free_properties() calls ACPI_FREE(), passing "const *"
>>    parameter to it
>>  - ACPI_FREE() is macro for acpi_os_free()
>>  - acpi_os_free() takes "void *" parameter
>>  - acpi_os_free() calls kfree()
>>  - but kfree() requires "const void *" parameter
>>
>> So acpi_os_free() should require "const void *" parameter as well.
>>
>> Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
>> ---
>>  include/acpi/platform/aclinux.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform=
/aclinux.h
>> index 93c55ed..c6fa763 100644
>> --- a/include/acpi/platform/aclinux.h
>> +++ b/include/acpi/platform/aclinux.h
>> @@ -174,7 +174,7 @@ static inline void *acpi_os_allocate_zeroed(acpi=
_size size)
>>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
>>  #define USE_NATIVE_ALLOCATE_ZEROED
>>
>> -static inline void acpi_os_free(void *memory)
>> +static inline void acpi_os_free(const void *memory)
>>  {
>>       kfree(memory);
>>  }
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
