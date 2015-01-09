From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 09 Jan 2015 11:55:51 +0100
Message-ID: <3341506.a2BFqPNg3k@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1610983.9vqJdsL27R@wuerfel>
 <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Robert Moore <robert.moore@intel.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, "jcm@redhat.com" <jcm@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Friday 09 January 2015 10:33:07 Catalin Marinas wrote:
> On Wed, Jan 07, 2015 at 07:48:48PM +0000, Arnd Bergmann wrote:

> > In other cases that's actually a good thing. One such example is the
> > "Principles of ARM Memory Maps" document that tells hardware implementers
> > to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
> > systems, such as Linux." but makes life much harder in the process than
> > any of the random mappings we have seen in the wild.
> 
> Unfortunately, with any significant amount of RAM (say 16GB), this
> document becomes pretty useless. It basically forces you to have a very
> sparse physical address map from 0 to over 40-bit. I wouldn't apply the
> ARM memory maps doc to server systems.

Are you sure? I was under the impression that this document was targetted
specifically at servers.

> >   It's also not just the CPU core, other components also get easily
> >   replaced, like a GICv3 that is not a strict superset of GICv2.
> 
> That's not a problem for Linux, we can describe them in DT or ACPI and
> have drivers. GICv3 has an optional GICv2 compatible mode, though
> vendors may decide not to implement it.

I'm aware that we can deal with it after we have the drivers. My point
was that we are unable to deal with this problem in general if we want
to run existing kernels on new hardware that contains e.g. a GICv4/5/6
that requires a new driver which has to first be written and then
backported into distro kernels.

	Arnd
