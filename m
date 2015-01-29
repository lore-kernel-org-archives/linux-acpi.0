From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Thu, 29 Jan 2015 23:30:53 +0000
Message-ID: <20150129233053.GA24127@e104818-lin.cambridge.arm.com>
References: <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
 <54CA7A42.5080800@codeaurora.org>
 <CAKv+Gu_a6_zjt=MsRuQH2rr05XxDayy0gACtbPXZaDAyhWrigg@mail.gmail.com>
 <54CA7D4A.5090709@codeaurora.org>
 <54CA7F94.6000305@redhat.com>
 <20150129231120.GA23786@e104818-lin.cambridge.arm.com>
 <54CABF46.3050701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:46317 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbA2XbL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:31:11 -0500
Content-Disposition: inline
In-Reply-To: <54CABF46.3050701@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>"linux-arm-kernel@lists.infradead.org" <linux>

On Thu, Jan 29, 2015 at 11:16:22PM +0000, Jon Masters wrote:
> On 01/29/2015 06:11 PM, Catalin Marinas wrote:
> 
> > Sorry Jon but statements like this make me wonder whether we should
> > simply let the whole ARM ACPI be an out of tree distro business. We
> > spend a long time discussing OS-agnostic firmware implementation,
> > planning mini-summits, just to get certain Linux distro representative
> > stating that the kernel-firmware interface we discuss here only matters
> > for those planning to follow upstream. Certain Linux distros will play
> > by other rules.
> 
> Oh, don't take it that way - I just mean that if someone needs a
> different ACPI always on, they can do that separately.

And that's exactly what I'm trying to get consensus on. ACPI always on
together with DT always on, subject to config options being enabled (not
patching). It's up to firmware (and vendor) to provide only ACPI tables
to the kernel if not interested in DT. In such case I don't want to see
additional kernel parameters. But if the firmware provides both, then it
is a user choice which one to use, defaulting to DT.

-- 
Catalin
