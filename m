From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Wed, 4 Feb 2015 17:52:56 +0000
Message-ID: <20150204175256.GH26006@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <54D245E2.2030003@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41247 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966708AbbBDRxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 12:53:20 -0500
Content-Disposition: inline
In-Reply-To: <54D245E2.2030003@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: "msalter@redhat.com" <msalter@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.>

On Wed, Feb 04, 2015 at 04:16:34PM +0000, Timur Tabi wrote:
> On 02/04/2015 10:08 AM, Mark Salter wrote:
> > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > which are already included in the kernel's linear RAM mapping. So we
> > need ioremap_cache to avoid two mappings to the same physical page
> > having different caching attributes.
> 
> Would it be possible to modify ioremap() so that it can tell whether the 
> memory is already mapped in some way, and then use a compatible remapping?

No. We have some semantics for ioremap() and it should return
non-cacheable mapping.

ioremap_cache() checks whether the page is RAM already and returns the
existing kernel linear mapping on arm64.

-- 
Catalin
