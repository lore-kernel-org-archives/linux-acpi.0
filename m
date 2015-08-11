From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3
 support
Date: Tue, 11 Aug 2015 23:25:23 +0100
Message-ID: <20150811232523.60d192d2@arm.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
	<55CA70D5.6040300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CA70D5.6040300@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 Aug 2015 23:01:57 +0100
Timur Tabi <timur@codeaurora.org> wrote:

> On 07/29/2015 05:08 AM, Hanjun Guo wrote:
> > Patches are on top of Marc's branch irq/gsi-irq-domain-v2, and available
> > at:
> >
> > git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain
> 
> Is it my imagination, or is Marc's branch based on v3.9-rc7?

That's definitely your imagination. I've stopped working on 3.9 over
two years ago...

> Also, shouldn't this code be based on the upstream kernel, and not the 
> LEG kernel?

My branch, as far as I can tell by looking at my own git tree, is based
on v4.2-rc2. As for "the LEG kernel", I have no idea what that is. I
only work on this thing called "the Linux kernel". You may have heard
of it! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
