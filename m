From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v6 0/3] TPS68470 PMIC drivers
Date: Thu, 10 Aug 2017 01:11:29 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A59725ED8F2@FMSMSX114.amr.corp.intel.com>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdHJBLb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 21:11:31 -0400
In-Reply-To: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

Hi All,

Now that Lee has applied the MFD patch (https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=6a58f36b0c49c8179804bead579f5ff6304f0245), can someone help clarify the next steps for the GPIO and ACPI / PMIC OpRegion patches of this series?

Both these patches depend on the MFD patch (MFD_TPS68470 config option) to compile.

Thanks
Raj

> -----Original Message-----
> From: Mani, Rajmohan
> Sent: Friday, July 28, 2017 5:30 PM
> To: linux-kernel@vger.kernel.org; linux-gpio@vger.kernel.org; linux-
> acpi@vger.kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>; Linus Walleij
> <linus.walleij@linaro.org>; Alexandre Courbot <gnurou@gmail.com>; Rafael
> J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> sakari.ailus@linux.intel.com; Andy Shevchenko
> <andy.shevchenko@gmail.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: [PATCH v6 0/3] TPS68470 PMIC drivers
> 
> This is the patch series for TPS68470 PMIC that works as a camera PMIC.
> 
> The patch series provide the following 3 drivers, to help configure the voltage
> regulators, clocks and GPIOs provided by the TPS68470 PMIC, to be able to
> use the camera sensors connected to this PMIC.
> 
> TPS68470 MFD driver:
> This is the multi function driver that initializes the TPS68470 PMIC and
> supports the GPIO and Op Region functions.
> 
> TPS68470 GPIO driver:
> This is the PMIC GPIO driver that will be used by the OS GPIO layer, when the
> BIOS / firmware triggered GPIO access is done.
> 
> TPS68470 Op Region driver:
> This is the driver that will be invoked, when the BIOS / firmware configures
> the voltage / clock for the sensors / vcm devices connected to the PMIC.
> 
> ---
> 
> Update on 2 GPIO chips implementation over 1:
> 	- Attempted to implement 2 GPIO chips, but ran into couple of
> 	  issues in the kernel, so we couldn't get it to work.
> 	- It was decided to postpone this change, since it is not
> 	  critical
> 
> Changes in v6:
> 	- MFD driver:
> 	- Used non-zero return values from regmap_write/read() calls
> 	  to detect error conditions
> 
> Changes in v5:
> 	- MFD driver:
> 	- Fixed Kconfig description text
> 	- Addressed other comments from Lee, related to formatting
> 
> 	- GPIO driver:
> 	- Formatted the file header text
> 
> 	- Opregion driver:
> 	- Formatted the file header text
> 
> Changes in v4:
> 	- MFD driver:
> 	- Removed board specific code and FIXME comment
> 	- Moved i2c.h include from tps68470.h to tps68470.c
> 	- Moved the TPS68470 REVID read code after PMIC reset
> 	- Fixed typo in debug error message (on failure of
> 	  devm_mfd_add_devices() )
> 	- Enhanced dependency on I2C by changing it to I2C=y
> 	  (to fix build errors if I2C is built as module
> 	   e.g tps68470.c:71: undefined reference to
> `__devm_regmap_init_i2c'
> 	       tps68470.c:117: undefined reference to `i2c_register_driver')
> 	- Removed most of the unused header file definitions
> 	- Moved devm_mfd_add_devices() after PMIC resett
> 	- Used probe_new() and removed i2c_device_id table
> 
> 	  The following patch from Andy is needed for the driver to be
> 	  probed.
> 	  http://marc.info/?l=linux-acpi&m=150030081523885&w=2
> 
> 	- GPIO driver:
> 	- Added newline at the end of Kconfig description
> 	- Updated commit message about the descriptive
> 	  names for the GPIOs and the typical usage model
> 	  of the GPIO driver
> 
> 	- Opregion driver:
> 	- Added dependency on MFD_TPS68470
> 	- Converted 2 liner into one line code
> 
> Changes in v3:
> 	- MFD driver:
> 	- Removed GPIO lookup table
> 	- Reverted to probe() for consistency
> 	- Addressed other comments from Andy
> 
> 	- GPIO driver:
> 	- Removed the code that initializes the default values
> 	  of GPIOs to zeros
> 	- Used gpiochip_get_data() to access data inside the gpio_chip
> 
> Changes in v2:
> 	- MFD driver:
> 	- Removed tps68470_* wrappers around regmap_* calls
> 	- Removed "struct tps68470"
> 	- used devm_mfd_add_devices and removed mutex in mfd driver
> 	- Added reasoning about the need of having mfd driver
> 	  as bool/builtin
> 
> 	- Opregion driver:
> 	- renamed opregion driver file / internal symbol names
> 	  with tps68470_pmic*
> 	- Made opregion driver tables as const
> 	- Removed unused *handler_context in common handler
> 	- Replaced "int" with "unsigned int"
> 	- Changed to WARN macro to dev_warn()
> 	- Destroyed mutex on error
> 	- Added reasoning about the need of having Opregion driver
> 	  as bool/builtin
> 
> 	- GPIO driver:
> 	- Implemented get_direction() in the GPIO driver
> 	- Setup gpio_chip.names
> 	- Moved the GPIO lookup table code inside mfd driver
> 	- Added reasoning about the need of having GPIO driver
> 	  as bool/builtin
> 
> ---
> 
> Rajmohan Mani (3):
>   mfd: Add new mfd device TPS68470
>   gpio: Add support for TPS68470 GPIOs
>   ACPI / PMIC: Add TI PMIC TPS68470 operation region driver
> 
>  drivers/acpi/Kconfig              |  16 ++
>  drivers/acpi/Makefile             |   2 +
>  drivers/acpi/pmic/tps68470_pmic.c | 455
> ++++++++++++++++++++++++++++++++++++++
>  drivers/gpio/Kconfig              |  15 ++
>  drivers/gpio/Makefile             |   1 +
>  drivers/gpio/gpio-tps68470.c      | 176 +++++++++++++++
>  drivers/mfd/Kconfig               |  18 ++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/tps68470.c            | 106 +++++++++
>  include/linux/mfd/tps68470.h      |  97 ++++++++
>  10 files changed, 887 insertions(+)
>  create mode 100644 drivers/acpi/pmic/tps68470_pmic.c  create mode
> 100644 drivers/gpio/gpio-tps68470.c  create mode 100644
> drivers/mfd/tps68470.c  create mode 100644 include/linux/mfd/tps68470.h
> 
> --
> 1.9.1

