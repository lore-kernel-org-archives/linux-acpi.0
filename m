From: "Brown, Len" <len.brown@intel.com>
Subject: RE: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Tue, 31 Jan 2006 21:35:05 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005E8FE7F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:34456 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S964895AbWBACfl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2006 21:35:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: linux-acpi@vger.kernel.org


>On Fri, Jan 27, 2006 at 02:05:23PM -0500, Brown, Len wrote:
>> Also, you may find that the current speedstep-centrino
>> is able to load on this system.  Without hard-coded tables
>> for this processor family/model/stepping, it too would use
>> the ACPI PSS, but it would use native MSR access, which
>> is lower overhead than the IO port access used by acpi-cpufreq.
>> (in the future, acpi-cpufreq and speedstep-centrino should
>> be combined into a single driver)
>
>Do you mean you want to combine all possible drivers into only
>one?  That is at that time of writing:
>
>acpi-cpufreq (IO version), speedstep-centrino, powernow-k7
>and powernow-k8?
>
>Well, it might be possible that some cpufreq devellopers
>would be against this approach I'm afraid.

acpi-cpufreq + speedstep-centrino = intel-enhanced-speedstep

unless you can think of a better name.  Both acpi-cpufreq
and speedstep-centrino turn out not to be good names,
since they don't describe either the function of the driver
or what hardware they run on.

No, it wouldn't' make sense to combine the intel and amd drivers.

-Len
