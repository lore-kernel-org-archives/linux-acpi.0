From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Tue, 7 Jun 2011 07:42:26 +0200
Message-ID: <20110607054226.GA22398@isilmar-3.linta.de>
References: <alpine.LFD.2.02.1106060144310.6779@x980> <20110606071209.GA20080@isilmar-3.linta.de> <alpine.LFD.2.02.1106062353030.4784@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:59867 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750801Ab1FGFm3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2011 01:42:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1106062353030.4784@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>

On Tue, Jun 07, 2011 at 12:07:46AM -0400, Len Brown wrote:
> > Why can't it be fixed in silicon for future chips?
> > May there be workarounds possible in the CPU microcode?
> 
> Not going to happen.
> 
> > The APERF MSR is not a real
> > alternative to a real "get current frequency" function (which I have
> > wished to be added to the ACPI spec for how long? must be close to 10
> > years...): APERF only allows you to get an average frequency, and not the
> > current frequency at the time of the call.
> 
> Instantaneous frequency can change many times per second.
> What benefit is there to reporting someting that changes that fast
> to readers of sysfs?

Same as there are reasons for wanting to know the average frequency, there
are reasons for wanting to know the exact current frequency. E.g. to
determine what's going on behind your back again (e.g. so-called "hardware
coordination", "thermal throttling" etc.).

> > For silicon which can't be fixed any more, using APERF instead may be a
> > valid  -- but costly[*] -- solution. For other CPUs, I'd favour keeping
> > the current code -- even if Intel CPUs aren't capable to reliably tell
> > which frequency they're running at.
> 
> APERF is expensive how?

As you need to average, you need to spend some time between the first and
the second call to read out aperf.

> > Finally:
> > 
> > > +	policy->cur = data->freq_table[data->acpi_data->state].frequency;
> > 
> > How do you know what state / frequency the CPU is running here?
> 
> really the correct fix is for the upper level of cpufreq to
> simply no export this value at all, or to export the value
> that was last written.  A driver should be free to decline
> to supply any current value.

You didn't answer the question of how it is assured that policy->cur is
correctly initialized here.

To the other point you raise: This interface _is_ optional:

        /* should be defined, if possible */
        unsigned int    (*get)  (unsigned int cpu);

We knew back when the interface was written that ACPI is problematic here,
as it tries to hide valuable information. The value which was last written
is exported, BTW, in scaling_cur_freq . But it is of much less value --
_especially_ if some "black box" decides to use a different frequency
than what the kernel told it.

Best,
	Dominik
