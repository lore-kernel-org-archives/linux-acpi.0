From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 5/6] arm64: add support for ACPI Low Power Idle(LPI)
Date: Fri, 8 Jul 2016 16:21:51 +0100
Message-ID: <577FC50F.7010205@arm.com>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-2-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-5-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-6-git-send-email-sudeep.holla@arm.com>
 <20160708144719.GI3784@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43661 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932371AbcGHPVz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jul 2016 11:21:55 -0400
In-Reply-To: <20160708144719.GI3784@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, PrashanthPrakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>



On 08/07/16 15:47, Lorenzo Pieralisi wrote:
> On Thu, Jul 07, 2016 at 06:10:50PM +0100, Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/kernel/cpuidle.c |  18 +++++++
>>   drivers/firmware/psci.c     | 122 ++++++++++++++++++++++++++++++++++++--------
>
> I would split this patch in two (ARM64 cpuidle and PSCI)

Agreed, I combined it to get it functional in one go, but until we have
6/6, it won't work. So better to split that changes.

> and for
> the PSCI code (apologies, blame taken, it is entirely my fault) I
> think that the code in v6 was better, I asked you to factor out
> DT/ACPI idle states count and parameter retrieval but the end result
> is much more complicated than what it was in v6, so for PSCI ACPI
> idle states parsing I would revert to v6, apologies.
>

Yes I agree it got bit complicated. I will revert back to v6 for that part.


> With changes above:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks

-- 
Regards,
Sudeep
