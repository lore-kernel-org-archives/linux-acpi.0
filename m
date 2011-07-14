From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Wed, 13 Jul 2011 21:53:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1107131718270.9546@x980>
References: <alpine.LFD.2.02.1106060144310.6779@x980>
 <20110606071209.GA20080@isilmar-3.linta.de>
 <alpine.LFD.2.02.1106062353030.4784@x980>
 <20110607054226.GA22398@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:40238 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1GNCyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2011 22:54:04 -0400
In-reply-to: <20110607054226.GA22398@isilmar-3.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

On Tue, 7 Jun 2011, Dominik Brodowski wrote:

> > Instantaneous frequency can change many times per second.
> > What benefit is there to reporting someting that changes that fast
> > to readers of sysfs?
> 
> Same as there are reasons for wanting to know the average frequency, there
> are reasons for wanting to know the exact current frequency.

While "exact current frequency" meant something in the old days,
its value is diminished on a processor that autonomously
and continuously changes frequency w/o intervention from the OS.

All turbo-enabled processors from Intel do this -- and
the trend is that future processors will do more of it.

Recording the last request in policy->cur is useful.
Reporting the average in driver->getavg() is useful.
Reporting the instantaneous in driver->get()?  Not so much.

> E.g. to
> determine what's going on behind your back again (e.g. so-called "hardware
> coordination", "thermal throttling" etc.).

This is exactly why ondemand uses driver->getavg()
and does not use driver->get()!

> > > For silicon which can't be fixed any more

As the silicon isn't broken, it isn't going to be "fixed".

Yes, it is more complicated than the old days when the
OS not only had to decide on policy, but implmenet it
by telling the HW exactly what frequency to run at.

> > > using APERF instead may be a
> > > valid  -- but costly[*] -- solution. For other CPUs, I'd favour keeping
> > > the current code -- even if Intel CPUs aren't capable to reliably tell
> > > which frequency they're running at.
> > 
> > APERF is expensive how?
> 
> As you need to average, you need to spend some time between the first and
> the second call to read out aperf.

If  __cpufreq_driver_getavg() were not fast, we would not
have been using it in ondemand over the last 3 years.

> > > Finally:
> > > 
> > > > +	policy->cur = data->freq_table[data->acpi_data->state].frequency;
> > > 
> > > How do you know what state / frequency the CPU is running here?
> > 
> > really the correct fix is for the upper level of cpufreq to
> > simply no export this value at all, or to export the value
> > that was last written.  A driver should be free to decline
> > to supply any current value.
>
> You didn't answer the question of how it is assured that policy->cur is
> correctly initialized here.

Acutally, it doesn't matter.
If that line were replaced with "policy->cur = 1"
everything would work just fine.  It must be
initizlized to non-zero for ondemand to probe out;
and as you point out later, it gets overwritten anyway.

> To the other point you raise: This interface _is_ optional:
> 
>         /* should be defined, if possible */
>         unsigned int    (*get)  (unsigned int cpu);

Right, cpufreq_driver.get is optional.
The point of my patch is for acpi-cpufreq to "opt-out".

My point above wasn't about cpufreq_driver.get,
it was about policy->cur.

The driver should not have to initialize,
or even know about, policy->cur.

> We knew back when the interface was written that ACPI is problematic here,
> as it tries to hide valuable information.

This discussion is about how the HW works, not about ACPI.

> The value which was last written
> is exported, BTW, in scaling_cur_freq . But it is of much less value --
> _especially_ if some "black box" decides to use a different frequency
> than what the kernel told it.

The black box is the hardware.  I can't change how the HW works.

I have no problem with exporting policy->cur in scaling_cur_freq.

I do have a problem with 200 lines of code in a 750-line driver
with has the sole function of exporting the optinoal
cpuinfo_cur_freq in sysfs, only to get it wrong!

thanks,
Len Brown, Intel Open Source Technology Center
