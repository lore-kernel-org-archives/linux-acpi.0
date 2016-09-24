From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/4] ACPI / watchdog: Add support for WDAT (Watchdog Action Table)
Date: Sat, 24 Sep 2016 02:34:10 +0200
Message-ID: <2633766.sDHCfGxtIg@vostro.rjw.lan>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52061 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755762AbcIXA1v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Sep 2016 20:27:51 -0400
In-Reply-To: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, September 20, 2016 03:30:50 PM Mika Westerberg wrote:
> Hi,
> 
> The WDAT (Watchdog Action Table) is a special ACPI table introduced by
> Microsoft [1] that abstracts the watchdog hardware from the OS. Windows
> uses this table for its watchdog implementation instead of a native iTCO
> driver.
> 
> Microsoft re-licensed the WDAT specification to be under Microsoft
> Community Promise license [2] so it should be fine to use it in Linux.
> 
> This series brings WDAT table support to Linux.
> 
> When the driver is enabled and we find out that there is a WDAT table, the
> driver will take over the native iTCO watchdog driver. Main advantage in
> this is that we do not need to change the native iTCO driver whenever the
> hardware changes. For example in Skylake iTCO moved to sit behind SMBus and
> the NO_REBOOT bit was hidden behind P2SB (Primary to Sideband). In addition
> we can expect this to be tested much better by OEMs who typically validate
> that Windows works fine on their hardware/firmware.
> 
> Patch [1/4] adds ACPI enumeration support and the driver itself. It also
> introduces acpi_has_watchdog() which can be used to check if we should use
> ACPI watchdog or native one.
> 
> Patches [2-4/4] prevent creation of the native iTCO platform device if we
> detect that the ACPI watchdog (WDAT) should be used instead.
> 
> The previous version of the series can be found in [3].
> 
> Changes from v1:
>   * Moved wdat_wdt.c to live under drivers/watchdog
>   * Added checks for timer_period, min_count and max_count
>   * Use min_hw_heartbeat_ms and max_hw_heartbeat_ms instead of
>     min/max_timeout
>   * Instead of stopping the watchdog set WDOG_HW_RUNNING
>   * Switched to use devm_watchdog_register_device() and dropped
>     wdat_wdt_remove()
>   * Do not ping watchdog in resume()
>   * Added review tag from Guenter Roeck to patches [2-4/4].
> 
> [1] http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> [2] https://msdn.microsoft.com/en-us/openspecifications/dn646766.aspx
> [3] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1230607.html
> 
> Mika Westerberg (4):
>   ACPI / watchdog: Add support for WDAT hardware watchdog
>   mfd: lpc_ich: Do not create iTCO watchdog when WDAT table exists
>   i2c: i801: Do not create iTCO watchdog when WDAT table exists
>   platform/x86: intel_pmc_ipc: Do not create iTCO watchdog when WDAT
>     table exists
> 
>  drivers/acpi/Kconfig                 |   3 +
>  drivers/acpi/Makefile                |   1 +
>  drivers/acpi/acpi_watchdog.c         | 123 ++++++++
>  drivers/acpi/internal.h              |  10 +
>  drivers/acpi/scan.c                  |   1 +
>  drivers/i2c/busses/i2c-i801.c        |   4 +-
>  drivers/mfd/lpc_ich.c                |   4 +
>  drivers/platform/x86/intel_pmc_ipc.c |  12 +-
>  drivers/watchdog/Kconfig             |  13 +
>  drivers/watchdog/Makefile            |   1 +
>  drivers/watchdog/wdat_wdt.c          | 525 +++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h                 |   6 +
>  12 files changed, 698 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/acpi/acpi_watchdog.c
>  create mode 100644 drivers/watchdog/wdat_wdt.c

I'm queing up this series for 4.9.

Please let me know if there are any objections.

Thanks,
Rafael

