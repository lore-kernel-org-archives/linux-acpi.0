From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH V3 0/6] gicv2m: acpi: Add ACPI support for GICv2m MSI
Date: Fri, 30 Oct 2015 09:03:55 -0500
Message-ID: <563378CB.9090005@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <CADaLNDnhn+Lax6aMseA4kPsAfKHG=L0buO6Tf-U8sxfUzn38BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0092.outbound.protection.outlook.com ([207.46.100.92]:4160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964769AbbJ3OEA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Oct 2015 10:04:00 -0400
In-Reply-To: <CADaLNDnhn+Lax6aMseA4kPsAfKHG=L0buO6Tf-U8sxfUzn38BA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi Duc

On 10/29/15 16:25, Duc Dang wrote:
> Hi Suravee,
> On Wed, Oct 21, 2015 at 11:47 AM, Suravee Suthikulpanit
> <Suravee.Suthikulpanit@amd.com>  wrote:
>> >This patch series has been forked from the following patch series since
>> >it no longer depends on the rest of the patches.
>> >
>> >   [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
>> >   https://lkml.org/lkml/2015/7/29/234
>> >
>> >It has been ported to use the newly introduced device fwnode_handle
>> >for ACPI irqdmain introduced by Marc in the following patch series:
>> >
>> >   [PATCH v2 00/17] Divorcing irqdomain and device_node
>> >   http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git  irq/irq-domain-fwnode-v2
>> >
>> >The following git branch contains the submitted patches along with
>> >the pre-requsite patches (mainly for ARM64 PCI support for ACPI).
>> >
>> >   https://github.com/ssuthiku/linux.git  v2m-multiframe-v3
> I tried to clone your tree to test on my X-Gene platform but I didn't
> see branch v2m-multiframe-v3.
> I see similar patch set in origin/irq-domain-fwnode-v2-v2m-multiframe.
> Can you please check?
>

It should be there now. I might have forgotten to push it to my Github. 
Sorry for inconvenience, and thanks for testing.

Suravee
