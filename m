From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4] ACPI: video: call ACPI notifier chain for ACPI video notifications
Date: Fri, 1 Feb 2008 23:04:22 -0500
Message-ID: <200802012304.22513.lenb@kernel.org>
References: <1201243692.4663.21.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37401 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbYBBEEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2008 23:04:36 -0500
In-Reply-To: <1201243692.4663.21.camel@acpi-sony.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com

Applied.

thanks,
-Len

On Friday 25 January 2008 01:48, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Call notifier chain for display/brightness switch events.
> The kernel mode graphics driver is interested in this.
> 
> Sign-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -1765,6 +1765,7 @@ static void acpi_video_bus_notify(acpi_h
>  		break;
>  	}
>  
> +	acpi_notifier_call_chain(device, event, 0);
>  	input_report_key(input, keycode, 1);
>  	input_sync(input);
>  	input_report_key(input, keycode, 0);
> @@ -1826,6 +1827,7 @@ static void acpi_video_device_notify(acp
>  		break;
>  	}
>  
> +	acpi_notifier_call_chain(device, event, 0);
>  	input_report_key(input, keycode, 1);
>  	input_sync(input);
>  	input_report_key(input, keycode, 0);
> 
> 
