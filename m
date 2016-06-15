From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
Date: Wed, 15 Jun 2016 16:30:07 +0100
Message-ID: <20160615153007.GR24029@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
 <20160615132246.GL24029@arm.com>
 <57617268.60705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38333 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863AbcFOPaL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 11:30:11 -0400
Content-Disposition: inline
In-Reply-To: <57617268.60705@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, mlangsdorf@redhat.com

On Wed, Jun 15, 2016 at 10:21:12AM -0500, Jeremy Linton wrote:
> On 06/15/2016 08:22 AM, Will Deacon wrote:
> >On Thu, Jun 09, 2016 at 05:23:32PM -0500, Jeremy Linton wrote:
> >>Its possible that an ACPI system has multiple CPU types in it
> >>with differing PMU counters. Use the newly provided acpi_pmu routines
> >>to detect that case, and instantiate more than one set of counters.
> >>
> >
> >[...]
> >
> >>+	pmus = kcalloc(num_possible_cpus(), sizeof(struct pmu_types),
> >>+		       GFP_KERNEL);
> >>+
> >>+	if (pmus) {
> >>+		arm_pmu_acpi_determine_cpu_types(pmus);
> >>+
> >>+		for (j = 0; pmus[j].cpu_count; j++) {
> >>+			pr_devel("CPU type %X, count %d\n", pmus[j].cpu_type,
> >>+				 pmus[j].cpu_count);
> >>+			res = kcalloc(pmus[j].cpu_count,
> >>+				      sizeof(struct resource), GFP_KERNEL);
> >
> >Given that you already have dynamic allocation in here, why not use a
> >linked-list for the pmus list, and avoid having a potentially huge temporary
> >data structure?
> 
> Sure... But, its really only going to be 2 entries on any existing system, I
> considered limiting this to something reasonable like "4" with a WARN()
> because who will ever build a machine with more than 4 different CPU types
> in it? <chuckle> Is that an acceptable solution, or do you prefer the list?

I do prefer the list, just because kcalloc(num_possible_cpus(), ...) could
be pretty large, and like you say, we're likely to need 2-3 entries in
practice.

Will
