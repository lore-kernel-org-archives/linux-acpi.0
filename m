From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Thu, 2 Feb 2006 00:03:22 +0100
Message-ID: <20060201230322.GA11924@poupinou.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005E8FE7F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:38448 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1423011AbWBAXD1
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Feb 2006 18:03:27 -0500
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005E8FE7F@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Jan 31, 2006 at 09:35:05PM -0500, Brown, Len wrote:
> 
> >On Fri, Jan 27, 2006 at 02:05:23PM -0500, Brown, Len wrote:
> >> Also, you may find that the current speedstep-centrino
> >> is able to load on this system.  Without hard-coded tables
> >> for this processor family/model/stepping, it too would use
> >> the ACPI PSS, but it would use native MSR access, which
> >> is lower overhead than the IO port access used by acpi-cpufreq.
> >> (in the future, acpi-cpufreq and speedstep-centrino should
> >> be combined into a single driver)
> >
> >Do you mean you want to combine all possible drivers into only
> >one?  That is at that time of writing:
> >
> >acpi-cpufreq (IO version), speedstep-centrino, powernow-k7
> >and powernow-k8?
> >
> >Well, it might be possible that some cpufreq devellopers
> >would be against this approach I'm afraid.
> 
> acpi-cpufreq + speedstep-centrino = intel-enhanced-speedstep

I see.  I thought you wanted to kill processor_perflib.c.  I was
indeed wrong.  I would like to point that acpi-cpufreq could also be
somewhat in "conflict" with speedstep-smi and speedstep-ich.
That remind me that acpi-cpufreq is not only intel enhanced speedstep (a
la Pentium Mobile, or Xeons, I means), but can work on some Pentium III
or IV IIRC.

> unless you can think of a better name.  Both acpi-cpufreq
> and speedstep-centrino turn out not to be good names,
> since they don't describe either the function of the driver
> or what hardware they run on.

Especially for speedstep-centrino.  I'm not sure for acpi-cpufreq
though, but it's true this driver works only with Intel processors.

> No, it wouldn't' make sense to combine the intel and amd drivers.

Well, a BIOS writer could write a SMI handler (after all,
they have the right to do what they want) in order to support
acpi-cpufreq for an AMD processor, but I highly doubt this will
ever happens.  It's simply too late now.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
