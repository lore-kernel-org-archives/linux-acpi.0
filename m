From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/2] ACPI: Translate Linux IRQ number directly from
 GpioInt
Date: Wed, 29 Apr 2015 12:26:09 +0300
Message-ID: <20150429092609.GP1534@lahna.fi.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
 <553FC530.1020305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <553FC530.1020305@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 28, 2015 at 10:36:48AM -0700, sathyanarayanan kuppuswamy wrote:
> >This requires that the boot firmware (BIOS/coreboot) configures these pins
> >correctly (input, etc) before handing over to OS. I've tested this on Intel
> >Baytrail, Braswell and Skylake based machines where this is true.
>
> Why not configure the GPIO pin as input in the API itself ?

IIRC Octavian tried to do just that but it turned out that some of the
irqchip functions are called with spinlock held, which means you can't
call all gpiod_* functions there (as they might sleep).
