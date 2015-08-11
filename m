From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3
 support
Date: Tue, 11 Aug 2015 23:48:01 +0100
Message-ID: <20150811234801.51108784@arm.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
	<55CA70D5.6040300@codeaurora.org>
	<20150811232523.60d192d2@arm.com>
	<55CA78DE.1000306@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55391 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbbHKWsj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Aug 2015 18:48:39 -0400
In-Reply-To: <55CA78DE.1000306@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tue, 11 Aug 2015 23:36:14 +0100
Timur Tabi <timur@codeaurora.org> wrote:

> On 08/11/2015 05:25 PM, Marc Zyngier wrote:
> > My branch, as far as I can tell by looking at my own git tree, is based
> > on v4.2-rc2. As for "the LEG kernel", I have no idea what that is. I
> > only work on this thing called "the Linux kernel". You may have heard
> > of it!;-)
> 
> Then what is this:
> 
> git://git.linaro.org/leg/acpi/acpi.git
>                       ^^^
> 
> This is your tree, isn't it?  

My tree would have "maz" in it, and would rather be hosted on
kernel.org.

> Hanjun said, "Patches are on top of Marc's 
> branch irq/gsi-irq-domain-v2, and available at: 
> git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain".

I don't see any contradiction here. Hanjun picked the patches from my
own branch in my own tree, put his own patches on top, and pushed that
out on an branch called gsi-irqdomain that is definitely based on
4.2-rc2. I have no idea where your 3.9-rc7 comes from.

	M.
-- 
Jazz is not dead. It just smells funny.
