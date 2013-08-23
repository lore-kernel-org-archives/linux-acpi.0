From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] drm/i915: try not to lose backlight CBLV precision
Date: Fri, 23 Aug 2013 16:00:30 +0800
Message-ID: <5217169E.4080500@intel.com>
References: <1377244239-32594-1-git-send-email-jani.nikula@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14303 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab3HWH75 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Aug 2013 03:59:57 -0400
In-Reply-To: <1377244239-32594-1-git-send-email-jani.nikula@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 08/23/2013 03:50 PM, Jani Nikula wrote:
> ACPI has _BCM and _BQC methods to set and query the backlight
> brightness, respectively. The ACPI opregion has variables BCLP and CBLV
> to hold the requested and current backlight brightness, respectively.
> 
> The BCLP variable has range 0..255 while the others have range
> 0..100. This means the _BCM method has to scale the brightness for BCLP,
> and the gfx driver has to scale the requested value back for CBLV. If
> the _BQC method uses the CBLV variable (apparently some implementations
> do, some don't) for current backlight level reporting, there's room for
> rounding errors.
> 
> Use DIV_ROUND_UP for scaling back to CBLV to get back to the same values
> that were passed to _BCM, presuming the _BCM simply uses bclp = (in *
> 255) / 100 for scaling to BCLP.
> 
> Reference: https://gist.github.com/aaronlu/6314920
> Reported-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> 
> ---
> 
> All of https://gist.github.com/aaronlu/6314920 included here for
> reference:
> 
> A typical ASL code for the backlight control method _BCM with Intel
> graphics card is as follows:
> 
>         Method (_BCM, 1, NotSerialized)
>         {
>             If (BRNC)
>             {
>                 AINT (One, Arg0)
>             }
>             Else
>             {
>                 ^^^LPCB.EC0.STBR ()
>             }
>         }
> _BCM method takes one param: the target brightness level in the range
> of 0-100. The BRNC variable is set if bit2 of _DOS's param is set,
> which we do for Win8 systems now, so AINT will be executed.
> 
> And the simplified ASL code for AINT on backlight control is:
> 
>         Method (AINT, 2, Serialized)
>         {
>             If (LEqual (Arg0, One))
>             {
>                 Store (Divide (Multiply (Arg1, 0xFF), 0x64, ), BCLP)
>                 Or (BCLP, 0x80000000, BCLP)
>                 Store (0x02, ASLC)
>             }
>         }
> 
> The ASLC/BCLP are variables declared in IGD operation region. BCLP is
> used to store the target brightness level in the range of 0-255. Due to
> the mismatch of the level range in _BCM and BCLP, a convert is done here
> for BCLP. The setting of the ASLC variable will trigger interrupt of the
> graphics card and the GPU driver will find out this is due to IGD operation
> region and will handle the irq accordingly. In backlight case, it will
> set backlight level in the GPU driver according to the value of BCLP.
> 
> So the setting of backlight is actually done in GPU driver, even though
> it is triggered through firmware's interface. A side note is, there are
> ASL implementations that would trigger the SMI handler on backlight
> control and that would also result in GPU driver's irq handler and GPU
> driver will handle backlight setting then.
> 
> So this is how to make use of IGD operation region to do the backlight
> brightness level control.
> 
> There is a problem related to _BQC though on some firmware implementation.
> _BQC is a control method provided by firmware to tell which backlight
> level the firmware thinks the device is in. The broken implementation is:
> 
>         Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
>         {
>             If (LGreaterEqual (MSOS (), OSW8))
>             {
>                 And (CBLV, 0x7FFFFFFF, Local0)
>                 Return (Local0)
>             }
>         }
> 
> CBLV is a variable in IGD operation region, used to represent the
> current brightness level in the range of 0-100 and is updated by
> GPU driver everytime it is asked to set the backlight level.
> 
> Say user wants to set target level to 8, then 8 will be converted to
> 20(8 * 255 / 100) for BCLP in AINT, then in GPU driver, 20 will be
> converted again to 7(20 * 100 / 255) for CBLV, so _BQC will return 7
> afterwards though user actually sets 8 in _BCM. But this doesn't happen
> for every level set through _BCM, for those values that do not lose
> precisions during the conversion back and forth like 20 are not affected.
> This needs to be remembered when enhancing the quirk logic of _BQC,
> unless we can somehow fix the problem.
> 
> Some firmware doesn't have this problem as they simply store the target
> level user has requested in _BCM in a variable and then return that
> variable in _BQC, but then we probably do not need to evaluate _BQC at
> all since we also know what level the device should be in too in ACPI
> video module.
> 
> PS: The above example ASL code is taken from a ASUS NV5Z system.
> ---
>  drivers/gpu/drm/i915/intel_opregion.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
> index cfb8fb6..119771f 100644
> --- a/drivers/gpu/drm/i915/intel_opregion.c
> +++ b/drivers/gpu/drm/i915/intel_opregion.c
> @@ -173,7 +173,7 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
>  		return ASLE_BACKLIGHT_FAILED;
>  
>  	intel_panel_set_backlight(dev, bclp, 255);
> -	iowrite32((bclp*0x64)/0xff | ASLE_CBLV_VALID, &asle->cblv);
> +	iowrite32(DIV_ROUND_UP(bclp * 100, 255) | ASLE_CBLV_VALID, &asle->cblv);
>  
>  	return 0;
>  }
> 

