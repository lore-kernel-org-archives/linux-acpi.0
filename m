From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Thu, 05 Feb 2015 08:54:07 -0500
Message-ID: <1423144447.18187.110.camel@deneb.redhat.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
	 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
	 <2422968.Es7R0p3loO@vostro.rjw.lan>
	 <1422984576.18187.82.camel@deneb.redhat.com>
	 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
	 <1423066107.18187.99.camel@deneb.redhat.com>
	 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
	 <1423076294.18187.103.camel@deneb.redhat.com>
	 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbbBENz0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Feb 2015 08:55:26 -0500
In-Reply-To: <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaur>

On Thu, 2015-02-05 at 10:41 +0000, Catalin Marinas wrote:
> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
> > On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
> > > On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
> > > > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > > > which are already included in the kernel's linear RAM mapping. So we
> > > > need ioremap_cache to avoid two mappings to the same physical page
> > > > having different caching attributes.
> > > 
> > > What's the call path to acpi_os_ioremap() on such tables already in the
> > > linear mapping? I can see an acpi_map() function which already takes
> > > care of the RAM mapping case but there are other cases where
> > > acpi_os_ioremap() is called directly. For example,
> > > acpi_os_read_memory(), can it be called on both RAM and I/O?
> > 
> > acpi_map() is the one I've seen.
> 
> By default, if should_use_kmap() is not patched for arm64, it translates
> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
> current kernel linear mapping on arm64.

The problem with kmap() is that it only maps a single page. I've seen
tables over 4k which is why I patched acpi_map() not to use kmap() on
arm64.

> 
> > I'm not sure about others.
> 
> Question for the ARM ACPI guys: what happens if you implement
> acpi_os_ioremap() on arm64 as just ioremap()? Do you get any WARN_ON()
> (__ioremap_caller() checks whether the memory is RAM)?
> 


