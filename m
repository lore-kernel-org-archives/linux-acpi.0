From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] Kernel splat when taking CPUs offline
Date: Thu, 9 Jul 2015 09:34:45 +0530
Message-ID: <20150709040445.GG1805@linux>
References: <20150708152456.4438d60f@gandalf.local.home>
 <1625417.XZkzNdoaJA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1625417.XZkzNdoaJA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Saravana Kannan <skannan@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 09-07-15, 02:13, Rafael J. Wysocki wrote:
> So the cpufreq driver's ->get() callback returns 0 for the given CPU and
> that's what triggers the WARN_ON().  And it most likely returns 0, because
> its internal data structure for that CPU is not present.
> 
> I *guess* that before the above commit policy was NULL in cpufreq_update_policy()
> and we didn't get to the point where ->get() was called.

I am not sure if that behavior should have changed at all.. Earlier we
were clearing per-cpu cpufreq_cpu_data for offline CPUs and so policy
would have been NULL for offline CPUs.

Now that per-cpu variable isn't cleared, but cpufreq_cpu_get() does
check if the CPU is part of policy->cpus or not, i.e. if it is
offline. And so policy should still be NULL for offline CPUs.

I think it might be related to what I chased down yesterday:

http://marc.info/?l=linux-kernel&m=143633485824975&w=2

@Steven: Can you please give this a try ?

-- 
viresh
