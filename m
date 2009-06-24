From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Wed, 24 Jun 2009 13:20:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:65213 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbZFXRVB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2009 13:21:01 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLR00IOL6UKA0X1@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 24 Jun 2009 12:20:45 -0500 (CDT)
In-reply-to: <1245830585.31755.11.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

> Any thermal facility that doesn't take cpusets into account, or worse
> destroys user policy (the hotplug road), is a full stop in my book.
>
> Is similar to the saying the customer is always right, sure the admin
> can indeed configure the machine so that any thermal policy is indeed
> doomed to fail, and in that case I would print some warnings into syslog
> and let the machine die of thermal overload -- not our problem.
>
> The thing is, the admin configures it in a way, and then expects it to
> work like that. If any random event can void the guarantees what good
> are they?
> 
> Now, if ACPI-4.0 is so broken that it simply cannot support a sane
> thermal model, then I suggest we simply not support this feature and
> hope they will grow clue for 4.1 and try again next time.

Peter,
ACPI is just the messenger here - user policy in in charge,
and everybody agrees, user policy is always right.

The policy may be a thermal cap to deal with thermal emergencies
as gracefully as possible, or it may be an electrical cap to
prevent a rack from approaching the limits of the provisioned
electrical supply.

This isn't about a brain dead administrator, doomed thermal policy,
or a broken ACPI spec.  This mechanism is about trying to maintain
uptime in the face of thermal emergencies, and spending limited
electrical provisioning dollars to match, rather than grosely exceed,
maximum machine room requirements.

Do you have any fundamental issues with these goals?
Are we agreement that they are worth goals?

The forced-idle technique is employed after the processors have
all already been forced to their lowest performance P-state
and the power/thermal problem has not been resolved.

No, this isn't a happy scenario, we are definately impacting
performance.  However, we are trying to impact system performance
as little as possible while saving as much energy as possible.

After P-states are exhausted and the problem is not resolved,
the rack (via ACPI) asks Linux to idle a processor.
Linux has full freedom to choose which processor.
If the condition does not get resolved, the rack will ask us
to offline more processors.

If this technique fails, the rack will throttle the processors
down as low as 1/16th of their lowest performance P-state.
Yes, that is about 100MHz on most multi GHz systems...

If that fails, the entire system is powered-off.

Obviously, the approach is to impact performance as little as possible
while impacting energy consumption as much as possible.  Use the most
efficieint means first, and resort to increasingly invasive measures
as necessary...

I think we all agree that we must not break the administrator's
cpuset policy if we are asked to force a core to be idle -- for
whent the emergency is over,the system should return to normal
and bear not permanent scars.

The simplest thing that comes to mind is to declare a system
with cpusets or binding fundamentally incompatible with
forced idle, and to skip that technique and let the hardware
throttle all the processor clocks with T-states.

However, on aggregate, forced-idle is a more efficient way
to save energy, as idle on today's processors is highly optimized.

So if you can suggest how we can force processors to be idle
even when cpusets and binding are present in a system,
that would be great.

thanks,
-Len Brown, Intel Open Source Technology Center






