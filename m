From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH v7 6/7] cpufreq: Support for fast frequency
 switching
Date: Wed, 30 Mar 2016 10:37:32 +0530
Message-ID: <20160330050732.GE8773@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan>
 <16969991.55r1UouI6A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16969991.55r1UouI6A@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 30-03-16, 03:47, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -843,6 +883,7 @@ static int acpi_cpufreq_cpu_exit(struct
>  	pr_debug("acpi_cpufreq_cpu_exit\n");
>  
>  	if (data) {
> +		policy->fast_switch_possible = false;

Is this done just for keeping code symmetric or is there a logical advantage
of this? Just for my understanding, not saying that it is wrong.

Otherwise, it looks good

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
