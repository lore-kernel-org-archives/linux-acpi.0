From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [UPDATE PATCH 4/4] ACPI: Add support to force header inclusion rules for <linux/acpi.h>.
Date: Tue, 26 Nov 2013 01:09:45 +0100
Message-ID: <5998708.qlCSNdGapO@vostro.rjw.lan>
References: <cover.1385094640.git.lv.zheng@intel.com> <2930f1fabbb8319c11180c8db3d1693adc71aac1.1385163359.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52590 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751744Ab3KYX46 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 18:56:58 -0500
In-Reply-To: <2930f1fabbb8319c11180c8db3d1693adc71aac1.1385163359.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <zetalog@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Saturday, November 23, 2013 07:54:18 AM Lv Zheng wrote:
> From: Lv Zheng <lv.zheng@intel.com>
> 
> (Update due to some typo fixes.)
> 
> As there is only CONFIG_ACPI=n processing in the <linux/acpi.h>, it is not
> safe to include <acpi/acpi.h>, <acpi/acpi_drivers.h> and <acpi/acpi_bus.h>
> directly for source out of Linux ACPI subsystems.
> 
> This patch adds error messaging to warn developers of such wrong
> inclusions.
> 
> In order not to be bisected and reverted as a wrong commit, warning
> messages are carefully split into a seperate patch other than the wrong
> inclusion cleanups.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I don't like this one to be honest.

> ---
>  drivers/acpi/acpica/Makefile    |    2 +-
>  include/acpi/acpi_bus.h         |    5 +++++
>  include/acpi/acpi_drivers.h     |    5 +++++
>  include/acpi/platform/aclinux.h |   10 ++++++++++
>  4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
> index 4383040..7738677 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for ACPICA Core interpreter
>  #
>  
> -ccflags-y			:= -Os
> +ccflags-y			:= -Os -DLINUXIZED_ACPICA

I don't like this (the naming and the way it is done).

>  ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
>  
>  # use acpi.o to put all files here into acpi.o modparam namespace
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 0af9667..0b1ea80 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -26,6 +26,11 @@
>  #ifndef __ACPI_BUS_H__
>  #define __ACPI_BUS_H__
>  
> +/* <acpi/acpi_bus.h> is not safe for CONFIG_ACPI=n environment */
> +#ifndef _LINUX_ACPI_H
> +#error "Please don't include <acpi/acpi_bus.h> directly, include <linux/acpi.h> instead."
> +#endif

And this should either go into all of the <acpi/*.h> files, not only to the two
of them you chose, or to none of them.  I prefer none.

Thanks,
Rafael

