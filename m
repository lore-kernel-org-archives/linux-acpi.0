From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 0/5] Making the generic ACPI GSI layer irqdomain aware
Date: Wed, 22 Jul 2015 14:45:52 +0800
Message-ID: <55AF3C20.2060103@linaro.org>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: linux-acpi@vger.kernel.org

Hi Marc,

On 07/21/2015 06:07 PM, Marc Zyngier wrote:
> The irqdomain code is not entierely really ACPI friendly, as it has
> some built-in knowledge of the device-tree. Nothing too harmful, but
> enough to scare the ARM ACPI developpers which end up with their own
> version of the square wheel.
>
> This small patch series adapt the irqdomain code to remove the hurdles
> that prevent the full blown irqdomain subsystem to be used on ACPI,
> creates an interface between the GSI layer and the irqdomain, and as
> an example, convert the ARM GIC ACPI support to use irqdomains as
> originally intended.
>
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure.
>
> I'd really like to hear what people think of that approach, as it
> looks to me a lot simpler than the other approaches currently put on
> the list. The "convert the GSI information to be DT friendly" is
> admitedly not very pretty, but I see it as a stepping stone towards
> unifying the two structures.
>
> This has been test-booted on Juno, and is based on my irq/ncpi-msi-2
> branch.

Thank you very much for putting them together, really appreciated. I
will comment on each patch and test them.

Thanks
Hanjun
