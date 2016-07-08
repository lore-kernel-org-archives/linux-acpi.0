From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Fri, 8 Jul 2016 14:50:26 +0100
Message-ID: <577FAFA2.6040509@arm.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <1890708.ZTyM2PUGdP@vostro.rjw.lan> <20160707134023.GA655@red-moon>
 <1603704.EGiVTcCxLR@vostro.rjw.lan> <20160708132201.GD3784@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42948 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245AbcGHNue (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jul 2016 09:50:34 -0400
In-Reply-To: <20160708132201.GD3784@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redh>



On 08/07/16 14:22, Lorenzo Pieralisi wrote:
> On Thu, Jul 07, 2016 at 03:58:04PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
>>> Anyway let's avoid these petty arguments, I agree there must be some
>>> sort of ARM64 ACPI maintainership for the reasons you mentioned above.
>>
>> To avoid confusion on who's going to push stuff to Linus, I can do
>> that, but it must be clear whose ACKs are needed for that to happen.
>> That may be one person or all of you, whatever you decide.
>
> I think the reasoning is the same, to avoid confusion and avoid stepping
> on each other toes it is best to have a single gatekeeper (still
> multiple maintainer entries to keep patches reviewed correctly), if no
> one complains I will do that and a) provide ACKs (I will definitely
> require and request Hanjun and Sudeep ones too appropriately on a per
> patch basis) and b) send you pull requests.
>
> Having a maintainer per file would be farcical, I really do not
> expect that amount of traffic for drivers/acpi/arm64 therefore

I agree.

> I really doubt there is any risk of me slowing things down.
>
> Does this sound reasonable ? Comments/complaints welcome, please
> manifest yourselves.
>

Yes sounds good to me.

-- 
Regards,
Sudeep
