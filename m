From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: undefined reference to `devm_watchdog_register_device'
Date: Mon, 21 Nov 2016 15:17:34 +0200
Message-ID: <20161121131734.GJ1446@lahna.fi.intel.com>
References: <CAOMGZ=EuLB0=HwGcMXj0=gP2Av_sCVg-pm_b5cGeYHnZwhqY0w@mail.gmail.com>
 <CAJZ5v0h=UCNRHrveFwV_hwNLSJ3jZnPDD3WkheVbq24prpnt4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22400 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754061AbcKUNTq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Nov 2016 08:19:46 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h=UCNRHrveFwV_hwNLSJ3jZnPDD3WkheVbq24prpnt4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Nov 21, 2016 at 02:04:34PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 21, 2016 at 10:07 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> > Hi,
> >
> > I updated my config and set CONFIG_WDAT_WDT=y, got this:
> >
> > drivers/built-in.o: In function `wdat_wdt_probe':
> > /home/vegard/linux/drivers/watchdog/wdat_wdt.c:444: undefined
> > reference to `devm_watchdog_register_device'
> > Makefile:962: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> >
> > Looks like it's missing a select for WATCHDOG_CORE in the Kconfig?
> 
> Mika?

That's right - we should select WATCHDOG_CORE there.

I'll submit a patch fixing this shortly.
