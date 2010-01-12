From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] drm/i915: Add HP nx9020/Samsung SX20S to ACPI LID
	quirk list
Date: Tue, 12 Jan 2010 08:44:09 +0800
Message-ID: <1263257049.12945.133.camel@localhost.localdomain>
References: <alpine.LFD.2.00.1001111744300.4076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63464 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab0ALAqI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jan 2010 19:46:08 -0500
In-Reply-To: <alpine.LFD.2.00.1001111744300.4076@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, David Airlie <airlied@linux.ie>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-01-12 at 06:47 +0800, Len Brown wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>

Hi, Len
	Thanks for caring this issue.
	Now this patch is already picked up by Eric. And it is Eric's
drm-intel-next tree.

Thanks.
    Yakui.
> 
> The HP comaq nx9020/Samsung SX20S laptop always report that the LID status is
> closed and we can't use it reliabily for LVDS detection. So add the two boxes
> into the quirk list.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=14957
> http://bugzilla.kernel.org/show_bug.cgi?id=14554
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Tested-by: Philipp Kohlbecher<xt28@gmx.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> 
> Dave,
> As this is an ACPI BIOS workaround bug that touches DRM code,
> if you ack this I'll be happy to send this upstream w/ your ack.
> 
> thanks,
> -Len
> 
>  drivers/gpu/drm/i915/intel_lvds.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index f4b4aa2..160283a 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -602,6 +602,20 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
>  /* Some lid devices report incorrect lid status, assume they're connected */
>  static const struct dmi_system_id bad_lid_status[] = {
>  	{
> +		.ident = "Compaq nx9020",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_BOARD_NAME, "3084"),
> +		},
> +	},
> +	{
> +		.ident = "Samsung SX20S",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Samsung Electronics"),
> +			DMI_MATCH(DMI_BOARD_NAME, "SX20S"),
> +		},
> +	},
> +	{
>  		.ident = "Aspire One",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

