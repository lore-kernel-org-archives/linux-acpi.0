From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 7/7] arm: pmu: Add PMU definitions for cores not
 initially online
Date: Thu, 15 Dec 2016 17:08:11 +0000
Message-ID: <20161215170810.GJ10481@arm.com>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
 <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
 <20161206152118.GK2498@arm.com>
 <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933409AbcLORII (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Dec 2016 12:08:08 -0500
Content-Disposition: inline
In-Reply-To: <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, punit.agrawal@arm.com, steve.capper@arm.com, msalter@redhat.com, mlangsdorf@redhat.com, linux@armlinux.org.uk

On Tue, Dec 06, 2016 at 11:56:56AM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 12/06/2016 09:21 AM, Will Deacon wrote:
> >On Fri, Dec 02, 2016 at 12:56:01PM -0600, Jeremy Linton wrote:
> >>ACPI CPUs aren't associated with a PMU until they have been put
> >>online. This means that we potentially have to update a PMU
> >>definition the first time a CPU is hot added to the machine.
> >>
> >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>---
> >> drivers/perf/arm_pmu.c       | 38 ++++++++++++++++++++++++++++++++++++--
> >> include/linux/perf/arm_pmu.h |  4 ++++
> >> 2 files changed, 40 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> >>index fa40294..4abb2fe 100644
> >>--- a/drivers/perf/arm_pmu.c
> >>+++ b/drivers/perf/arm_pmu.c
> >>@@ -711,6 +711,30 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
> >> 	return 0;
> >> }
> >>
> >>+static DEFINE_SPINLOCK(arm_pmu_resource_lock);
> >
> >Why do you need this spinlock? The hotplug notifiers are serialised afaik,
> >and you don't take it anywhere else.
> 
> Well, I assumed they were serialized, but then I went looking for a
> guarantee and couldn't find one specific to the notifiers, even though the
> previous lock was removed. 

They should be serialised either by virtue of them all running off the back
of a single CPU (because the hotplug thread hasn't yet been created), or
by the st->done completion for the hotplug work threads.

Will
