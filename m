From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
Date: Tue, 10 Mar 2015 20:23:03 +0800
Message-ID: <54FEE227.4000808@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-19-git-send-email-hanjun.guo@linaro.org> <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37447 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbCJMXO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 08:23:14 -0400
Received: by pdbnh10 with SMTP id nh10so1382067pdb.4
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2015 05:23:13 -0700 (PDT)
In-Reply-To: <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.

On 2015=E5=B9=B403=E6=9C=8807=E6=97=A5 01:47, Lorenzo Pieralisi wrote:
> On Wed, Feb 25, 2015 at 08:39:58AM +0000, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> ACPI reduced hardware mode is disabled by default, but ARM64
>> can only run properly in ACPI hardware reduced mode, so select
>> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.
>
> Agreed. This will remove unneeded acpica code. I think though,
> you should also check the FADT flag HW_REDUCED_ACPI at boot to
> make sure that the tables are HW reduced compliant. I am flagging

Agreed, I will add that check on top of this patch set. We explicitly
stated that we are using hardware reduced mode on ARM64 in the doc, so,=
=20
how about print some warning message and go on with the boot if we
got the wrong flag HW_REDUCED_ACPI at boot?

> this up because I noticed code in core code (not guarded by
> ifdef) that checks:
>
> acpi_gbl_reduced_hardware
>
> and if it is not set it goes on instantiating fixed HW devices.
>
> drivers/acpi/scan.c:2567
>
> It is just a heads up, I think it is harmless, but one thing is
> removing acpica code on ACPI HW reduced only, the other is to make
> sure the kernel does not try to use ACPI HW features that acpica
> can't support.

I agree, need some cleanups for the ACPICA code I think, and this
was raised about 1 and half years ago and Intel folks need more
consideration on that [1].

[1]: http://comments.gmane.org/gmane.linux.acpi.devel/63844

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
