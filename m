From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Wed, 12 Apr 2017 15:29:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39123 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdDLP35 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Apr 2017 11:29:57 -0400
In-Reply-To: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

The ACPICA mutex functions are based on the host OS functions, so they don't really buy you anything. You should just use the native Linux functions.


> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Wednesday, April 12, 2017 8:13 AM
> To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org; Guenter Roeck <linux@roeck-us.net>
> Subject: [PATCH] ACPICA: Export mutex functions
> 
> Mutex functions may be needed by drivers. Examples are accesses to
> Super-IO SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO
> environmental monitor registers, both which may also be accessed through
> DSDT.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/acpi/acpica/utxfmutex.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/utxfmutex.c
> b/drivers/acpi/acpica/utxfmutex.c index c016211c35ae..5d20581f4b2f
> 100644
> --- a/drivers/acpi/acpica/utxfmutex.c
> +++ b/drivers/acpi/acpica/utxfmutex.c
> @@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string
> pathname, u16 timeout)
>  	status = acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeout);
>  	return (status);
>  }
> +ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
> 
> 
> /***********************************************************************
> ********
>   *
> @@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle handle,
> acpi_string pathname)
>  	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
>  	return (AE_OK);
>  }
> +ACPI_EXPORT_SYMBOL(acpi_release_mutex)
> --
> 2.7.4

