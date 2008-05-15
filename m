From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Subject:ACPI: Send the reserved AC notification event to user
	space
Date: Thu, 15 May 2008 21:55:41 +0800
Message-ID: <1210859741.15922.8.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200805132055.28148.lenb@kernel.org>
	 <1210733239.7932.10.camel@yakui_zhao.sh.intel.com>
	 <200805141904.18579.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58714 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYEONqs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2008 09:46:48 -0400
In-Reply-To: <200805141904.18579.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, 2008-05-14 at 19:04 -0400, Len Brown wrote:


> Maybe I'm too tired to parse what you're saying.
> What is the matter with doing it this way:
> (this is now bugzilla 10695, btw.
> 
The following patch is OK. Of course the matter is that all the reserved
events will be sent to the user space. For example: 0x82, 0x83. Even the
invalid event will also be sent.

In my patch only the 0x81 reserved event is sent to the user space. For
the invalid events and other reserved events(For example : 0x82, 0x83),
only warning message is printed but they won't be sent to the user
space.
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 5b73f6a..831883b 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -233,6 +233,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>  
>  	device = ac->device;
>  	switch (event) {
> +	default:
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +				  "Unsupported event [0x%x]\n", event));
>  	case ACPI_AC_NOTIFY_STATUS:
>  	case ACPI_NOTIFY_BUS_CHECK:
>  	case ACPI_NOTIFY_DEVICE_CHECK:
> @@ -244,11 +247,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>  #ifdef CONFIG_ACPI_SYSFS_POWER
>  		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
>  #endif
> -		break;
> -	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> -		break;
>  	}
>  
>  	return;
> 

