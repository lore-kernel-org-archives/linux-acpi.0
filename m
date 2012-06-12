From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 0/4] Thermal Framework Enhancements
Date: Tue, 12 Jun 2012 14:28:31 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59136146@BGSMSX101.gar.corp.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <20120612131234.GF8724@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24478 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2FLO2j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 10:28:39 -0400
In-Reply-To: <20120612131234.GF8724@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

Hi Eduardo,

> 
> >
> > Patch 2/4: Introduce fair_share governor
> > 	   This throttles the cooling_devices according to their
> > 	   weights (and hence the name; Suggestion are welcome :-).
> > 	   The weights in turn describe the effectiveness of a
> > 	   particular cooling device in cooling a thermal zone.
> 
> For the purpose you mentioned the name sounds Ok.
> 
> On the other hand, Now I got a bit confused on this strategy.
> 
> Do you still keep the trip to cooling device binding constraints?
> Does it make sense to have this binding coming from the pdata
> description as well?

Yes it makes sense.
Now that we can have multiple active and passive trip points,
providing 'per-trip point binding' tends to become complex [1].

> > * Add more protection and tidy up the existing ones
> > * Expose the weights and cooling devices through sysfs (Read-Only)
> > * Remove all throttling related code(if we all agree) from thermal_sys.c
> 
> I do. +1

Thank you.

> > * If we all agree, use step_wise and remove linear_throttle from thermal_sys.c
> 
> Well, I guess I need first to understand the difference between those two.
> For instance, does it make sense to have a separate file for linear_throttle?

There is no difference. I remember specifying it in one of the comments in the
patches.

I was not sure about our opinions on separating throttle logic from thermal_sys.c
(even for simple linear throttle). That's why kept both of them here.

Now that we agree, I will remove throttling code inside thermal_sys.c,
and keep only step_wise_throttle. I hope this will make things clear,
and I will be able to split patches in a better way and make them smaller.
Will do this in my next patch set.

> > * Find a way to provide platform data so that we can map cooling devices
> >   for a trip point in a thermal zone.
> 
> Ohh ok.. Indeed, we need a way to describe the mappings and bindings.
> I am not sure how that goes into ACPI, but I guess it comes from firmware.
> 
> On non-ACPI world we still need to have that mapped somehow.

[1]
I thought through this, and (to me) it looks like a 3D mapping between
thermal zones -> cooling devices -> trip points of a thermal zone.
So, I simplified it and ended up with this 'weight' approach for fair_share
This can be a start, and we can take it forward from here..

I think this is a separate topic in itself, which would require one more
complete mail chain :-)

> 
> Your weighting patch is at least one attempt to start doing this mapping.
> I guess we need more brainstorming here..

Yes. Agree with you.

Thanks,
Durga
