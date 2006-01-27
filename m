From: "Brown, Len" <len.brown@intel.com>
Subject: RE: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Fri, 27 Jan 2006 14:05:23 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005DD43C6@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:63899 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932367AbWA0TFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2006 14:05:31 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Marco Giumelli <mr.giumo@gmail.com>, linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

>> I wish the repository of DSDTs on sourceforge.net would simply GO
>> AWAY for this reason. It is a crutch that makes Linux WORSE, NOT
>> BETTER.
>
>I too run Linux (Fedora Core) on a TravelMate 4001WLMi[1]. I needed to
>change the DSDT since it returned the wrong values for the processor
>speeds (!) which, I have been assured, is not an uncommon problem. No
>other changes were necessary. In fact, I could have continued using
>the unmodified DSDT except for the frequencey scaling.

This is mostly a cosmetic, rather than functional fix.
Changing the MHz values in the 1st slot of each PSS entry
will change the numbers you see in /sysfs.  It can also
have a small effect on how a governor such as ondemand
chooses the next state, since the % of maximum for each state
are now slightly different.  Eg. for P2, original 1200/1600 is 75%,
but modified 1000/1500 is 67%.  But either of these 13% from 
P1 (88% original, 80% modified) and 19% & 14% above the
original and correct P3 -- so is isn't going to make much
difference on which state is slected for a given workload.
I'd be impressed if you were able to measure any difference.

As the PERF_CTRL values in the patches _PSS are unchanged,
The actual MHz that the processor runs at when a certain
P-state is selected is unmodified.

If I were to hack the DSDT, probably a more interesting thing
to do would be fill in CPSS with some of the entries from PPSS
to give your system P-states when on AC power.

Also, you may find that the current speedstep-centrino
is able to load on this system.  Without hard-coded tables
for this processor family/model/stepping, it too would use
the ACPI PSS, but it would use native MSR access, which
is lower overhead than the IO port access used by acpi-cpufreq.
(in the future, acpi-cpufreq and speedstep-centrino should
be combined into a single driver)

>For the smart battery, I use the original, EC based implementation by
>Rich Townsend, and it works like a charm.
>
>Later (AFAIK) Rich went to a DSDT-based approach of the smart battery
>problem. I personally prefer the EC based version.

The DSDT-based approach is an interesting science project,
but it has no place in a product.  Distros would be crazy
to support users running modified platform firmware.

The EC smart battery driver has been on the list several times,
most recently from Vladimir, and that is the direction to go
to get a distro to support SB out of the box.  I expect it
to be upstream shortly -- the hold-up was the EC update.

>[1] 
>http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/index.html

great job getting your laptop running and sharing your notes
for others to benefit from your experience!  The only thing
I didn't notice there was a copy of /proc/cpuinfo

cheers,
-Len
