From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] mfd: intel_soc_pmic: Fix a mess with compilation
 units
Date: Tue, 18 Apr 2017 16:05:24 +0300
Message-ID: <1492520724.24567.59.camel@linux.intel.com>
References: <20170404123856.3052-1-andriy.shevchenko@linux.intel.com>
         <20170411135412.qnepq52p3m44zqkq@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45389 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbdDRNF2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 09:05:28 -0400
In-Reply-To: <20170411135412.qnepq52p3m44zqkq@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On Tue, 2017-04-11 at 14:54 +0100, Lee Jones wrote:
> On Tue, 04 Apr 2017, Andy Shevchenko wrote:
> 
> > Crystal Cove and Whiskey Cove are two different PMICs which are
> > installed on Intel Atom SoC based platforms.
> > 
> > Moreover there are two independent drivers that by some reason were
> > supposed (*) to get into one kernel module.
> > 
> > Fix the mess by clarifying Kconfig option for Crystal Cove and split
> > Whiskey Cove out of it.
> > 
> > (*) It looks like the configuration was never tested with
> >     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  - fix dependency for now, proper fix is to provide headers in
> > platform_data/x86
> >  - add tags
> >  drivers/acpi/Kconfig         |  2 +-
> >  drivers/gpio/Kconfig         |  2 +-
> >  drivers/mfd/Kconfig          | 15 +++++++++++++--
> >  drivers/mfd/Makefile         |  2 +-
> >  drivers/platform/x86/Kconfig |  2 +-
> >  drivers/thermal/Kconfig      |  2 +-
> >  6 files changed, 18 insertions(+), 7 deletions(-)
> 
> Applied, thanks.

I didn't see it in next. Does it cause build issues still? I didn't get
any report on it.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
