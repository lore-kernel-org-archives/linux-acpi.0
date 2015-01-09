From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 9 Jan 2015 15:13:43 +0000
Message-ID: <20150109151342.GE24408@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1610983.9vqJdsL27R@wuerfel>
 <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
 <3341506.a2BFqPNg3k@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3341506.a2BFqPNg3k@wuerfel>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Robert Moore <robert.moore@intel.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 09, 2015 at 10:55:51AM +0000, Arnd Bergmann wrote:
> On Friday 09 January 2015 10:33:07 Catalin Marinas wrote:
> > On Wed, Jan 07, 2015 at 07:48:48PM +0000, Arnd Bergmann wrote:
> 
> > > In other cases that's actually a good thing. One such example is the
> > > "Principles of ARM Memory Maps" document that tells hardware implementers
> > > to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
> > > systems, such as Linux." but makes life much harder in the process than
> > > any of the random mappings we have seen in the wild.
> > 
> > Unfortunately, with any significant amount of RAM (say 16GB), this
> > document becomes pretty useless. It basically forces you to have a very
> > sparse physical address map from 0 to over 40-bit. I wouldn't apply the
> > ARM memory maps doc to server systems.
> 
> Are you sure? I was under the impression that this document was targetted
> specifically at servers.

Ah, sorry for the confusion, I haven't read the latest (apparently from
2012) update which covers 44 and 48-bit memory maps.

The only downside is that for more than 32GB of RAM (up to 512GB) it
requires a 40-bit memory map. Given the sparseness, we can't use
3-levels of page table with 4KB pages which can only cover 39-bit.
Anyway, not a major issue.

-- 
Catalin
