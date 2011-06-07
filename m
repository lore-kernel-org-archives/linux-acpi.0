From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Tue, 07 Jun 2011 00:07:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1106062353030.4784@x980>
References: <alpine.LFD.2.02.1106060144310.6779@x980>
 <20110606071209.GA20080@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20110606071209.GA20080@isilmar-3.linta.de>
Sender: cpufreq-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-acpi@vger.kernel.org

> Why can't it be fixed in silicon for future chips?
> May there be workarounds possible in the CPU microcode?

Not going to happen.

> The APERF MSR is not a real
> alternative to a real "get current frequency" function (which I have
> wished to be added to the ACPI spec for how long? must be close to 10
> years...): APERF only allows you to get an average frequency, and not the
> current frequency at the time of the call.

Instantaneous frequency can change many times per second.
What benefit is there to reporting someting that changes that fast
to readers of sysfs?

> For silicon which can't be fixed any more, using APERF instead may be a
> valid  -- but costly[*] -- solution. For other CPUs, I'd favour keeping
> the current code -- even if Intel CPUs aren't capable to reliably tell
> which frequency they're running at.

APERF is expensive how?

ondemand, which does care about average frequency,
has been using APERF for years.

> Finally:
> 
> > +	policy->cur = data->freq_table[data->acpi_data->state].frequency;
> 
> How do you know what state / frequency the CPU is running here?

really the correct fix is for the upper level of cpufreq to
simply no export this value at all, or to export the value
that was last written.  A driver should be free to decline
to supply any current value.

thanks,
Len Brown, Intel Open Source Technology Center

