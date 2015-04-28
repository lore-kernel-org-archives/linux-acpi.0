From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/2] ACPI: Translate Linux IRQ number directly from GpioInt
Date: Tue, 28 Apr 2015 10:36:48 -0700
Message-ID: <553FC530.1020305@linux.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 04/28/2015 08:05 AM, Mika Westerberg wrote:
> Hi,
>
> Currently drivers for ACPI enumerated devices that have their interrupt
> line connected to a GPIO controller instead of IO-APIC are required to do
> complete gpiod_get()/gpiod_to_irq() etc. dance themselves. This adds
> unnecessary lines of code to these drivers.
>
> It turned out that DT solved the problem already with introduction of
> of_irq_get() which is able to handle GPIO based interrupts as well through
> irqchip API [1].
>
> Following two patches does the same for ACPI by introducing new function
> acpi_dev_gpio_irq_get() that is then used in I2C core to automatically
> translate ACPI GpioInt resource to Linux IRQ number.
>
> This requires that the boot firmware (BIOS/coreboot) configures these pins
> correctly (input, etc) before handing over to OS. I've tested this on Intel
> Baytrail, Braswell and Skylake based machines where this is true.
Why not configure the GPIO pin as input in the API itself ?
>
> [1] https://lkml.org/lkml/2015/3/25/103
>
> Mika Westerberg (2):
>    gpio / ACPI: Add support for retrieving GpioInt resources from a device
>    i2c / ACPI: Assign IRQ for devices that have GpioInt automatically
>
>   drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++++++++
>   drivers/i2c/i2c-core.c      |  9 +++++++--
>   include/linux/acpi.h        |  7 +++++++
>   3 files changed, 43 insertions(+), 2 deletions(-)
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

