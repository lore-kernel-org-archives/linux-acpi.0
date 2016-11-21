From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: undefined reference to `devm_watchdog_register_device'
Date: Mon, 21 Nov 2016 14:04:34 +0100
Message-ID: <CAJZ5v0h=UCNRHrveFwV_hwNLSJ3jZnPDD3WkheVbq24prpnt4g@mail.gmail.com>
References: <CAOMGZ=EuLB0=HwGcMXj0=gP2Av_sCVg-pm_b5cGeYHnZwhqY0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33138 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbcKUNEg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2016 08:04:36 -0500
In-Reply-To: <CAOMGZ=EuLB0=HwGcMXj0=gP2Av_sCVg-pm_b5cGeYHnZwhqY0w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Nov 21, 2016 at 10:07 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> Hi,
>
> I updated my config and set CONFIG_WDAT_WDT=y, got this:
>
> drivers/built-in.o: In function `wdat_wdt_probe':
> /home/vegard/linux/drivers/watchdog/wdat_wdt.c:444: undefined
> reference to `devm_watchdog_register_device'
> Makefile:962: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Looks like it's missing a select for WATCHDOG_CORE in the Kconfig?

Mika?
