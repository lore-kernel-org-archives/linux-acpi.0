From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: [PATCH] ACPI video: Don't export sysfs backlight interface if query _BCL fail
Date: Sun, 6 May 2007 17:35:52 +0800
Message-ID: <3877989d0705060235p7bb7e58j1cf3172f3971c7c5@mail.gmail.com>
References: <200704271218.07411.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:10074 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbXEFJfx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 05:35:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1269784nzf
        for <linux-acpi@vger.kernel.org>; Sun, 06 May 2007 02:35:53 -0700 (PDT)
In-Reply-To: <200704271218.07411.dkukawka@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <dkukawka@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, luming.yu@intel.com

Ack!


On 4/27/07, Danny Kukawka <dkukawka@suse.de> wrote:
> Hi,
>
> currently the acpi video module export the backlight interface to sysfs also
> if acpi_video_device_lcd_query_levels() fails to read _BLC method (e.g.
> because the method is not available). In this case the userspace don't know
> which brightness level are supported and can't set a brightness level (echo
> return with: "write error: Invalid Argument"). This happend e.g. on a ASUS
> RF1 (correct supported by the asus-laptop module).
>
> The video module should not export the backlight interface if query _BLC fail,
> because you can't set anything from userspace and this make it useless.
>
> See also: http://bugzilla.kernel.org/show_bug.cgi?id=8375
>
> Danny
>
> From: Danny Kukawka <dkukawka@suse.de>
> Subject: ACPI video: Don't export sysfs backlight interface if query _BLC fail
>
> if qeuery _BCL fail (e.g. because the method is missing in BIOS) don't
> export the backlight interface to sysfs.
>
> Signed-off-by: Danny Kukawka <dkukawka@suse.de>
> ---
>  video.c |   78 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 37 deletions(-)
>
> --- linux-2.6.21/drivers/acpi/video.c   2007-04-26 13:50:51.000000000 +0200
> +++ linux-2.6.21/drivers/acpi/video.c   2007-04-26 13:50:53.000000000 +0200
> @@ -531,7 +531,6 @@
