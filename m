From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 9 Jan 2015 10:33:07 +0000
Message-ID: <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150107172741.GY2634@sirena.org.uk>
 <54AD7098.5010700@redhat.com>
 <1610983.9vqJdsL27R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1610983.9vqJdsL27R@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Robert Moore <robert.moore@intel.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 07, 2015 at 07:48:48PM +0000, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 12:44:56 Jon Masters wrote:
> > I'm expecting to need new drivers for SoC IP blocks that are net new,
> > but generational differences between iterations of the same SoC should
> > be abstracted behind the firmware (and we are already seeing this with
> > at least one platform). Platform wise, it's nice to already see e.g.
> > mmconfig working to handle the specific ways a platform wires PCI.
> 
> Yes, the parts that are mandated by SBSA, like the way that PCI needs
> to be done are generally good. Unfortunately a lot of the hardware that
> I've seen has a rather lax interpretation of the spec, so just because
> something is mandated doesn't mean it's done that way ;-)
> 
> In other cases that's actually a good thing. One such example is the
> "Principles of ARM Memory Maps" document that tells hardware implementers
> to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
> systems, such as Linux." but makes life much harder in the process than
> any of the random mappings we have seen in the wild.

Unfortunately, with any significant amount of RAM (say 16GB), this
document becomes pretty useless. It basically forces you to have a very
sparse physical address map from 0 to over 40-bit. I wouldn't apply the
ARM memory maps doc to server systems.

> * There is a general mindset about deprecating unwanted features
>   early. ARMv8 aarch32 bit mode removes support for older instructions
>   or makes them optional. Even the virtualization mode doesn't allow
>   to trap on architecture version specific differences, so you can't
>   completely emulate an older architecture level.
>   This is nice for implementers but not so much for users that rely
>   on old (mis-)features.

This mindset is (slowly) changing. There are, of course, instructions
like SWP that just can't always be implemented at the SoC level (not
necessarily CPU level; requiring bus locks) but others like CP15
barriers, I don't see why they should go away, it's just a decoder
problem.

>   It's also not just the CPU core, other components also get easily
>   replaced, like a GICv3 that is not a strict superset of GICv2.

That's not a problem for Linux, we can describe them in DT or ACPI and
have drivers. GICv3 has an optional GICv2 compatible mode, though
vendors may decide not to implement it.

-- 
Catalin
