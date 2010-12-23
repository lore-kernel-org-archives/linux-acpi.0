From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH 6/6] cpufreq: Evaluate P1 before enter turbo mode
Date: Thu, 23 Dec 2010 10:13:54 -0800
Message-ID: <AANLkTi=XkMqUSfO076mVqGCHv-Kw-jnuL8dZiN17ypqZ@mail.gmail.com>
References: <1293085424-18212-1-git-send-email-youquan.song@intel.com>
	<1293085424-18212-2-git-send-email-youquan.song@intel.com>
	<1293085424-18212-3-git-send-email-youquan.song@intel.com>
	<1293085424-18212-4-git-send-email-youquan.song@intel.com>
	<1293085424-18212-5-git-send-email-youquan.song@intel.com>
	<1293085424-18212-6-git-send-email-youquan.song@intel.com>
	<1293085424-18212-7-git-send-email-youquan.song@intel.com>
	<20101223105730.GB18363@comet.dominikbrodowski.net>
	<20101223143859.GA1402@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20101223143859.GA1402@srcf.ucam.org>
Sender: cpufreq-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Youquan Song <youquan.song@intel.com>, davej@redhat.com, cpufreq@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 23, 2010 at 6:38 AM, Matthew Garrett <mjg@redhat.com> wrote:
> On Thu, Dec 23, 2010 at 11:57:30AM +0100, Dominik Brodowski wrote:
>
>> NACK. First of all, why is it only a "turbo mode" if it's 1000 kHz
>> difference?
>
> I believe that that's how it's supposed to be defined for Intel systems,
> but you're right that this doesn't belong in generic code. AMD have
> support for enabling/disabling their equivalent functionality through
> sysfs - I'd say that copying that interface and using it to limit the
> set of p-states provided to the core makes more sense.
>

If this 1000kHz hack is needed, it should be in acpi-cpufreq driver
along with Intel CPU and Turbo mode capability check..
I had a change earlier and I don't think I ever pushed it out. But, it
was doing the max freq transition on turbo capable CPUs in 2 steps.
Something like:
- cpu is in one of the low freqs.
- ondemand asks for highest freq.
- acpi-cpufreq will check whether the CPU is turbo capable and will
only switch to non-turbo peak freq as first step.
- If ondemand asks for highest freq again, acpi-cpufreq will then
switch to turbo freq.

Something like that would probably help the problem here?

Thanks,
Venki


Thanks,
Venki
