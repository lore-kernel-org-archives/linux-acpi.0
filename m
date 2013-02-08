From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI: Drop the container.h header file
Date: Fri, 08 Feb 2013 16:27:34 -0700
Message-ID: <1360366054.3869.60.camel@misato.fc.hp.com>
References: <1873429.MS5RQDxTye@vostro.rjw.lan>
	 <1891536.LKCrpu1upY@vostro.rjw.lan> <1435179.fU91E9qMVO@vostro.rjw.lan>
	 <1845543.1spGohx2XC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:36447 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947297Ab3BHXiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2013 18:38:14 -0500
In-Reply-To: <1845543.1spGohx2XC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Sat, 2013-02-09 at 00:18 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The include/acpi/container.h only contains a definition of a
> structure that is not used any more, so drop it entirely.
> 
> Similar change was proposed earlier by Toshi Kani.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


> ---
> 
> On top of current linux-pm.git/bleeding-edge.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/acpi/container.c |    1 -
>  include/acpi/container.h |   12 ------------
>  2 files changed, 13 deletions(-)
> 
> Index: test/include/acpi/container.h
> ===================================================================
> --- test.orig/include/acpi/container.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#ifndef __ACPI_CONTAINER_H
> -#define __ACPI_CONTAINER_H
> -
> -#include <linux/kernel.h>
> -
> -struct acpi_container {
> -	acpi_handle handle;
> -	unsigned long sun;
> -	int state;
> -};
> -
> -#endif				/* __ACPI_CONTAINER_H */
> Index: test/drivers/acpi/container.c
> ===================================================================
> --- test.orig/drivers/acpi/container.c
> +++ test/drivers/acpi/container.c
> @@ -34,7 +34,6 @@
>  #include <linux/acpi.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> -#include <acpi/container.h>
>  
>  #define PREFIX "ACPI: "
>  
> 


