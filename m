From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] ARM64 / SMP: Switch pr_err() to pr_debug() for
 disabled GICC entry
Date: Fri, 3 Jul 2015 12:01:37 +0100
Message-ID: <20150703110136.GJ25907@e104818-lin.cambridge.arm.com>
References: <1435908546-11457-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52745 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429AbbGCLBl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Jul 2015 07:01:41 -0400
Content-Disposition: inline
In-Reply-To: <1435908546-11457-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>

On Fri, Jul 03, 2015 at 03:29:06PM +0800, Hanjun Guo wrote:
> It is normal that firmware presents GICC entry or entries (processors)
> with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
> ACPI firmware may present 8 ebabled first with another 8 cpus disabled
> in MADT, the disabled cpus can be hot-added later.
> 
> Firmware may also present more cpus than the hardware actually has, but
> disabled the unused ones, and easily enable it when the hardware has such
> cpus to make the firmware code scalable.
> 
> So that's not an error for disabled cpus in MADT, we can switch pr_err()
> to pr_debug() to make the boot a little quieter by default.
> 
> Since hwid for disabled cpus often are invalid, and we check invalid hwid
> fisrt in the code, for use case that hot add cpus later will be filtered
> out and will not be counted in possible cups, so move this check before
> the hwid one to prepare the code to count for disabeld cpus when cpu
> hot-plug is introduced.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Applied. Thanks.

-- 
Catalin
