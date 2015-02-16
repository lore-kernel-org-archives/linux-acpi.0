From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH] ACPI / video: Add disable_native_backlight quirk for
 SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D
Date: Mon, 16 Feb 2015 13:25:20 +0800
Message-ID: <20150216052443.GA11266@aaronlu.sh.intel.com>
References: <54DFD852.4080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39657 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbBPF00 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Feb 2015 00:26:26 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz1so32742471pad.9
        for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2015 21:26:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54DFD852.4080000@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Reyer <jens.reyer@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Sun, Feb 15, 2015 at 12:20:50AM +0100, Jens Reyer wrote:
> Hi
> 
> The native intel backlight controls do not work correctly on SAMSUNG
> 900X3C/900X3D/900X3E/900X4C/900X4D laptops as I reported in
> https://bugs.freedesktop.org/show_bug.cgi?id=87286 (and
> https://bugs.debian.org/772440).
> 
> Aaron Lu told me there to speak up here/to Rafael.
> 
> Please find attached a patch to disable the native backlight on this
> laptop model, like it was already done for some other older models.
> 
> I assume this would be the proper commit comments (or should it be
> signed-off?):
> Bug-Link: https://bugs.freedesktop.org/show_bug.cgi?id=87286.
> Reported-and-tested-by: Jens Reyer <jens.reyer@gmail.com>

You will need to add the Signed-off-by: line to get the patch merged.

Thanks,
Aaron

> 
> The patch applies to
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> branch linux-next, head at
> 389a8d43d64711b0e7282d227e05a6a71b43753d
> Rafael J. Wysocki 2015-02-12 22:43:26
> 
> I verified the issues are still present in linux-next and get solved
> with this patch.
> 
> Just tell me if there is anything else I can do to get this applied.
> 
> Thanks
> Jens Reyer/jre <jre.winesim@gmail.com>

> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 88a4f99..debd309 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -540,6 +540,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
>  		},
>  	},
> +	{
> +	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
> +	 .callback = video_disable_native_backlight,
> +	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "900X3C/900X3D/900X3E/900X4C/900X4D"),
> +		},
> +	},
>  
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */

