From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Fri, 2 Nov 2018 23:09:54 +0100
Message-ID: <CAK8P3a2k0XTtKhL=A6yg80ZcJsMF46m_c6hZv2bDr3_+kpyBtg@mail.gmail.com>
References: <20181102110653.118257-1-arnd@arndb.de> <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/2/18, Arnd Bergmann <arnd@arndb.de> wrote:
> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
>>> We still get a link failure with IOSF_MBI=m when the xpower driver
>>> is built-in:
>>>
>>> drivers/acpi/pmic/intel_pmic_xpower.o: In function
>>> `intel_xpower_pmic_update_power':
>>> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to
>>> `iosf_mbi_block_punit_i2c_access'
>>> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to
>>> `iosf_mbi_unblock_punit_i2c_access'
>>>
>>> This makes the dependency stronger, so we can only build when IOSF_MBI
>>> is built-in.
>>>
>>> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to
>>> Kconfig entry")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/acpi/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 18851e7eedd5..31a3c4a03f61 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>>>
>>>  config XPOWER_PMIC_OPREGION
>>>  	bool "ACPI operation region support for XPower AXP288 PMIC"
>>> -	depends on MFD_AXP20X_I2C && IOSF_MBI
>>> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>>
>> To me sounds like
>>
>> select IOSF_MBI would be more appropriate here.
>
> It looks like we have a mix of the two two, with most drivers
> using 'select' and only a few ones using 'depends on'. Mixing
> the two often leads to trouble, especially for user-visible
> symbols.
>
> Making it a hidden symbol that is always selected is probably
> fine, but then every driver selecting it must also use 'depends
> on X86 && PCI'.

Oh, and that also requires removing the #else section in
arch/x86/include/asm/iosf_mbi.h, otherwise you might have
a driver that can build with or without CONFIG_IOSF_MBI,
but fails to be built-in when some other tristate symbol
uses 'select IOSF_MBI'. Making it a 'bool' seems easier
there.

        Arnd
