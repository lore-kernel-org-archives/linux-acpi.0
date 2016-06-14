From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 14 Jun 2016 15:24:45 +0100
Message-ID: <576013AD.4040400@arm.com>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
 <1462981062-24909-3-git-send-email-sudeep.holla@arm.com>
 <575AFAF9.3020606@arm.com> <6013371.oAQ1sZvyYq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59049 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbcFNOYu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jun 2016 10:24:50 -0400
In-Reply-To: <6013371.oAQ1sZvyYq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>



On 13/06/16 22:05, Rafael J. Wysocki wrote:
> On Friday, June 10, 2016 06:38:01 PM Sudeep Holla wrote:
>> Hi Rafael,
>
> Hi,
>
>> On 11/05/16 16:37, Sudeep Holla wrote:
>>> ACPI 6.0 introduced an optional object _LPI that provides an alternate
>>> method to describe Low Power Idle states. It defines the local power
>>> states for each node in a hierarchical processor topology. The OSPM can
>>> use _LPI object to select a local power state for each level of processor
>>> hierarchy in the system. They used to produce a composite power state
>>> request that is presented to the platform by the OSPM.
>>>
>>> Since multiple processors affect the idle state for any non-leaf hierarchy
>>> node, coordination of idle state requests between the processors is
>>> required. ACPI supports two different coordination schemes: Platform
>>> coordinated and  OS initiated.
>>>
>>> This patch adds initial support for Platform coordination scheme of LPI.
>>>
>>
>> I have added support for autopromote states(basically skip flattening or
>> creating composite state). I have also fixed the bug discussed in this
>> thread with Prashant. Do you have any other feedback on this version
>> that I incorporate before posting next version.
>
> I'd really preferred it if you posted the next version without waiting for
> my feedback to the previous one (as the feedback may not be relevant any
> more among other things).
>

Sure, will do that soon.

-- 
Regards,
Sudeep
