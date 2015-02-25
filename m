From: Al Stone <al.stone@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 4/9] ACPI: clean up checkpatch warnings
 for items with possible semantic value
Date: Wed, 25 Feb 2015 13:57:27 -0700
Message-ID: <54EE3737.2040300@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-5-git-send-email-al.stone@linaro.org> <54EDC957.9050000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <54EDC957.9050000@linaro.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 02/25/2015 06:08 AM, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wro=
te:
>> From: Al Stone <al.stone@linaro.org>
>>
>> In preparation for later splitting out some of the arch-dependent co=
de from
>> osl.c, clean up some warnings from checkpatch that fall into more se=
mantic
>> issues; none of these should change functionality, but they do touch=
 lines
>> of code with semantic significance:
>>
>>     -- replaced #include <asm/foo.h> with #include <linux/foo.h>
>>     -- replaced extern that was only being used for sizeof() with a =
#define
>>     -- removed use of else after breaks/returns when not useful
>>     -- moved __initdata to the proper place in a definition
>>     -- moved EXPORT_SYMBOL to a line immediately after the function
>>     -- removed unnecessary return statements from void functions
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/osl.c | 31 ++++++++++---------------------
>>   1 file changed, 10 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 46317ff..af6dda7 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -40,9 +40,8 @@
>>   #include <linux/list.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/semaphore.h>
>> -
>> -#include <asm/io.h>
>> -#include <asm/uaccess.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>>
>>   #include "internal.h"
>>
>> @@ -66,7 +65,7 @@ struct acpi_os_dpc {
>>   int acpi_in_debugger;
>>   EXPORT_SYMBOL(acpi_in_debugger);
>>
>> -extern char line_buf[80];
>> +#define DEBUGGER_LINE_BUFLEN    80
>>   #endif                /*ENABLE_DEBUGGER */
>>
>>   static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctr=
l,
>> @@ -268,10 +267,8 @@ acpi_physical_address __init acpi_os_get_root_p=
ointer(void)
>>               return efi.acpi20;
>>           else if (efi.acpi !=3D EFI_INVALID_TABLE_ADDR)
>>               return efi.acpi;
>> -        else {
>> -            pr_err(PREFIX "System description tables not found\n");
>> -            return 0;
>> -        }
>> +        pr_err(PREFIX "System description tables not found\n");
>> +        return 0;
>>       } else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
>>           acpi_physical_address pa =3D 0;
>>
>> @@ -594,7 +591,7 @@ static const char * const table_sigs[] =3D {
>>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>>
>>   #define ACPI_OVERRIDE_TABLES 64
>> -static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_=
TABLES];
>> +static struct cpio_data acpi_initrd_files[ACPI_OVERRIDE_TABLES] __i=
nitdata;
>>
>>   #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
>>
>> @@ -806,10 +803,10 @@ static irqreturn_t acpi_irq(int irq, void *dev=
_id)
>>       if (handled) {
>>           acpi_irq_handled++;
>>           return IRQ_HANDLED;
>> -    } else {
>> -        acpi_irq_not_handled++;
>> -        return IRQ_NONE;
>>       }
>> +
>> +    acpi_irq_not_handled++;
>> +    return IRQ_NONE;
>>   }
>>
>>   acpi_status
>> @@ -911,7 +908,6 @@ acpi_status acpi_os_read_port(acpi_io_address po=
rt, u32
>> *value, u32 width)
>>
>>       return AE_OK;
>>   }
>> -
>>   EXPORT_SYMBOL(acpi_os_read_port);
>>
>>   acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u3=
2 width)
>> @@ -927,7 +923,6 @@ acpi_status acpi_os_write_port(acpi_io_address p=
ort, u32
>> value, u32 width)
>>
>>       return AE_OK;
>>   }
>> -
>>   EXPORT_SYMBOL(acpi_os_write_port);
>>
>>   #ifdef readq
>> @@ -1362,7 +1357,7 @@ u32 acpi_os_get_line(char *buffer)
>>       if (acpi_in_debugger) {
>>           u32 chars;
>>
>> -        kdb_read(buffer, sizeof(line_buf));
>> +        kdb_read(buffer, sizeof(DEBUGGER_LINE_BUFLEN));
>=20
> I think kdb_read(buffer, DEBUGGER_LINE_BUFLEN); will be fine.
>=20
> other than that,
>=20
> Reviewd-by: Hanjun Guo <hanjun.guo@linaro.org>
>=20
> Thanks
> Hanjun

Whups.  Boy, was that just plain wrong.  Thanks.  Fixed.

>>
>>           /* remove the CR kdb includes */
>>           chars =3D strlen(buffer) - 1;
>> @@ -1490,8 +1485,6 @@ static void __init set_osi_linux(unsigned int =
enable)
>>           acpi_osi_setup("Linux");
>>       else
>>           acpi_osi_setup("!Linux");
>> -
>> -    return;
>>   }
>>
>>   static void __init acpi_cmdline_osi_linux(unsigned int enable)
>> @@ -1499,8 +1492,6 @@ static void __init acpi_cmdline_osi_linux(unsi=
gned int
>> enable)
>>       osi_linux.cmdline =3D 1;    /* cmdline set the default and ove=
rride DMI */
>>       osi_linux.dmi =3D 0;
>>       set_osi_linux(enable);
>> -
>> -    return;
>>   }
>>
>>   void __init acpi_dmi_osi_linux(int enable, const struct dmi_system=
_id *d)
>> @@ -1512,8 +1503,6 @@ void __init acpi_dmi_osi_linux(int enable, con=
st struct
>> dmi_system_id *d)
>>
>>       osi_linux.dmi =3D 1;    /* DMI knows that this box asks OSI(Li=
nux) */
>>       set_osi_linux(enable);
>> -
>> -    return;
>>   }
>>
>>   /*
>>


--=20
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
