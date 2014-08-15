From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC 0/3] Experimental patchset for CPPC
Date: Fri, 15 Aug 2014 06:53:15 -0700
Message-ID: <53EE10CB.7040001@linux.intel.com>
References: <1408046230-16439-1-git-send-email-ashwin.chaugule@linaro.org>	<20140814205143.GY6758@twins.programming.kicks-ass.net>	<CAJ5Y-ebgJi8Ngxg1X+h7KMundGZPFhYC0hr0Sog6htj=czszgQ@mail.gmail.com>	<20140815061917.GX19379@twins.programming.kicks-ass.net> <CAJ5Y-eaLxCG7dDao00pozXBL2dxPS7tf=xGfaz3O_xfRHtQZnA@mail.gmail.com> <53EE0E5B.3050004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <53EE0E5B.3050004@linux.intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, mingo@kernel.org, len.brown@intel.com, rjw@rjwysocki.net, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Patch Tracking <patches@linaro.org>, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 8/15/2014 6:42 AM, Arjan van de Ven wrote:
> On 8/15/2014 6:08 AM, Ashwin Chaugule wrote:
>> (b) we come up with ways to provide the bounds around a Desired value
>> using the information from the platform. (long term)
>>
>> I briefly looked at the x86 HWP (Hardware Performance States) in the
>> s/w manual again. Its essentially an implementation of CPPC. It seems
>> like X86 has implemented most if not all these registers as MSRs. I'm
>> really interested in knowing if anyone there is/has been working on
>> using them and what they found.
>
> we've found that so far that there are two reasonable options
> 1) Let the OS device (old style)
> 2) Let the hardware decide (new style)
>
> 2) is there in practice today in the turbo range (which is increasingly the whole thing)
> and the hardware can make decisions about power budgetting on a timescale the OS
> can never even dream of, so once you give control the the hardware (with CPPC or native)
> it's normally better to just get out of the way as OS.
>

I should clarify this; with increasing number of cores, you end up with much more dynamic maximums
(e.g. turbo in Intel speak) and the hardware already controls this (yes the OS gives hints, but
that's mostly a lot of OS work for little value)


in a single or even dual core situation you may have a different ballgame with a small turbo range, but even in phones
octocores seem to be the norm nowadays ;-)
(just finished reading the Samsung announcement)

