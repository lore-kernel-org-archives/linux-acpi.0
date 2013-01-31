From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH 1/2] ACPI / scan: Fix acpi_bus_get_device() check in acpi_match_device()
Date: Thu, 31 Jan 2013 12:04:39 +0900
Message-ID: <5109DF47.30305@jp.fujitsu.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan> <6099377.PFvsxPeyib@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45683 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3AaDF2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2013 22:05:28 -0500
In-Reply-To: <6099377.PFvsxPeyib@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>

2013/01/31 7:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since acpi_bus_get_device() returns int and not acpi_status, change
> acpi_match_device() so that it doesn't apply ACPI_FAILURE() to the
> return value of acpi_bus_get_device().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I have no objection.
Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

>   drivers/acpi/scan.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -491,9 +491,9 @@ const struct acpi_device_id *acpi_match_
>   					       const struct device *dev)
>   {
>   	struct acpi_device *adev;
> +	acpi_handle handle = ACPI_HANDLE(dev);
>
> -	if (!ids || !ACPI_HANDLE(dev)
> -	    || ACPI_FAILURE(acpi_bus_get_device(ACPI_HANDLE(dev), &adev)))
> +	if (!ids || !handle || acpi_bus_get_device(handle, &adev))
>   		return NULL;
>
>   	return __acpi_match_device(adev, ids);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


