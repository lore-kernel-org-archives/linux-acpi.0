From: "Carlos Corbacho" <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] acer-wmi: Fix regression in backlight detection
Date: Tue, 24 Feb 2009 09:25:09 -0000 (UTC)
Message-ID: <7959.194.201.210.214.1235467509.squirrel@phoenix.slamd64.com>
References: <1235454078-3069-1-git-send-email-mspang@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:57321 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbZBXJZk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 04:25:40 -0500
In-Reply-To: <1235454078-3069-1-git-send-email-mspang@csclub.uwaterloo.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Spang <mspang@csclub.uwaterloo.ca>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

[Adding Len Brown & linux-acpi to CC]

> Currently we disable the Acer WMI backlight device if there is no ACPI
> backlight device. As a result, we end up with no backlight device at
> all. We should instead disable it if there is an ACPI device, as the
> other laptop drivers do. This regression was introduced in febf2d9.

An identical patch has already been submitted, I'm just waiting on Len to
apply it:

http://patchwork.kernel.org/patch/7223/

> Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
> ---
>  drivers/platform/x86/acer-wmi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Each laptop driver with backlight support got a similar change around
> febf2d9. The changes to the other drivers look correct; see e.g. a598c82f
> for a similar but correct change. The regression is also in 2.6.28.

This won't apply cleanly to 2.6.28 due to the move of acer-wmi from
drivers/misc to drivers/platform/x86, so we'd probably need another patch
for stable. However, that can't happen until the original patch gets
merged upstream.

-Carlos

> diff --git a/drivers/platform/x86/acer-wmi.c
> b/drivers/platform/x86/acer-wmi.c
> index 94c9f91..6bcca61 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1297,7 +1297,7 @@ static int __init acer_wmi_init(void)
>
>  	set_quirks();
>
> -	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
> +	if (acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
>  		interface->capability &= ~ACER_CAP_BRIGHTNESS;
>  		printk(ACER_INFO "Brightness must be controlled by "
>  		       "generic video driver\n");
> --
> 1.6.0.6
>
>


-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
