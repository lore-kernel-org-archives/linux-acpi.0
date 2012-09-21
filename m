From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 1/2] ACPI: Reorder IPMI driver before any other ACPI drivers
Date: Thu, 20 Sep 2012 20:19:48 -0500
Message-ID: <505BC0B4.4010306@mvista.com>
References: <1348177573-7537-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50606 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab2IUBTv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2012 21:19:51 -0400
Received: by oago6 with SMTP id o6so2853926oag.19
        for <linux-acpi@vger.kernel.org>; Thu, 20 Sep 2012 18:19:51 -0700 (PDT)
In-Reply-To: <1348177573-7537-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: yakui.zhao@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2012 04:46 PM, Matthew Garrett wrote:
> Drivers may make calls that require the ACPI IPMI driver to have been
> initialised already, so make sure that it appears earlier in the build
> order.

The IPMI driver uses the ACPI namespace as an option to know the address 
and characteristics of the device.  Does that still work?

-corey

>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>   drivers/acpi/Makefile | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 47199e2..82422fe 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -47,6 +47,10 @@ acpi-y				+= video_detect.o
>   endif
>   
>   # These are (potentially) separate modules
> +
> +# IPMI may be used by other drivers, so it has to initialise before them
> +obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
> +
>   obj-$(CONFIG_ACPI_AC) 		+= ac.o
>   obj-$(CONFIG_ACPI_BUTTON)	+= button.o
>   obj-$(CONFIG_ACPI_FAN)		+= fan.o
> @@ -70,6 +74,5 @@ processor-y			+= processor_idle.o processor_thermal.o
>   processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
>   
>   obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
> -obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
>   
>   obj-$(CONFIG_ACPI_APEI)		+= apei/

