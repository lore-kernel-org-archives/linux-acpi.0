From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] eeepc-laptop: Fix Kconfig
Date: Tue, 24 Feb 2009 14:44:39 -0800
Message-ID: <20090224144439.63c9b9f7.akpm@linux-foundation.org>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
	<1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50352 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758376AbZBXWpX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Feb 2009 17:45:23 -0500
In-Reply-To: <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, corentincj@iksaif.net

On Sun, 15 Feb 2009 19:30:18 +0100
Corentin Chary <corentincj@iksaif.net> wrote:

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

I'm getting

drivers/input/Kconfig:9:error: found recursive dependency: INPUT -> EEEPC_LAPTOP -> INPUT
make[1]: *** [oldconfig] Error 1
