From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 0/4] Thermal Framework Enhancements
Date: Tue, 12 Jun 2012 16:12:34 +0300
Message-ID: <20120612131234.GF8724@besouro>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:35754 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095Ab2FLNMp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 09:12:45 -0400
Received: by obbun3 with SMTP id un3so9428293obb.11
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jun 2012 06:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org

Hello,

On Mon, Jun 11, 2012 at 11:09:30PM +0530, Durgadoss R wrote:
> This patch series attempts to add some simple governors/
> throttling algorithms to the generic thermal layer.
> Although this patch set creates simple governors which depend
> on the platform data provided, we can start here, and write
> some really smart algorithms that will do the wonder!!
> 
> Patch 1/4: Creates necessary infrastructure required to
> 	   add throttling algorithms in thermal_sys.c
> 	   1. Introduces the get_trend callback
> 	   2. Introduces the notify_thermal_framework() API
> 	   3. Exposes sysfs to show/store the throttle_policy

You forgot to mention the linear throttle and the notification
mechanism that you have introduced.

As I mentioned in the patch itself, I'd propose to split it into smaller changes.

> 
> Patch 2/4: Introduce fair_share governor
> 	   This throttles the cooling_devices according to their
> 	   weights (and hence the name; Suggestion are welcome :-).
> 	   The weights in turn describe the effectiveness of a
> 	   particular cooling device in cooling a thermal zone.

For the purpose you mentioned the name sounds Ok.

On the other hand, Now I got a bit confused on this strategy.

Do you still keep the trip to cooling device binding constraints?
Does it make sense to have this binding coming from the pdata
description as well?

> 
> Patch 3/4: Introduce step_wise governor
> 	   This throttles/de-throttles the cooling devices one
> 	   step at a time. This is exactly similar to the code
> 	   we have in thermal_zone_device_update function. The
> 	   intention is to move all 'throttling logic' related
> 	   code outside thermal_sys.c and keep them separate.
> 
> Patch 4/4: Platform data patch
> 	   This patch is not for merge. Just as an example to
> 	   show how we can provide platform data to thermal
> 	   framework. Not that we do not know how to fill structures,
> 	   I felt the patch set is in-complete without this. That's
> 	   why it is here. From next versions, I will ignore this one.
> 
> TODO on these patch sets:
> * Sync up with Rui's latest patches
> * Add more protection and tidy up the existing ones
> * Expose the weights and cooling devices through sysfs (Read-Only)
> * Remove all throttling related code(if we all agree) from thermal_sys.c

I do. +1

> * In fair_share, before setting new state, check if there are other zones,
>   which do not want the 'state' to be changed.
>   (To do this, we have to loop through the thermal_tz_list and 
>   thermal_cdev_list inside fair_share.c. Need to see how good it is
>   to make this lists public)
> * If we all agree, use step_wise and remove linear_throttle from thermal_sys.c

Well, I guess I need first to understand the difference between those two.
For instance, does it make sense to have a separate file for linear_throttle?

> * Enhance notify_user_space(), so that the use land can extract some sane
>   information out of UEvent.
> 
> WishList:
> * Find a way to provide platform data so that we can map cooling devices
>   for a trip point in a thermal zone.

Ohh ok.. Indeed, we need a way to describe the mappings and bindings.
I am not sure how that goes into ACPI, but I guess it comes from firmware.

On non-ACPI world we still need to have that mapped somehow.

Your weighting patch is at least one attempt to start doing this mapping.
I guess we need more brainstorming here..

> * Make all _throttle methods have same signature. This way we can make use
>   of function pointers and make the code a bit simpler.
> * The simple governors heavily depend on the platform data provided. We
>   can think of some really smart logic, that depends on very minimal platform
>   data, and do things on its own :-)

Not sure what exactly you meant here..

> * Make other subsystem core files register with the thermal framework as a
>   thermal sensor or as a cooling device as appropriate.
>   (I am thinking of Power Supply, Video, cpufreq for now)
> * Ah, Find time to do all this !

Heh... I suppose, as I mentioned before, we need to be more structured and
organize tree/branches and split the work.

I will send a couple of clean up patches as starters.

> 
> Durgadoss R (4):
>   RFC Thermal: Enhance Generic Thermal layer with policies
>   RFC Thermal: Introduce fair-share thermal governor
>   RFC Thermal: Introduce a step-wise thermal governor
>   RFC Thermal: Platform layer changes to provide thermal data
> 
>  Documentation/thermal/sysfs-api.txt |   26 +++
>  arch/x86/platform/mrst/mrst.c       |   39 ++++
>  drivers/thermal/Kconfig             |   13 ++
>  drivers/thermal/Makefile            |    4 +-
>  drivers/thermal/fair_share.c        |  111 ++++++++++
>  drivers/thermal/step_wise.c         |   86 ++++++++
>  drivers/thermal/thermal_sys.c       |  383 ++++++++++++++++++++++++++---------
>  include/linux/thermal.h             |   55 +++++
>  8 files changed, 620 insertions(+), 97 deletions(-)
>  create mode 100644 drivers/thermal/fair_share.c
>  create mode 100644 drivers/thermal/step_wise.c
> 
