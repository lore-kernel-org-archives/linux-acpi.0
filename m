From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
Date: Thu, 16 Feb 2017 10:32:50 +0100
Message-ID: <48bb19c9-d1f3-a5c1-ec82-4b19d45f88fd@suse.de>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <e2780793-a8ac-4d75-b095-a534e36f8bf7@suse.de> <20170216091454.GA2160@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753806AbdBPJdA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Feb 2017 04:33:00 -0500
In-Reply-To: <20170216091454.GA2160@mai>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>, mbrugger@suse.com, yousaf.kaukab@suse.com, sanil.kumar@huawei.com



On 16/02/2017 10:14, Daniel Lezcano wrote:
> On Thu, Feb 16, 2017 at 09:42:11AM +0100, Alexander Graf wrote:
>
> [ ... ]
>
>>>>> I believe Marc is looking at some rework in this area which may enable
>>>>> this, so please wait for that to appear.
>>>> Yeah, I'm implementing a semi-flexible way to add new quirk types, and
>>>> the last thing I want to see is two (or more) tables describing the same
>>>> thing.
>>>
>>> Kindly ping, if you have patches in hand, I can test against our platforms,
>>> thank you very much.
>>
>> Any progress on this? I'm not a big fan of stalling erratum fixes upstream
>> because of potential future refactoring.
>
> The fix is in the tip tree, soon in v4.11-rc1 when the merge will be finished.
>
> http://goo.gl/x90qwE
> http://goo.gl/asCBBD

Oh, I missed that. Sorry for the fuss :).


Alex
