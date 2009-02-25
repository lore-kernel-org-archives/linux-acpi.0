From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] eeepc-laptop: Fix Kconfig
Date: Wed, 25 Feb 2009 18:14:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902251813460.19092@localhost.localdomain>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37160 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759735AbZBYXOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 18:14:23 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN000389VL48W5@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Feb 2009 17:14:10 -0600 (CST)
In-reply-to: <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

dropped, b/c the "depends on" version is already merged

--
Len Brown, Intel Open Source Technology Center

On Sun, 15 Feb 2009, Corentin Chary wrote:

> Add a "select INPUT" to Kconfig now that eeepc-laptop
> is using the input layer.
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  drivers/platform/x86/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 9436311..6f46bc6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -305,6 +305,7 @@ config EEEPC_LAPTOP
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	select RFKILL
> +	select INPUT
>  	---help---
>  	  This driver supports the Fn-Fx keys on Eee PC laptops.
>  	  It also adds the ability to switch camera/wlan on/off.
> -- 
> 1.6.1.2
> 
> 
