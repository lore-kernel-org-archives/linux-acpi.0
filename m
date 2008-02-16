From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/9] ACPI: thinkpad-acpi: make the video output feature optional
Date: Sat, 16 Feb 2008 00:39:17 -0500
Message-ID: <200802160039.17214.lenb@kernel.org>
References: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br> <1203135478-4813-6-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47581 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbYBPFjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Feb 2008 00:39:52 -0500
In-Reply-To: <1203135478-4813-6-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Friday 15 February 2008 23:17, Henrique de Moraes Holschuh wrote:
> The video output port control feature is not very useful on many ThinkPads
> (especially when a X server is running), and lately userspace is getting
> better and better at it, so it makes sense to allow users to stripe out the
> thinkpad-acpi video feature from their kernels and save at least 2KB.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/misc/Kconfig         |   17 +++++++++++++++++
>  drivers/misc/thinkpad_acpi.c |   20 +++++++++++++-------
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 1abc95c..982e27b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -258,6 +258,23 @@ config THINKPAD_ACPI_BAY
>  
>  	  If you are not sure, say Y here.
>  
> +config THINKPAD_ACPI_VIDEO
> +	bool "Video output control support"
> +	depends on THINKPAD_ACPI
> +	default y

I would consider going one step further and delete this line
to make it default N (and update the description below).

Indeed, we recently deleted the kernel code from the ACPI video driver
that did video display switching -- at the request of the X community.

-Len
> +	---help---
> +	  Allows the thinkpad_acpi driver to provide an interface to control
> +	  the various video output ports.
> +
> +	  This feature often won't work well, depending on ThinkPad model,
> +	  display state, video output devices in use, whether there is a X
> +	  server running, phase of the moon, and the current mood of
> +	  Schroedinger's cat.  If you can use X.org's RandR to control
> +	  your ThinkPad's video output ports instead of this feature,
> +	  don't think twice: do it and say N here to save some memory.
> +
> +	  If you are not sure, say Y here.
> +
>  config THINKPAD_ACPI_HOTKEY_POLL
>  	bool "Suport NVRAM polling for hot keys"
>  	depends on THINKPAD_ACPI
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 02f9465..4ea3866 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -301,6 +301,13 @@ TPACPI_HANDLE(hkey, ec, "\\_SB.HKEY",	/* 600e/x, 770e, 770x */
>  	   "HKEY",		/* all others */
>  	   );			/* 570 */
>  
> +TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
> +	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
> +	   "\\_SB.PCI0.VID0",	/* 770e */
> +	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
> +	   "\\_SB.PCI0.AGP.VID",	/* all others */
> +	   );				/* R30, R31 */
> +
>  
>  /*************************************************************************
>   * ACPI helpers
> @@ -2680,6 +2687,8 @@ static struct ibm_struct wan_driver_data = {
>   * Video subdriver
>   */
>  
> +#ifdef CONFIG_THINKPAD_ACPI_VIDEO
> +
>  enum video_access_mode {
>  	TPACPI_VIDEO_NONE = 0,
>  	TPACPI_VIDEO_570,	/* 570 */
> @@ -2707,13 +2716,6 @@ static int video_orig_autosw;
>  static int video_autosw_get(void);
>  static int video_autosw_set(int enable);
>  
> -TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
> -	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
> -	   "\\_SB.PCI0.VID0",	/* 770e */
> -	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
> -	   "\\_SB.PCI0.AGP.VID",	/* all others */
> -	   );				/* R30, R31 */
> -
>  TPACPI_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
>  
>  static int __init video_init(struct ibm_init_struct *iibm)
> @@ -3023,6 +3025,8 @@ static struct ibm_struct video_driver_data = {
>  	.exit = video_exit,
>  };
>  
> +#endif /* CONFIG_THINKPAD_ACPI_VIDEO */
> +
>  /*************************************************************************
>   * Light (thinklight) subdriver
>   */
> @@ -5807,10 +5811,12 @@ static struct ibm_init_struct ibms_init[] __initdata = {
>  		.init = wan_init,
>  		.data = &wan_driver_data,
>  	},
> +#ifdef CONFIG_THINKPAD_ACPI_VIDEO
>  	{
>  		.init = video_init,
>  		.data = &video_driver_data,
>  	},
> +#endif
>  	{
>  		.init = light_init,
>  		.data = &light_driver_data,
