From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: i915 backlight
Date: Mon, 5 Aug 2013 09:34:10 +0200
Message-ID: <20130805073409.GW22035@phenom.ffwll.local>
References: <20130731162252.GC4724@pd.tnic>
 <20130731163623.GD4724@pd.tnic>
 <51F9B63F.7060509@intel.com>
 <20130801081215.GB3448@nazgul.tnic>
 <51FA2537.5040208@intel.com>
 <51FB0853.9090105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:48715 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3HEHeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Aug 2013 03:34:05 -0400
Received: by mail-wi0-f180.google.com with SMTP id f14so1169902wiw.1
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2013 00:34:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51FB0853.9090105@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Borislav Petkov <bp@alien8.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Fri, Aug 02, 2013 at 09:16:03AM +0800, Aaron Lu wrote:
> Hi Jani & Daniel,
> 
> It turned out there is an integer overflow problem, and the below patch
> fixed this problem on Acer Aspire 4732Z and thinkpad R61i.
> 
> From: Aaron Lu <aaron.lu@intel.com>
> Subject: [PATCH] drm/i915: avoid brightness overflow when doing scale
> 
> Some card's max brightness level is pretty large, e.g. on Acer Aspire
> 4732Z, the max level is 989910. If user space set a large enough level
> then the current scale done in intel_panel_set_backlight will cause an
> integer overflow and the scaled level will be mistakenly small, leaving
> user with an almost black screen. This patch fixes this problem.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
> Since the only external user of intel_panel_set_backlight is operation
> region code where the max will be a constant of 255, this patch fixes
> the problem by comparing freq and max and then do things accordingly
> instead of converting to 64 bits.

Yeah, makes sense. Picked up for -fixes, thanks for the patch.
-Daniel
> 
>  drivers/gpu/drm/i915/intel_panel.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
> index 67e2c1f..7c674f0 100644
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -498,7 +498,10 @@ void intel_panel_set_backlight(struct drm_device *dev, u32 level, u32 max)
>  	}
>  
>  	/* scale to hardware */
> -	level = level * freq / max;
> +	if (freq < max)
> +		level = level * freq / max;
> +	else
> +		level = freq / max * level;
>  
>  	dev_priv->backlight.level = level;
>  	if (dev_priv->backlight.device)
> -- 
> 1.8.3.1
> 
> 
> Hi Boris,
> 
> Since the sysfs interface works on your system, I think your problem
> should be different. Can you please file a bug for this? I can provide
> you with a debug patch and then see what happened. Please attach
> acpidump when filing the bug.
> 
> https://bugzilla.kernel.org, ACPI/Power-Video.
> 
> Thanks,
> Aaron
> 
> > 
> >>
> >> The ranges are different, though:
> >>
> >> intel_backlight/actual_brightness:1000
> >> intel_backlight/bl_power:0
> >> intel_backlight/brightness:1000
> >> intel_backlight/max_brightness:4437
> >> intel_backlight/type:raw
> >>
> >> acpi_video0/actual_brightness:41
> >> acpi_video0/bl_power:0
> >> acpi_video0/brightness:41
> >> acpi_video0/max_brightness:100
> >> acpi_video0/type:firmware
> > 
> > Yes, different interface has different brightness ranges and a value in
> > one range may turn out to be the same actual brightness level of another
> > value in another range.
> > 
> >>
> >> I guess I need to write me a dirty script for now ... :-)
> > 
> > :-)
> > 
> >>
> >> Thanks guys.
> >>
> > Thanks,
> > Aaron
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
