From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Wed, 7 Nov 2018 13:39:59 +0100
Message-ID: <74d77804-bc05-4060-3182-a7cdecba3c53@redhat.com>
References: <20181102110653.118257-1-arnd@arndb.de>
 <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 07-11-18 13:22, Rafael J. Wysocki wrote:
> On Fri, Nov 2, 2018 at 12:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> We still get a link failure with IOSF_MBI=m when the xpower driver
>> is built-in:
>>
>> drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
>> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
>> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
>>
>> This makes the dependency stronger, so we can only build when IOSF_MBI
>> is built-in.
>>
>> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/acpi/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 18851e7eedd5..31a3c4a03f61 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>>
>>   config XPOWER_PMIC_OPREGION
>>          bool "ACPI operation region support for XPower AXP288 PMIC"
>> -       depends on MFD_AXP20X_I2C && IOSF_MBI
>> +       depends on MFD_AXP20X_I2C && IOSF_MBI=y
>>          help
>>            This config adds ACPI operation region support for XPower AXP288 PMIC.
>>
>> --
> 
> At this point I'm inclined to apply the patch as is as a short-term
> fix and improvements can be made on top of it.
> 
> Any objections?

Not from me, go for it :)

Regards,

Hans
