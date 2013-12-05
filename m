From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / video: Use native backlight control interface
 by default
Date: Thu, 5 Dec 2013 02:32:37 +0000
Message-ID: <20131205023237.GA23671@srcf.ucam.org>
References: <1386209037-31349-1-git-send-email-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60276 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab3LECco (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 21:32:44 -0500
Content-Disposition: inline
In-Reply-To: <1386209037-31349-1-git-send-email-acelan.kao@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch

We had problems with the Intel backlight driver the last time we tried 
this, so let's push this through their tree for testing first? Cc:ed 
intel-gfx and Daniel Vetter.


On Thu, Dec 05, 2013 at 10:03:57AM +0800, AceLan Kao wrote:
> The native/vendor backlight control interface is hardly fail to control the
> brightness, and we had encountered many backlight issues result from the broken
> ACPI backlight interface, so I think we should promote the native backlight
> control interface and use it by default.
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/acpi/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 995e91b..b3032f8 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -85,7 +85,7 @@ module_param(allow_duplicates, bool, 0644);
>   * For Windows 8 systems: if set ture and the GPU driver has
>   * registered a backlight interface, skip registering ACPI video's.
>   */
> -static bool use_native_backlight = false;
> +static bool use_native_backlight = true;
>  module_param(use_native_backlight, bool, 0644);
>  
>  static int register_count;
> -- 
> 1.8.3.2
> 
> 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
