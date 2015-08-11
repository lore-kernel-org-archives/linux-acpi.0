From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
Date: Tue, 11 Aug 2015 18:33:44 -0500
Message-ID: <55CA8658.80202@codeaurora.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>	<55CA70D5.6040300@codeaurora.org>	<20150811232523.60d192d2@arm.com>	<55CA78DE.1000306@codeaurora.org> <20150811234801.51108784@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150811234801.51108784@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 08/11/2015 05:48 PM, Marc Zyngier wrote:
> I don't see any contradiction here. Hanjun picked the patches from my
> own branch in my own tree, put his own patches on top, and pushed that
> out on an branch called gsi-irqdomain that is definitely based on
> 4.2-rc2. I have no idea where your 3.9-rc7 comes from.

Ok, so that's not your kernel, but the LEG kernel instead.

The top commits show this:

Follows: tracking-mainline-llct-20130415.0, 
tracking-mainline-llct-20130417.0, v3.9-rc7

Also,
	$ git tag | grep v4

shows no v4.x tags.

Anyway, I don't want to make a big deal about this.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
