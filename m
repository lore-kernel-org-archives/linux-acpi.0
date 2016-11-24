From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] watchdog: wdat_wdt: Select WATCHDOG_CORE
Date: Thu, 24 Nov 2016 02:30:43 +0100
Message-ID: <1813013.KOlSoqaZE7@vostro.rjw.lan>
References: <20161121133307.157776-1-mika.westerberg@linux.intel.com> <1dbc6c68-3ec7-1f4b-746d-494ffba39311@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1dbc6c68-3ec7-1f4b-746d-494ffba39311@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, November 21, 2016 07:14:08 AM Guenter Roeck wrote:
> On 11/21/2016 05:33 AM, Mika Westerberg wrote:
> > The WDAT watchdog driver uses functionality provided by the watchdog timer
> > core but it did not select it explicitly. This results following linker
> > error when only WDAT_WDT is enabled in Kconfig:
> >
> >   drivers/built-in.o: In function `wdat_wdt_probe':
> >   drivers/watchdog/wdat_wdt.c:444: undefined reference to `devm_watchdog_register_device'
> >
> > Fix this by explicitly selecting WATCHDOG_CORE when WDAT watchdog driver is
> > enabled.
> >
> > Fixes: 058dfc767008 (ACPI / watchdog: Add support for WDAT hardware watchdog)
> > Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Applied.

Thanks,
Rafael
