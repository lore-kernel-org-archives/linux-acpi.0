From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / dock: Take ACPI scan lock in write_undock()
Date: Tue, 18 Jun 2013 15:28:37 -0600
Message-ID: <1371590917.13194.8.camel@misato.fc.hp.com>
References: <1886227.aipra45Zvt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:19115 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799Ab3FRV25 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 17:28:57 -0400
In-Reply-To: <1886227.aipra45Zvt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>

On Sun, 2013-06-16 at 00:16 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since commit 3757b94 (ACPI / hotplug: Fix concurrency issues and
> memory leaks) acpi_bus_scan() and acpi_bus_trim() must always be
> called under acpi_scan_lock, but currently the following scenario
> violating that requirement is possible:
> 
>  write_undock()
>   handle_eject_request()
>    hotplug_dock_devices()
>     dock_remove_acpi_device()
>      acpi_bus_trim()
> 
> Fix that by making write_undock() acquire acpi_scan_lock before
> calling handle_eject_request() as appropriate (begin_undock() is
> under the lock too in analogy with acpi_dock_deferred_cb()).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good.

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi



> Cc: 3.9+ <stable@vger.kernel.org>
> ---
>  drivers/acpi/dock.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-pm/drivers/acpi/dock.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/dock.c
> +++ linux-pm/drivers/acpi/dock.c
> @@ -868,8 +868,10 @@ static ssize_t write_undock(struct devic
>  	if (!count)
>  		return -EINVAL;
>  
> +	acpi_scan_lock_acquire();
>  	begin_undock(dock_station);
>  	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
> +	acpi_scan_lock_release();
>  	return ret ? ret: count;
>  }
>  static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
> 


