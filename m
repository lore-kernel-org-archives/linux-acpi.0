From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Fri, 1 Jul 2016 16:23:40 +0100
Message-ID: <20160701152340.GO12735@arm.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <5351858.jEb0qfTvrF@vostro.rjw.lan>
 <2f0e60e1-f429-2bd3-5f26-fd6199e64f34@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan>
 <57714bed-3f9c-90c2-ac30-2d462d8a06d4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57714bed-3f9c-90c2-ac30-2d462d8a06d4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Suravee
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 30, 2016 at 09:48:02PM +0800, Hanjun Guo wrote:
> On 2016/6/30 21:27, Rafael J. Wysocki wrote:
> >On Thursday, June 30, 2016 10:10:02 AM Hanjun Guo wrote:
> >>GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> >>ACPI spec, I think it can stay in drivers/acpi/ from this point
> >>of view, am I right?
> >
> >The question is not "Can it?", but "Does it need to?".
> >
> >It is in the spec, but still there's only one architecture needing it.
> >
> >There is no way to test it on any other architecture and no reason to build it
> >for any other architecture, so why does it need to be located in drivers/acpi/ ?
> 
> I'm fine to move it to other places such as arch/arm64/kernel/, but I
> would like to ask ARM64 maintainer's suggestion for this.
> 
> Will, Catalin, what's your opinion on this?

We don't have any device-tree code for the architected timer under
arch/arm64, so I don't see why we should need anything for ACPI either.

Will
