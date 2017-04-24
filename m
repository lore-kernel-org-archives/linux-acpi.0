From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4] mfd: intel_soc_pmic: Fix a mess with compilation units
Date: Mon, 24 Apr 2017 11:48:51 +0100
Message-ID: <20170424104851.vuxrg2vuw5ltkp5n@dell>
References: <20170404123856.3052-1-andriy.shevchenko@linux.intel.com>
 <20170411135412.qnepq52p3m44zqkq@dell>
 <1492520724.24567.59.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492520724.24567.59.camel@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, 18 Apr 2017, Andy Shevchenko wrote:

> On Tue, 2017-04-11 at 14:54 +0100, Lee Jones wrote:
> > On Tue, 04 Apr 2017, Andy Shevchenko wrote:
> > 
> > > Crystal Cove and Whiskey Cove are two different PMICs which are
> > > installed on Intel Atom SoC based platforms.
> > > 
> > > Moreover there are two independent drivers that by some reason were
> > > supposed (*) to get into one kernel module.
> > > 
> > > Fix the mess by clarifying Kconfig option for Crystal Cove and split
> > > Whiskey Cove out of it.
> > > 
> > > (*) It looks like the configuration was never tested with
> > >     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
> > > 
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Acked-by: Zhang Rui <rui.zhang@intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  - fix dependency for now, proper fix is to provide headers in
> > > platform_data/x86
> > >  - add tags
> > >  drivers/acpi/Kconfig         |  2 +-
> > >  drivers/gpio/Kconfig         |  2 +-
> > >  drivers/mfd/Kconfig          | 15 +++++++++++++--
> > >  drivers/mfd/Makefile         |  2 +-
> > >  drivers/platform/x86/Kconfig |  2 +-
> > >  drivers/thermal/Kconfig      |  2 +-
> > >  6 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > Applied, thanks.
> 
> I didn't see it in next. Does it cause build issues still? I didn't get
> any report on it.

It's there now.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
