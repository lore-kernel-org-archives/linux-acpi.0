From: Dave Jones <davej@redhat.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
 governor - v2
Date: Thu, 4 Mar 2010 18:27:56 -0500
Message-ID: <20100304232756.GA13895@redhat.com>
References: <20100304231454.247805000@intel.com>
 <20100304231547.798303000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100304231547.798303000@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2010 at 03:14:56PM -0800, Venki Pallipadi wrote:
 
 > +	if (!strncmp(gov->name, "performance", strlen("performance")))
 > +		epb_val = ENERGY_PERF_BIAS_PERF;
 > +	else if (!strncmp(gov->name, "powersave", strlen("powersave")))
 > +		epb_val = ENERGY_PERF_BIAS_POWER;
 > +	else
 > +		epb_val = ENERGY_PERF_BIAS_ONDEMAND;
 > +
 > +	set_epb_on_cpu(epb_val, cpu);
 > +	return 0;

hardcoding a list of cpufreq governors is kinda icky, but I don't have
a better solution.  We'll just have to be mindful of it if we ever
get around to finally making performance/powersave personalities
of ondemand as was discussed years ago.

What if the governor is set to 'userspace' ?
powernowd/cpufreqd are sort of ondemand-done-in-userspace, but there
may also be other userspace governors we don't know about.
I suppose it's not catastrophic..

	Dave
