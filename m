From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Mon, 5 Nov 2018 16:16:29 +0100
Message-ID: <CAK8P3a1NqtY-WH=m9hOO=0=OYEvH8ok5bsgAX7d4hQCzsWAThQ@mail.gmail.com>
References: <20181102110653.118257-1-arnd@arndb.de> <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com> <20181105133301.GE10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105133301.GE10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/5/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Nov 02, 2018 at 11:07:34PM +0100, Arnd Bergmann wrote:
>> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
>
>> >> -	depends on MFD_AXP20X_I2C && IOSF_MBI
>> >> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>> >
>> > To me sounds like
>> >
>> > select IOSF_MBI would be more appropriate here.
>>
>> It looks like we have a mix of the two two, with most drivers
>> using 'select' and only a few ones using 'depends on'. Mixing
>> the two often leads to trouble, especially for user-visible
>> symbols.
>>
>> Making it a hidden symbol that is always selected is probably
>> fine, but then every driver selecting it must also use 'depends
>> on X86 && PCI'.
>
> I doubt every is a correct word here. Whenever driver uses IOSF_MBI it
> implies X86 and PCI (or should have those dependencies in mind already).

I mean it must depend on those two in some form. If a driver uses 'depends on
IOSF_MBI' today, that is implied through that dependency. Changing it
to 'select'
means we have to add that dependency, like

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 56ccb1ea7da5..fb750a8a9b77 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -489,6 +489,7 @@ config I2C_DESIGNWARE_PLATFORM
        tristate "Synopsys DesignWare Platform"
        select I2C_DESIGNWARE_CORE
        depends on (ACPI && COMMON_CLK) || !ACPI
+       select IOSF_MBI if I2C_DESIGNWARE_BAYTRAIL
        help
          If you say yes to this option, support will be included for the
          Synopsys DesignWare I2C adapter.
@@ -520,9 +521,8 @@ config I2C_DESIGNWARE_PCI

 config I2C_DESIGNWARE_BAYTRAIL
        bool "Intel Baytrail I2C semaphore support"
-       depends on ACPI
-       depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
-                  (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
+       depends on ACPI && X86 && PCI
+       depends on I2C_DESIGNWARE_PLATFORM
        help
          This driver enables managed host access to the PMIC I2C bus on select
          Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows

For anything that already has the dependency, nothing changes.

    Arnd
