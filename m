From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH] CPPC: Initialize CPUFreq CPU co-ord type correctly
Date: Thu, 19 Nov 2015 10:27:42 -0500
Message-ID: <CAJ5Y-eY=fo=JT11CqYR09Nis--TLpdHtxo+JyC6nh07kVgUrdg@mail.gmail.com>
References: <1447375974-3736-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAJ5Y-eZ6LUd31B_oECmm5eV9ZyyFiOO0KNtYCGikuNSbgxCUEA@mail.gmail.com> <2881956.pxlD7qKz8I@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32900 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091AbbKSP2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 10:28:05 -0500
Received: by lfaz4 with SMTP id z4so50465305lfa.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 07:28:02 -0800 (PST)
In-Reply-To: <2881956.pxlD7qKz8I@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rafael Wysocki <rafael@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

Hi Rafael,

On 13 November 2015 at 19:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, November 13, 2015 03:47:43 PM Ashwin Chaugule wrote:
>> Hi Rafael,
>>
>> On 12 November 2015 at 19:52, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>> > The CPU policy struct indicates the co-ordination type
>> > for all CPUs of a common freq domain. Initialize it
>> > correctly using the CPU specific data gathered from
>> > CPPC ACPI lib via acpi_get_psd_map().
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > ---
>> >  drivers/cpufreq/cppc_cpufreq.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> > index 93c219f..508809b 100644
>> > --- a/drivers/cpufreq/cppc_cpufreq.c
>> > +++ b/drivers/cpufreq/cppc_cpufreq.c
>> > @@ -98,6 +98,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>> >         policy->max = cpu->perf_caps.highest_perf;
>> >         policy->cpuinfo.min_freq = policy->min;
>> >         policy->cpuinfo.max_freq = policy->max;
>> > +       policy->shared_type = cpu->shared_type;
>> >
>> >         if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
>> >                 cpumask_copy(policy->cpus, cpu->shared_cpu_map);
>> > --
>> > 1.9.1
>> >
>>
>> I apologize for not spotting this earlier, but I seem to have gotten
>> overzealous cleaning up code here. Can this make it into v4.4-rc1
>> along with what you've already pushed out?
>
> It's too late for -rc1, but I'll queue them up for -rc2.

I was working on a rather quirky system with only one CPU in a domain.
In such a case the _PSD object doesn't make sense but its also
supposed to be an optional object. This system had a PSD package with
Num CPUs = 1. The acpi_get_psd_map() routine (which I adapted from
acpi_processor_preregister_performance()) rightfully skips trying to
match PSDs when there is only one CPU. But it also skips reading the
co-ord type from the PSD if there is one. So what ends up happening is
that cpu->shared_type is always 0 and the cppc_cpufreq driver will
fail init on this CPU, since I only support TYPE_ANY. This will happen
even if there is no PSD object for this CPU.

So I think a better way to deal with this is to explicitly check if
shared_type == CPUFREQ_SHARED_TYPE_ALL then print out the Unsupported
co-ord type message. I'll send a patch along with this fix as a reply
to this mail.

Regards,
Ashwin.
