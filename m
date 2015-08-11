From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
Date: Tue, 11 Aug 2015 17:01:57 -0500
Message-ID: <55CA70D5.6040300@codeaurora.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 07/29/2015 05:08 AM, Hanjun Guo wrote:
> Patches are on top of Marc's branch irq/gsi-irq-domain-v2, and available
> at:
>
> git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain

Is it my imagination, or is Marc's branch based on v3.9-rc7?

Also, shouldn't this code be based on the upstream kernel, and not the 
LEG kernel?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
