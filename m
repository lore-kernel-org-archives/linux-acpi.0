From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
Date: Thu, 1 Sep 2016 15:30:37 +0100
Message-ID: <20160901143037.GL6721@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-9-git-send-email-jeremy.linton@arm.com>
 <8737lro9lq.fsf@e105922-lin.cambridge.arm.com>
 <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754167AbcIAObB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Sep 2016 10:31:01 -0400
Content-Disposition: inline
In-Reply-To: <b4d5397f-2ab0-8c19-d36e-ea23edb71bfb@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

On Fri, Aug 26, 2016 at 05:44:59PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 08/26/2016 10:04 AM, Punit Agrawal wrote:
> (trimming)
> >>+			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
> >>+			if (!pmu) {
> >>+				pr_warn("Unable to allocate pmu_types\n");
> >>+				/*
> >>+				 * continue to count cpus for any pmu_types
> >>+				 * already allocated, but don't allocate any
> >>+				 * more pmu_types. This avoids undercounting.
> >>+				 */
> >>+				alloc_failure = true;
> >
> >Why not just fail probe and return an error? What is the benefit of
> >having some of the PMUs available?
> 
> AFAIC, there isn't a good reason for penalizing PMU's which we can get
> working if a subset of the system PMUs can't be created. But this is per PMU
> type, so with current systems the kzalloc will be called a max of 2 times
> (there is the potential of a 3rd time, due to some other error handling, but
> that doesn't change the argument much). AKA, this doesn't result in "partial
> registration" of a PMU.

... but this will look mighty confusing to userspace, where things will
appear to "half-work", if for some reason the machine makes it that far
at all.

I think we should stick with the KISS approach and just fail the probe
as Punit is suggesting.

Will
