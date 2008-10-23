From: Len Brown <lenb@kernel.org>
Subject: Re: [patch]dock: make dock driver not a module
Date: Thu, 23 Oct 2008 04:00:58 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810230400530.2983@localhost.localdomain>
References: <1222485028.2032.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:57323 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYJWIBB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 04:01:01 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KHVM9O3Q52@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 03:01:00 -0500 (CDT)
In-reply-to: <1222485028.2032.3.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

applied.

thanks,
-len

On Sat, 27 Sep 2008, Shaohua Li wrote:

> To avoid dock driver is loaded after other drivers like libata, let's
> make dock driver not a module.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 3919d6d..7060a64 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -157,7 +157,7 @@ config ACPI_FAN
>  	  applications to perform basic fan control (on, off, status).
>  
>  config ACPI_DOCK
> -	tristate "Dock"
> +	bool "Dock"
>  	depends on EXPERIMENTAL
>  	help
>  	  This driver adds support for ACPI controlled docking stations and removable
> 
> 
