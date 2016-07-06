From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 05/11] arm64: pmu: Add support for probing with ACPI
Date: Wed, 6 Jul 2016 17:45:09 +0100
Message-ID: <20160706164509.GD31910@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-6-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59168 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbcGFQpK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jul 2016 12:45:10 -0400
Content-Disposition: inline
In-Reply-To: <1466529109-21715-6-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, Lorenzo.Pieralisi@arm.com, alexander.shishkin@linux.intel.com, acme@kernel.org, mingo@redhat.com, peterz@infradead.org, mlangsdorf@redhat.com, punit.agrawal@arm.com, Steve.Capper@arm.com

On Tue, Jun 21, 2016 at 12:11:43PM -0500, Jeremy Linton wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> In the case of ACPI, the PMU IRQ information is contained in the
> MADT table. Also, since the PMU does not exist as a device in the
> ACPI DSDT table, it is necessary to create a platform device so
> that the appropriate driver probing is triggered.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
> 
> NOTE: Much of the code in pmu_acpi_init() is replaced in patches 0009 and
>       0010 this set. The later version of the patch cleans up most of the
>       possible style/error handling issues that have been pointed out with
>       this version.

I agree with Punit that it would be a lot easier to review this series
if you could fold in the changes to pmu_acpi_init so the sum of the
changes can be viewed in one patch.

Will
