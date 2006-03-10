From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: acpi resume
Date: Fri, 10 Mar 2006 23:47:16 +0000
Message-ID: <E1FHrKG-0007Rr-00@skye.ra.phy.cam.ac.uk>
References: <F7DC2337C7631D4386A2DF6E8FB22B30065968E6@hdsmsx401.amr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:11410 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752254AbWCJXrX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Mar 2006 18:47:23 -0500
In-Reply-To: Your message of "Fri, 10 Mar 2006 14:02:46 EST."
             <F7DC2337C7631D4386A2DF6E8FB22B30065968E6@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, linux-acpi@vger.kernel.org, Patrick Mochel <mochel@linux.intel.com>

> The "acpi drivers" themselves don't have suspend/resume methods yet.
> Others need them too, the biggest is the button driver that needs to
> forget events that happened during suspend, and the next one is
> probably thermal, which doesn't restore the user-supplied
> trip-points.

The change to therml would fix at least one issue (4364).  Also 'fan',
at least on my TP 600X with the modified DSDT (have to try it with the
vanilla DSDT), would benefit from resume magic to make its idea of the
fan state matches the actual fan state.  

Here's how the problem shows up.  When the machine is running hot, you
put it to sleep, and the hardware shuts off the fan maybe without all
software knowing that it's off.  You wake it up soon, while it is
still warm enough that the fan should be on.  The ACPI drivers will
think that the fan is on, since it got turned off underneath them, and
not try to turn the fan on.  So the machine get ever warmer with no
fan, which is a bit dangerous.  

Matthew Garret suggested a workaround [msg of Thu, 16 Feb 2006
17:30:47 GMT, 'Re: confused fan after S3 resume (TP 600X)']:

  here's what I have in the Ubuntu resume script:

  for x in /proc/acpi/fan/*; do
      if [ "`grep on $x/state`" ]; then
	  echo -n 3 > $x/state;
	  echo -n 0 > $x/state;
      fi
  done

However, that didn't turn the fan on here.  Instead, upon wake I set
the trip point high so that the system turns off the fan.  Now the
system's idea of the fan state matches the actual state of the fan.
Then I lower the trip point to its desired value.  The fan will turn
on if the trip point went below the thermal zone's temperature.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
