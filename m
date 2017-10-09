From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/2] serdev: Update drivers/tty/serdev/Kconfig for
 ACPI serdev support
Date: Mon, 9 Oct 2017 09:54:13 +0200
Message-ID: <20171009075413.GN2618@localhost>
References: <82b477ef-757a-c953-45e8-fd68b28286e5@gmail.com>
 <7bdc8a8a-1a36-0494-ed0c-6e2052fb53d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37236 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdJIHyI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Oct 2017 03:54:08 -0400
Content-Disposition: inline
In-Reply-To: <7bdc8a8a-1a36-0494-ed0c-6e2052fb53d7@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com, frederic.danis.oss@gmail.com, robh@kernel.org, sre@kernel.org, Loic Poulain <loic.poulain@gmail.com>, lukas@wunner.de, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, Greg Kroah-Hartman <greg@kroah.com>

On Mon, Oct 09, 2017 at 11:43:19AM +1100, Ian W MORRISON wrote:
> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly
> since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for
> serdev. This is only possible if serdev support is compiled in as the code
> hooks into TTY. Otherwise PM will silently break as the corresponding
> platform devices would no longer be registered and as the tty class
> device is also gone and hciattach (btattach) will also fail.

You have quoted and a few us in the sentences above, but I'm afraid the
end result is not correct (e.g. this patch has nothing to do with
platform devices being registered or not).

Pleas try to explain why you think this change is necessary with your
own words.

> This patch set addresses this by making BT_HCIUART_BCM dependent on
> SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS
> and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

This patch does not touch BT_HCIUART_BCM, so the above paragraph is more
suited for a cover letter.

Also when resubmitting a patch series, make it self-contained rather
than send individual patches in response to their earlier counterparts
(which messes up threading).

> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
>  drivers/tty/serdev/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index cdc6b820cf93..1144f4db5087 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -2,7 +2,7 @@
>  # Serial bus device driver configuration
>  #
>  menuconfig SERIAL_DEV_BUS
> -	tristate "Serial device bus"
> +	bool "Serial device bus"

So please explain why you think this is needed. I'm not sure it's
necessary.

>  	help
>  	  Core support for devices connected via a serial port.
>  
> @@ -11,6 +11,6 @@ if SERIAL_DEV_BUS
>  config SERIAL_DEV_CTRL_TTYPORT
>  	bool "Serial device TTY port controller"
>  	depends on TTY
> -	depends on SERIAL_DEV_BUS != m
> +	depends on SERIAL_DEV_BUS
>  
>  endif

Johan
