From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/8] x86: oqo: depends on INPUT_POLLDEV
Date: Sun, 15 Mar 2009 23:05:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152304290.30317@localhost.localdomain>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:15353 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbZCPDFU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:05:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK00AYFWKJCR47@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:05:07 -0500 (CDT)
In-reply-to: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

applied to oqo-wmi-EXPECT-REFRESH branch

expecting a revised patch from Matthew at some point...

thanks
--
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> oqo driver uses polled input functions, so make it depend
> on INPUT_POLLDEV.
> 
> ERROR: "input_register_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
> ERROR: "input_allocate_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
> ERROR: "input_free_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
> ERROR: "input_unregister_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
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
> diff -puN drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev drivers/platform/x86/Kconfig
> --- a/drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev
> +++ a/drivers/platform/x86/Kconfig
> @@ -137,7 +137,7 @@ config MSI_LAPTOP
>  config OQO_WMI
>         tristate "OQO WMI extras"
>         depends on ACPI_WMI
> -       depends on INPUT
> +       depends on INPUT && INPUT_POLLDEV
>         depends on RFKILL
>         depends on BACKLIGHT_CLASS_DEVICE
>         help
> _
> 
