From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: fix build regression without IOMMU
Date: Mon, 28 Aug 2017 10:57:59 +0100
Message-ID: <20170828095759.GB8471@e107981-lin.cambridge.arm.com>
References: <20170810121114.2509560-1-arnd@arndb.de>
 <20170810142430.GA17205@red-moon>
 <3fe9e409-b505-f9af-63b7-02e91918db9d@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdH1J6F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 05:58:05 -0400
Content-Disposition: inline
In-Reply-To: <3fe9e409-b505-f9af-63b7-02e91918db9d@leemhuis.info>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <jroedel@suse.de>, Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 28, 2017 at 11:27:20AM +0200, Thorsten Leemhuis wrote:
> On 10.08.2017 16:24, Lorenzo Pieralisi wrote:
> > On Thu, Aug 10, 2017 at 02:11:00PM +0200, Arnd Bergmann wrote:
> >> A recent change reintroduced a bug that had previously been
> >> fixed by commit d49f2dedf33b ("ACPI/IORT: Fix CONFIG_IOMMU_API
> >> dependency"):
> >>
> >> drivers/acpi/arm64/iort.c: In function 'iort_iommu_configure':
> >> drivers/acpi/arm64/iort.c:829:26: error: 'struct iommu_fwspec' has no member named 'ops'
> >>
> >> This does the same change again, replacing another direct
> >> reference to iommu_fwspec->ops with a helper function call.
> >>
> >> Fixes: bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for IOMMUs")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/acpi/arm64/iort.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Sorry Arnd, thanks, I will send it to Catalin straight away.
> 
> Was there any progress? Afaics that patch hasn't hit mainline yet (or
> was it fixed by a different patch?). Asking because the issue is
> mentioned in the regression report for 4.13.

I do not understand how it can be mentioned in the 4.13 regression
report given that it is code queued for 4.14 and it is not in the
mainline that triggered the regression. Anyway, fix is queued along
with other patches and it is in -next (coming from arm64 tree):

commit: 4d36037a9a07

Does this answer your question ?

Lorenzo
