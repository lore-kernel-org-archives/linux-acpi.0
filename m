From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] ACPI: fix ACPI_VIDEO dependencies
Date: Wed, 19 Mar 2014 02:26:52 +0100
Message-ID: <3419553.dABDqM4501@vostro.rjw.lan>
References: <20140317154644.15065deb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62303 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758843AbaCSBLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2014 21:11:23 -0400
In-Reply-To: <20140317154644.15065deb@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Zhang Rui <rui.zhang@intel.com>

Hi,

On Monday, March 17, 2014 03:46:44 PM Jean Delvare wrote:
> From: Jean Delvare <jdelvare@suse.de>
> Subject: ACPI: fix ACPI_VIDEO dependencies
> 
> ACPI_VIDEO stopped depending on VIDEO_OUTPUT_CONTROL over 3 years ago
> (see commit 677bd810, "ACPI video: remove output switching control".)
> So it's about time to remove the Kconfig dependency between these two
> options.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Do you want me to take this series?

> ---
> It would be great if this patch could go upstream quickly, as
> system-wide cleanups depend on it.
> 
>  drivers/acpi/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.14-rc7.orig/drivers/acpi/Kconfig	2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.14-rc7/drivers/acpi/Kconfig	2014-03-17 14:13:33.312716554 +0100
> @@ -115,7 +115,7 @@ config ACPI_BUTTON
>  
>  config ACPI_VIDEO
>  	tristate "Video"
> -	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
> +	depends on X86 && BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
>  	select THERMAL
>  	help
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
