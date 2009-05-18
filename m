From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 15/19] ACPI, i915: build fix
Date: Mon, 18 May 2009 10:49:48 +0800
Message-ID: <1242614988.3685.31.camel@localhost.localdomain>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
	 <ecb4aed78dcf09e48c8c34c8c2fa7f5c69344be6.1242453625.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54022 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbZERCsa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 May 2009 22:48:30 -0400
In-Reply-To: <ecb4aed78dcf09e48c8c34c8c2fa7f5c69344be6.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Sat, 2009-05-16 at 14:02 +0800, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> drivers/built-in.o: In function `intel_opregion_init':
> (.text+0x9d540): undefined reference to `acpi_video_register'
Hi, 
	When the KMS is selected in kernel configuration, the issue will be
fixed.
        But if KMS is not set in kernel configuration, the issue will
still exist.


How about that the ACPI_VIDEO depends on the I915 instead of I915_KMS?

Thanks.
    ---
 drivers/gpu/drm/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/drivers/gpu/drm/Kconfig
===================================================================
--- linux-2.6.orig/drivers/gpu/drm/Kconfig	2009-05-15 13:53:06.000000000
+0800
+++ linux-2.6/drivers/gpu/drm/Kconfig	2009-05-18 10:45:37.000000000
+0800
@@ -71,6 +71,10 @@
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB
+	select VIDEO_OUTPUT_CONTROL if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select INPUT if ACPI
+	select ACPI_VIDEO if ACPI
 	tristate "i915 driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,

> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13165
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/gpu/drm/Kconfig |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 3a22eb9..f33d252 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -83,6 +83,12 @@ config DRM_I915
>  config DRM_I915_KMS
>  	bool "Enable modesetting on intel by default"
>  	depends on DRM_I915
> +	# i915 KMS depends on ACPI_VIDEO when ACPI is enabled
> +	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
> +	select VIDEO_OUTPUT_CONTROL if ACPI
> +	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select INPUT if ACPI
> +	select ACPI_VIDEO if ACPI
>  	help
>  	  Choose this option if you want kernel modesetting enabled by default,
>  	  and you have a new enough userspace to support this. Running old

