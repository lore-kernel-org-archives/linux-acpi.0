From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/8] arm64: pmu: add fallback probe table
Date: Wed, 15 Jun 2016 11:59:43 +0100
Message-ID: <20160615105943.GG24029@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-2-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36564 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbcFOK7s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 06:59:48 -0400
Content-Disposition: inline
In-Reply-To: <1465511013-10742-2-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, mlangsdorf@redhat.com

On Thu, Jun 09, 2016 at 05:23:26PM -0500, Jeremy Linton wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> In preparation for ACPI support, add a pmu_probe_info table to
> the arm_pmu_device_probe() call. This table gets used when
> probing in the absence of a devicetree node for PMU.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 8 +++++++-
>  include/linux/perf/arm_pmu.h   | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)

This is likely to do the wrong thing for big/little systems, so I'm not
keen on this for DT. We should mandate that the PMU is described there.

If you need this as a building block for ACPI, please ensure that the
code is only executed when booting via ACPI.

Will
