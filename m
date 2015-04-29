From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/2] ACPI: Translate Linux IRQ number directly from GpioInt
Date: Wed, 29 Apr 2015 10:45:44 -0700
Message-ID: <554118C8.4020204@linux.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com> <553FC530.1020305@linux.intel.com> <20150429092609.GP1534@lahna.fi.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429092609.GP1534@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 04/29/2015 02:26 AM, Mika Westerberg wrote:
> On Tue, Apr 28, 2015 at 10:36:48AM -0700, sathyanarayanan kuppuswamy wrote:
>>> This requires that the boot firmware (BIOS/coreboot) configures these pins
>>> correctly (input, etc) before handing over to OS. I've tested this on Intel
>>> Baytrail, Braswell and Skylake based machines where this is true.
>> Why not configure the GPIO pin as input in the API itself ?
> IIRC Octavian tried to do just that but it turned out that some of the
> irqchip functions are called with spinlock held, which means you can't
> call all gpiod_* functions there (as they might sleep).
Got it. Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
