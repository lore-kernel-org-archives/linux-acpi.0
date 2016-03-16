From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Wed, 16 Mar 2016 22:34:05 +0100
Message-ID: <18019025.4XNzhZv1I6@vostro.rjw.lan>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan> <11678919.CQLTrQTYxG@vostro.rjw.lan> <20160316173646.GE6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48841 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751510AbcCPVcD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 17:32:03 -0400
In-Reply-To: <20160316173646.GE6344@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wednesday, March 16, 2016 06:36:46 PM Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> > +		if ((s64)delta_ns > NSEC_PER_SEC / HZ)
> 
> That's TICK_NSEC

OK (I didn't know we had a separate symbol for that)

