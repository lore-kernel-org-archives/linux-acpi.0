From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
Date: Thu, 12 Mar 2015 10:14:29 +0000
Message-ID: <55016705.5010406@arm.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org> <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com> <20150311231141.GG21998@io.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150311231141.GG21998@io.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, linaro-acpi <linaro-acpi@lists.linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Robert Richter <rric@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.inf
List-Id: linux-acpi@vger.kernel.org

On 11/03/15 23:11, Jason Cooper wrote:
> Hey Grant,
> 
> On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
>> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
>>>
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>
>>> ACPI kernel uses MADT table for proper GIC initialization. It needs to
>>> parse GIC related subtables, collect CPU interface and distributor
>>> addresses and call driver initialization function (which is hardware
>>> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>>>
>>> NOTE: This commit allow to initialize GICv1/2 basic functionality.
>>> While now simple GICv2 init call is used, any further GIC features
>>> require generic infrastructure for proper ACPI irqchip initialization.
>>> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
>>> extension, GICv3/4 and its ITS are considered as next steps.
>>>
>>> CC: Jason Cooper <jason@lakedaemon.net>
>>> CC: Marc Zyngier <marc.zyngier@arm.com>
>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>
>> BTW, Thomas is taking a bit of a break, do he is unlikely to give an ack
>> here in a timely manner. I've not heard from Jason. Personally, I think we
>> can proceed without their ack if everything else is in order (heck, I used
>> to help with the irq subsystem, use me as an ack of you want). The patch is
>> low impact and only had effect for ARM ACPI builds.
> 
> I'm not talking much, but I am tracking and collecting everything for irqchip.
> We do have some other changes in this driver this time around.  So it'd be nice
> if I could take this.
> 
> I had reached out to Olof for his thoughts on this and he hasn't had enough
> cycles to look at it.  iirc, Marc reviewed a previous version and was happy with
> the changes.

FWIW, and given the prominent "NOTE" in the commit message, please have my:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
