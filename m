From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPPC: Initialize CPUFreq CPU co-ord type correctly
Date: Sat, 14 Nov 2015 01:27:53 +0100
Message-ID: <2881956.pxlD7qKz8I@vostro.rjw.lan>
References: <1447375974-3736-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eZ6LUd31B_oECmm5eV9ZyyFiOO0KNtYCGikuNSbgxCUEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41678 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750908AbbKMX63 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2015 18:58:29 -0500
In-Reply-To: <CAJ5Y-eZ6LUd31B_oECmm5eV9ZyyFiOO0KNtYCGikuNSbgxCUEA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Rafael Wysocki <rafael@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

On Friday, November 13, 2015 03:47:43 PM Ashwin Chaugule wrote:
> Hi Rafael,
> 
> On 12 November 2015 at 19:52, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
> > The CPU policy struct indicates the co-ordination type
> > for all CPUs of a common freq domain. Initialize it
> > correctly using the CPU specific data gathered from
> > CPPC ACPI lib via acpi_get_psd_map().
> >
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 93c219f..508809b 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -98,6 +98,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >         policy->max = cpu->perf_caps.highest_perf;
> >         policy->cpuinfo.min_freq = policy->min;
> >         policy->cpuinfo.max_freq = policy->max;
> > +       policy->shared_type = cpu->shared_type;
> >
> >         if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> >                 cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> > --
> > 1.9.1
> >
> 
> I apologize for not spotting this earlier, but I seem to have gotten
> overzealous cleaning up code here. Can this make it into v4.4-rc1
> along with what you've already pushed out?

It's too late for -rc1, but I'll queue them up for -rc2.

Thanks,
Rafael

