From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v11 7/7] arm: pmu: Add PMU definitions for cores not
 initially online
Date: Wed, 7 Dec 2016 11:08:23 +0000
Message-ID: <20161207110823.GA7054@leverpostej>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
 <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
 <20161206152118.GK2498@arm.com>
 <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752630AbcLGLJR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Dec 2016 06:09:17 -0500
Content-Disposition: inline
In-Reply-To: <457894f4-67f8-9d32-ee8b-5a34e9a21488@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, punit.agrawal@arm.com, steve.capper@arm.com, msalter@redhat.com, mlangsdorf@redhat.com, linux@armlinux.org.uk

On Tue, Dec 06, 2016 at 11:56:56AM -0600, Jeremy Linton wrote:
> Hi,

> Which might not be the right choice because
> even without these ACPI specific bits, simply running a few cpus
> online/offline while simultaneously doing something like `perf stat
> -e cache-misses ls &` in a loop causes deadlocks/crashes.
> 
> That problem doesn't appear to be specific to the ACPI/PMU so I've
> stayed away from it in this patch set, although potentially a larger
> fix might cover this as well.

Urrgh; I can reproduce lockups on Seattle with v4.9-rc8.

I'll look into that.

If you see any more issues in this area, please report them in a new
thread.

Thanks,
Mark.
