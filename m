From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 0/4] gicv2m: acpi: Add ACPI support for GICv2m MSI
Date: Wed, 9 Dec 2015 21:07:25 -0600
Message-ID: <5668EC6D.7020305@amd.com>
References: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <CADaLNDkF_-6Odo6ygyuUVSNdcq93stC-pyGTXEoBDUizPzd99Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0100.outbound.protection.outlook.com ([65.55.169.100]:23840
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751881AbbLJDHe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Dec 2015 22:07:34 -0500
In-Reply-To: <CADaLNDkF_-6Odo6ygyuUVSNdcq93stC-pyGTXEoBDUizPzd99Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, G Gregory <graeme.gregory@linaro.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On 12/9/2015 8:20 PM, Duc Dang wrote:
>> This has been tested on AMD Seattle (Overdrive) RevB system.
>> >
>> >NOTE: I have not tested ACPI GICv2m multiframe support since
>> >I don't have access to such system. Any helps are appreciated.
> Hi Suravee,
>
> I tested your v2m-multiframe-v6 branch with APM X-Gene 2 that has
> multiple GICv2m frames and it worked.
>
> Please feel free to add:
> Tested-by: Duc Dang<dhdang@apm.com>
>

Thanks Duc.

Marc, if you decide to add take V6 would you please also add the Tested-by?

Thanks,
Suravee
