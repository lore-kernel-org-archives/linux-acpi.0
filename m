From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] drm/i915: use ACPI LID status for LVDS
	->detect hook
Date: Thu, 16 Jul 2009 09:54:44 +0800
Message-ID: <1247709284.4113.50.camel@localhost.localdomain>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	 <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12977 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862AbZGPByD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 21:54:03 -0400
In-Reply-To: <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-07-16 at 06:11 +0800, Jesse Barnes wrote:
> We can't load or hotplug detect LVDS like we can other outputs, but if
> there's a lid device present we can use it as a proxy.  This allows the
> LFP state to be determined at ->detect time, making configurations
> requiring manual intervention today "just work" assuming the lid device
> status is correct.
It is ok that the LID status is to decide whether the LVDS is
connected/disconnected.

But on some boxes the initial LID status is incorrect. It reports that
LID is closed although it is open.
    For example: 
    http://bugzilla.kernel.org/show_bug.cgi?id=5809
    http://bugzilla.kernel.org/show_bug.cgi?id=13263
    http://bugzilla.kernel.org/show_bug.cgi?id=5904
    https://bugs.launchpad.net/ubuntu/+bug/34389
Maybe this feature is not supported on the above laptops. That means
that LVDS is always connected regardless of LID status.

At the same time on some boxes there is no ACPI LID event when the LID
is reopened. In such case we can't send the hotplug event to user space
when the LID is reopened. How about disable this feature on such box?
    For example: Aspire One.


I have another issue about the hotplug event.
On some boxes it will continue to report the LID event  when the LID is
closed. In such case we had better not send the hotplug event to user
space. Otherwise the user space will receive too many hotplug event
about LVDS. For example:
     http://bugzilla.kernel.org/show_bug.cgi?id=10485
     http://bugzilla.kernel.org/show_bug.cgi?id=5853

So it will be better that the feature of hotplug/LID status is not
supported on such boxes.

Thanks
    Yakui
    
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> ---
>  drivers/gpu/drm/i915/intel_lvds.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index 1d0d30a..57c86fd 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -599,12 +599,18 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
>  /**
>   * Detect the LVDS connection.
>   *
> - * This always returns CONNECTOR_STATUS_CONNECTED.  This connector should only have
> - * been set up if the LVDS was actually connected anyway.
> + * Since LVDS doesn't have hotlug, we use the lid as a proxy.  Open means
> + * connected and closed means disconnected.  We also send hotplug events as
> + * needed, using lid status notification from the input layer.
>   */
>  static enum drm_connector_status intel_lvds_detect(struct drm_connector *connector)
>  {
> -	return connector_status_connected;
> +	enum drm_connector_status status = connector_status_connected;
> +
> +	if (!acpi_lid_open())
> +		status = connector_status_disconnected;
> +
> +	return status;
>  }
>  
>  /**

