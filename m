From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: fix fixed event handler return value
Date: Wed, 18 Mar 2015 16:27:09 +0100
Message-ID: <2150812.Aqkuo0mad6@vostro.rjw.lan>
References: <20150313055250.GA23305@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56010 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755242AbbCRPDO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 11:03:14 -0400
In-Reply-To: <20150313055250.GA23305@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

On Friday, March 13, 2015 01:52:50 PM Aaron Lu wrote:
> The fixed event handler should return a value that is either 0 or 1
> meanning if the event is handled or not, instead of an acpi_status to
> mean if the handler runs well or not.
> 
> Suggested-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Queued up for 4.1, thanks!

> ---
>  drivers/acpi/scan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bbca7830e18a..3e5a2768c3b4 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1062,10 +1062,10 @@ static void acpi_device_notify_fixed(void *data)
>  	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
>  }
>  
> -static acpi_status acpi_device_fixed_event(void *data)
> +static u32 acpi_device_fixed_event(void *data)
>  {
>  	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed, data);
> -	return AE_OK;
> +	return ACPI_INTERRUPT_HANDLED;
>  }
>  
>  static int acpi_device_install_notify_handler(struct acpi_device *device)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
