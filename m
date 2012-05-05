From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when
 possible
Date: Sat, 05 May 2012 15:14:44 +0400
Message-ID: <4FA50BA4.5030605@mvista.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com> <1336100803-28353-3-git-send-email-tianyu.lan@intel.com> <20120505002155.GA12282@kroah.com> <20120505052624.GA574@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48313 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2EELPI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 May 2012 07:15:08 -0400
Received: by lbbgm6 with SMTP id gm6so2570713lbb.19
        for <linux-acpi@vger.kernel.org>; Sat, 05 May 2012 04:15:06 -0700 (PDT)
In-Reply-To: <20120505052624.GA574@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mfm@muteddisk.com

Hello.

On 05-05-2012 9:26, Matthew Garrett wrote:

>> This patch breaks the build with:
>> 	ERROR: "unregister_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!
>> 	ERROR: "register_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!

>> {sigh}

>> Care to resend them after fixing this?

> Does this fix it?

> commit f5c5fea66ab7db94cea5a51c474ff5111ec55800
> Author: Matthew Garrett<mjg@redhat.com>
> Date:   Sat May 5 01:21:45 2012 -0400

>      ACPI: Add stubs for (un)register_acpi_bus_type

>      It's unreasonable to have CONFIG_ACPI for these in drivers, so add some
>      stub functions.

>      Signed-off-by: Matthew Garrett<mjg@redhat.com>

> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 30a9250..19f9483 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -431,6 +431,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
>   }
>   #endif
>
> +#else	/* CONFIG_ACPI */
> +
> +static int register_acpi_bus_type (struct acpi_bus_type *bus) { return 0; }
> +static int unregister_acpi_bus_type (struct acpi_bus_type *bus) { return 0; }

    Should be no space between function name and (. Did you run thru 
checkpatch.pl?

WBR, Sergei
