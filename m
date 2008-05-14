From: Len Brown <lenb@kernel.org>
Subject: Re: Subject:ACPI: Send the reserved AC notification event to user space
Date: Tue, 13 May 2008 20:55:28 -0400
Message-ID: <200805132055.28148.lenb@kernel.org>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com> <200710092343.40843.lenb@kernel.org> <1210324942.8562.46.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47359 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757353AbYENAzm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 20:55:42 -0400
In-Reply-To: <1210324942.8562.46.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Friday 09 May 2008, Zhao Yakui wrote:
> Subject:ACPI: Send the reserved AC notification event to user space 
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> On some laptops the bogus bios sends the reserved AC notification event(0x81)
> when the AC adapter is plugged/unplugged .It can't be sent to 
> user space, which causes that user space application can't 
> receive the AC adapter event. 
> So the reserved AC adapter event(0x81) is still sent to the user space 
> so that user space can receive the notification event.
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/ac.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/ac.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/ac.c
> +++ linux-2.6/drivers/acpi/ac.c
> @@ -42,6 +42,7 @@
>  #define ACPI_AC_DEVICE_NAME		"AC Adapter"
>  #define ACPI_AC_FILE_STATE		"state"
>  #define ACPI_AC_NOTIFY_STATUS		0x80
> +#define ACPI_AC_NOTIFY_RESERVED		0x81
>  #define ACPI_AC_STATUS_OFFLINE		0x00
>  #define ACPI_AC_STATUS_ONLINE		0x01
>  #define ACPI_AC_STATUS_UNKNOWN		0xFF
> @@ -233,6 +234,9 @@ static void acpi_ac_notify(acpi_handle h
>  
>  	device = ac->device;
>  	switch (event) {
> +	case ACPI_AC_NOTIFY_RESERVED:

shouldn't this line above be "default:"
and the default: below this patch be removed?

-Len

> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +				  "Unsupported event [0x%x]\n", event));
>  	case ACPI_AC_NOTIFY_STATUS:
>  	case ACPI_NOTIFY_BUS_CHECK:
>  	case ACPI_NOTIFY_DEVICE_CHECK:
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


