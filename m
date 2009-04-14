From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/8] x86: oqo: depends on INPUT_POLLDEV
Date: Mon, 13 Apr 2009 19:16:40 -0700
Message-ID: <200904131916.40428.dmitry.torokhov@gmail.com>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:5031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZDNCQq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 22:16:46 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2377548rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2009 19:16:45 -0700 (PDT)
In-Reply-To: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

On Wednesday 04 March 2009 11:55:24 akpm@linux-foundation.org wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> oqo driver uses polled input functions, so make it depend
> on INPUT_POLLDEV.
>
> ERROR: "input_register_polled_device" [drivers/platform/x86/oqo-wmi.ko]
> undefined! ERROR: "input_allocate_polled_device"
> [drivers/platform/x86/oqo-wmi.ko] undefined! ERROR:
> "input_free_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
> ERROR: "input_unregister_polled_device" [drivers/platform/x86/oqo-wmi.ko]
> undefined!
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/platform/x86/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev
> drivers/platform/x86/Kconfig ---
> a/drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev +++
> a/drivers/platform/x86/Kconfig
> @@ -137,7 +137,7 @@ config MSI_LAPTOP
>  config OQO_WMI
>         tristate "OQO WMI extras"
>         depends on ACPI_WMI
> -       depends on INPUT
> +       depends on INPUT && INPUT_POLLDEV

Make it "select INPUT_POLLDEV". Input-polldev is just a library code, users
should not have to select it for some drivers to become available.

-- 
Dmitry

