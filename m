From: Mike Marshall <hubcap@omnibond.com>
Subject: Re: [RFC PATCH v2] ACPICA / Hardware: Fix old register check in acpi_hw_get_access_bit_width()
Date: Tue, 31 May 2016 10:36:28 -0400
Message-ID: <CAOg9mSQug_WrvgR=u_CDy-+y3nqjzCgOEC=yw+kkoyipB1aA=A@mail.gmail.com>
References: <fa6ead5a123ea7c77caf5f14ee497823574506b7.1464678140.git.lv.zheng@intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB6D12@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB6D12@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Lv...

I was dead in the water before this patch, qemu-kvm would crash
right away, now everything seems to work great again, thanks! From
my perspective this fixes the c3bc26d problem.

Acked-by: Mike Marshall <hubcap@omnibond.com>

-Mike

On Tue, May 31, 2016 at 3:13 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Boris and Mike
>
> Please help to validate if this version can also fix your issues.
> After enumerating the possible cases, I realized that the address check might not be necessary.
> But we need a max_bit_width check in this function to make it prepared for a future usage in acpi_read()/acpi_write().
> Thanks in advance.
>
> Best regards
> -Lv
>
>> From: Zheng, Lv
>> Subject: [RFC PATCH v2] ACPICA / Hardware: Fix old register check in
>> acpi_hw_get_access_bit_width()
>>
>> The address check in acpi_hw_get_access_bit_width() should be byte
>> width
>> based, not bit width based. This patch fixes this mistake.
>>
>> For those who want to review acpi_hw_access_bit_width(), here is the
>> concerns and the design details of the function:
>>
>> It is supposed that the GAS Address field should be aligned to the byte
>> width indicated by the GAS AccessSize field. Similarly, for the old non
>> GAS register, it is supposed that its Address should be aligned to its
>> Length.
>> For the "AccessSize = 0 (meaning ANY)" case, we try to return the
>> maximum
>> instruction width (64 for MMIO or 32 for PIO) or the user expected access
>> bit width (64 for acpi_read()/acpi_write() or 32 for acpi_hw_read()/
>> acpi_hw_write()) for futher operation and it is supposed that the GAS
>> Address field should always be aligned to the maximum expected access
>> bit
>> width (otherwise it can't be ANY).
>>
>> The problem is in acpi_tb_init_generic_address(), where the non GAS
>> register's Length is converted into the GAS BitWidth field, its Address is
>> converted into the GAS Address field, and the GAS AccessSize field is left
>> 0 but most of the register actually cannot be accessed using "ANY"
>> accesses.
>>
>> As a conclusion, when AccessSize = 0 (ANY), the Address should either be
>> aligned to the BitWidth (wrong conversion) or aligned to 32 (PIO) or 64
>> (MMIO). Since BitWidth for the wrong conversion is 8,16,32, the Address
>> of the real GAS should always be aligned to 8,16,32, the address alignment
>> check is not necessary. But we in fact could enhance the check for a future
>> case where max_bit_width could be 64 for a PIO access issued from
>> acpi_read()/acpi_write().
>>
>> Fixes: b314a172ee96 ("ACPICA: Hardware: Add optimized access bit width
>> support")
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Mike Marshall <hubcap@omnibond.com>
>> Suggested-by: Jan Beulich <jbeulich@suse.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> ---
>>  drivers/acpi/acpica/hwregs.c |   16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
>> index 0f18dbc..0553c0b 100644
>> --- a/drivers/acpi/acpica/hwregs.c
>> +++ b/drivers/acpi/acpica/hwregs.c
>> @@ -86,24 +86,22 @@ acpi_hw_get_access_bit_width(struct
>> acpi_generic_address *reg, u8 max_bit_width)
>>       u64 address;
>>
>>       if (!reg->access_width) {
>> +             if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>> +                     max_bit_width = 32;
>> +             }
>>               /*
>>                * Detect old register descriptors where only the bit_width
>> field
>>                * makes senses. The target address is copied to handle
>> possible
>>                * alignment issues.
>>                */
>>               ACPI_MOVE_64_TO_64(&address, &reg->address);
>> -             if (!reg->bit_offset && reg->bit_width &&
>> +             if (reg->bit_width < max_bit_width &&
>> +                 !reg->bit_offset && reg->bit_width &&
>>                   ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
>> -                 ACPI_IS_ALIGNED(reg->bit_width, 8) &&
>> -                 ACPI_IS_ALIGNED(address, reg->bit_width)) {
>> +                 ACPI_IS_ALIGNED(reg->bit_width, 8)) {
>>                       return (reg->bit_width);
>> -             } else {
>> -                     if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
>> {
>> -                             return (32);
>> -                     } else {
>> -                             return (max_bit_width);
>> -                     }
>>               }
>> +             return (max_bit_width);
>>       } else {
>>               return (1 << (reg->access_width + 2));
>>       }
>> --
>> 1.7.10
>
