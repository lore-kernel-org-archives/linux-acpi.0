From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] ACPI / gpio: Updates to properties
Date: Wed, 19 Oct 2016 15:41:12 +0300
Message-ID: <20161019124112.GK1722@lahna.fi.intel.com>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 23, 2016 at 05:57:05PM +0300, Mika Westerberg wrote:
> Hi,
> 
> This series brings couple of useful GPIO related properties from Device
> Tree to ACPI _DSD device properties:
> 
>   - Names for GPIO lines
>   - GPIO hogging
>   - Holes in GPIO property lists
> 
> We are using these to get Intel Galileo better supported in the mainline
> kernel (but these may be useful for other boards as well). For example SPI
> chip select on Galileo is connected to a GPIO line so we need to be able to
> describe it in ACPI, and at the same time allow native chip selects.
> 
> GPIO hogging can be used to set initial state of certain GPIOs available on
> the headers regardless of the BIOS settings (which may be wrong as it knows
> nothing about which devices have been connected).
> 
> Mika Westerberg (5):
>   ACPI / documentation: Use recommended name in GPIO property names
>   ACPI / gpio: Add support for naming GPIOs
>   ACPI / gpio: Add hogging support
>   ACPI / property: Allow holes in reference properties
>   ACPI / gpio: Allow holes in list of GPIOs for a device

Any comments on the GPIO patches in this series?

At least the last one does not add any new bindings so it should be fine
to apply.
