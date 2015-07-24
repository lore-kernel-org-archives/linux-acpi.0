From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 0/7] Making the generic ACPI GSI layer irqdomain aware
Date: Fri, 24 Jul 2015 16:27:52 +0800
Message-ID: <55B1F708.3010804@linaro.org>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36326 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbGXI2D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 04:28:03 -0400
Received: by pachj5 with SMTP id hj5so10811517pac.3
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2015 01:28:01 -0700 (PDT)
In-Reply-To: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>

Hi Marc,

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
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
> This has been test-booted on Juno, is based on my irq/ncpi-msi-v3
> branch, and available at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v2

Pulled and rebased my self-probing and GICv3 ACPI support patches on
top of it, tested on FVP and QEMU, booted OK, for this patch set,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

I will sync with Suravee to prepare a single patch for
ACPI self-probing, GICv2m and GICv3 support.

Thank you for putting thing together!
Hanjun

