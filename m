From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] acpi-cpufreq: remove unreliable get-frequency functions
Date: Mon, 6 Jun 2011 09:12:09 +0200
Message-ID: <20110606071209.GA20080@isilmar-3.linta.de>
References: <alpine.LFD.2.02.1106060144310.6779@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1106060144310.6779@x980>
Sender: cpufreq-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-acpi@vger.kernel.org

Hey Len,

On Mon, Jun 06, 2011 at 01:47:52AM -0400, Len Brown wrote:
> Reading the current frequency from PERF_STATUS
> is fundamentally unreliable for multiple reasons
> on multiple systems.
> 
> Indeed, one can make the case that the PERF_STATUS MSR
> should be deleted from the x86 architecture due to its
> ability to mis-lead.
> 
> The most common case of decpetion is P-state "hardware coordination"
> that is used on all HT and multi-core processors that share
> the same voltage regulator.  Here the hardware runs at the speed
> of the fastest sibling, and thus the "current frequency"
> on the sibling that asked for a slower frequency
> is erroneous 100% of the time.
> 
> For over 10 years, TM1 and TM2 have changed the frequency
> out from under the system due to thermal emergencies,
> without necessarily updating PERF_STATUS.
> 
> Finally, even on hardware that dutifully updates PERF_STATUS
> to reflect reality, there is a race condition between software
> reading the register and the changes above -- making it
> fundamentally un-relaible for determining frequency.
> 
> The reliable way to determine frequency is to simply ask the
> hardware how many unhalted cycles it has executed during a
> known period of time via the APERF MSR.  This is how
> turbostat and other utilities do it...
> 
> Delete the concept of reading the current frequency from acpi-cpufreq,
> and the unreliable code that is built upon it.
> 
> As the cpufreq interface has a concept of "cur" frequency,
> simply return the last request.  The reality is that 99% of the time
> it would have got that answer from reading the hardware anway,
> and so simply returning this cached value is no less accurate.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

NACK. Why can't it be fixed in silicon for future chips? May there be
workarounds possible in the CPU microcode? The APERF MSR is not a real
alternative to a real "get current frequency" function (which I have
wished to be added to the ACPI spec for how long? must be close to 10
years...): APERF only allows you to get an average frequency, and not the
current frequency at the time of the call.

For silicon which can't be fixed any more, using APERF instead may be a
valid  -- but costly[*] -- solution. For other CPUs, I'd favour keeping
the current code -- even if Intel CPUs aren't capable to reliably tell
which frequency they're running at.

Finally:

> +	policy->cur = data->freq_table[data->acpi_data->state].frequency;

How do you know what state / frequency the CPU is running here?

Best,
	Dominik

[*] This callback may be costly, as it is only accessible to root. 
