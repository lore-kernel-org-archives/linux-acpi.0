From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4] Thermal Framework Enhancements
Date: Tue, 12 Jun 2012 15:44:41 +0800
Message-ID: <1339487081.1973.13.camel@rui.sh.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1097 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab2FLHnF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 03:43:05 -0400
In-Reply-To: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org

On =E4=B8=80, 2012-06-11 at 23:09 +0530, Durgadoss R wrote:
> This patch series attempts to add some simple governors/
> throttling algorithms to the generic thermal layer.

Oh, this is something what I want to do, but not sure when.
Thanks, Durga.

> Although this patch set creates simple governors which depend
> on the platform data provided, we can start here, and write
> some really smart algorithms that will do the wonder!!
>=20
> Patch 1/4: Creates necessary infrastructure required to
> 	   add throttling algorithms in thermal_sys.c
> 	   1. Introduces the get_trend callback
seems duplicate work of my patch set. :(

> 	   2. Introduces the notify_thermal_framework() API

> 	   3. Exposes sysfs to show/store the throttle_policy
>=20
yes, I think we need this.

> Patch 2/4: Introduce fair_share governor
> 	   This throttles the cooling_devices according to their
> 	   weights (and hence the name; Suggestion are welcome :-).
> 	   The weights in turn describe the effectiveness of a
> 	   particular cooling device in cooling a thermal zone.
>=20

> Patch 3/4: Introduce step_wise governor
> 	   This throttles/de-throttles the cooling devices one
> 	   step at a time. This is exactly similar to the code
> 	   we have in thermal_zone_device_update function. The
> 	   intention is to move all 'throttling logic' related
> 	   code outside thermal_sys.c and keep them separate.

totally agree.
This is in my TODO list as well. :)

BTW, we may need an easy "userspace" governor as well.

>=20
> Patch 4/4: Platform data patch
> 	   This patch is not for merge. Just as an example to
> 	   show how we can provide platform data to thermal
> 	   framework. Not that we do not know how to fill structures,
> 	   I felt the patch set is in-complete without this. That's
> 	   why it is here. From next versions, I will ignore this one.
>=20
> TODO on these patch sets:
> * Sync up with Rui's latest patches

agreed.

> * Add more protection and tidy up the existing ones
> * Expose the weights and cooling devices through sysfs (Read-Only)

what do you mean "cooling devices"?

> * Remove all throttling related code(if we all agree) from thermal_sy=
s.c

Ack!

> * In fair_share, before setting new state, check if there are other z=
ones,
>   which do not want the 'state' to be changed.

Yep, I think this is handled in my arbitrator patch. :p

>   (To do this, we have to loop through the thermal_tz_list and=20
>   thermal_cdev_list inside fair_share.c. Need to see how good it is
>   to make this lists public)

IMO, these governors should just update the thermal_instance, and then
invokes thermal_zone_do_update(). They should not change the cooling
state directly.

> * If we all agree, use step_wise and remove linear_throttle from ther=
mal_sys.c

agreed.

> * Enhance notify_user_space(), so that the use land can extract some =
sane
>   information out of UEvent.
>=20
> WishList:
> * Find a way to provide platform data so that we can map cooling devi=
ces
>   for a trip point in a thermal zone.

hmm, what information do we need except "weight"?
I think we can register the weight information when do the binding, lik=
e
I did for "upper" and "lower" limits.

> * Make all _throttle methods have same signature. This way we can mak=
e use
>   of function pointers and make the code a bit simpler.

what does signature mean?

> * The simple governors heavily depend on the platform data provided. =
We
>   can think of some really smart logic, that depends on very minimal =
platform
>   data, and do things on its own :-)
> * Make other subsystem core files register with the thermal framework=
 as a
>   thermal sensor or as a cooling device as appropriate.
>   (I am thinking of Power Supply, Video, cpufreq for now)

about cpufreq, I think Amit has some work on this. hah

> * Ah, Find time to do all this !
>=20
me too. :)

Again, thanks for your work, they are good ideas.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
