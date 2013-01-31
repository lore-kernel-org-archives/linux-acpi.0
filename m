From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RESEND PATCH 4/4] GPU/i915: Fix acpi_bus_get_device() check in
 drivers/gpu/drm/i915/intel_opregion.c
Date: Thu, 31 Jan 2013 11:03:30 +0100
Message-ID: <20130131100330.GE5885@phenom.ffwll.local>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan>
 <6099377.PFvsxPeyib@vostro.rjw.lan>
 <5109E11A.5030400@jp.fujitsu.com>
 <5109E2AF.2000107@jp.fujitsu.com>
 <5109E49E.1070005@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43035 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab3AaKBW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2013 05:01:22 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so2571595wic.0
        for <linux-acpi@vger.kernel.org>; Thu, 31 Jan 2013 02:01:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5109E49E.1070005@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, daniel.vetter@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org

On Thu, Jan 31, 2013 at 12:27:26PM +0900, Yasuaki Ishimatsu wrote:
> I forgot to change subject. So I resend a patch.
> 
> ---
> acpi_bus_get_device() returns int not acpi_status.
> 
> The patch change not to apply ACPI_FAILURE() to the return value of
> acpi_bus_get_device().
> 
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

I've tried to apply this to drm-intel-next-queued, but git am didn't
really like your patch - it failed to apply. Can you please rebase to the
drm-intel-next-queued branch from

git://people.freedesktop.org/~danvet/drm-intel

and please resubmit the patch, preferrably formatted with git
format-patch?

Thanks, Daniel

> ---
>  drivers/gpu/drm/i915/intel_opregion.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/gpu/drm/i915/intel_opregion.c
> ===================================================================
> --- linux-pm.orig/drivers/gpu/drm/i915/intel_opregion.c	2013-01-31 11:39:37.075849905 +0900
> +++ linux-pm/drivers/gpu/drm/i915/intel_opregion.c	2013-01-31 11:52:18.796850274 +0900
> @@ -347,7 +347,7 @@ static void intel_didl_outputs(struct dr
>  	int i = 0;
>  	handle = DEVICE_ACPI_HANDLE(&dev->pdev->dev);
> -	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev)))
> +	if (!handle || acpi_bus_get_device(handle, &acpi_dev))
>  		return;
>  	if (acpi_is_video_device(acpi_dev))
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
