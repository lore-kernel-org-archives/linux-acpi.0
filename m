From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] efi: Work around bogus pointers in BGRT
Date: Thu, 23 May 2013 22:37:38 -0700
Message-ID: <20130524053737.GB6380@leaf>
References: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
 <7ccd9d84f7407ba65c1f03d144e2113dee0d797a.1368824585.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34363 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab3EXFhp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2013 01:37:45 -0400
Content-Disposition: inline
In-Reply-To: <7ccd9d84f7407ba65c1f03d144e2113dee0d797a.1368824585.git.luto@amacapital.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, May 17, 2013 at 02:05:33PM -0700, Andy Lutomirski wrote:
> The MSI MS-7760 supplies a BGRT marked "invalid" that contains a
> pointer to nowhere.  Since an "invalid" BGRT isn't particularly
> useful (userspace isn't supposed to use it anyway), ignore the BGRT
> if it's marked "invalid" and the pointer points outside of EFI boot
> services space.
> 
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>

I'd suggest generalizing the comment to not just mention the one system
you observed it on.  In any case, I'm fine with this patch, but I seem
to recall Matthew Garrett having some objections to ignoring the BGRT
when the valid bit is not set.  Also, if you're going to do so, you
might as well not expose the valid bit to userspace.

> This seems to fix the problem for me.
> 
>  arch/x86/platform/efi/efi-bgrt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/efi-bgrt.c b/arch/x86/platform/efi/efi-bgrt.c
> index 7145ec6..c77b7cf 100644
> --- a/arch/x86/platform/efi/efi-bgrt.c
> +++ b/arch/x86/platform/efi/efi-bgrt.c
> @@ -49,6 +49,18 @@ void __init efi_bgrt_init(void)
>  
>  	image = efi_lookup_mapped_addr(bgrt_tab->image_address);
>  	if (!image) {
> +		if (!(bgrt_tab->status & 1)) {
> +			/*
> +			 * The MSI MS-7760 exposes an "invalid" BGRT
> +			 * containing a pointer to nowhere.  This heuristic
> +			 * will avoid following that pointer.  (The idea
> +			 * is that an "invalid" image pointing into boot
> +			 * services data is probably sensible, but other
> +			 * "invalid" pointers are questionable.)
> +			 */
> +			return;
> +		}
> +
>  		image = ioremap(bgrt_tab->image_address, sizeof(bmp_header));
>  		ioremapped = true;
>  		if (!image)
> -- 
> 1.8.1.4
> 
