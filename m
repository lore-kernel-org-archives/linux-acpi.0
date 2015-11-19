From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2 5/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Thu, 19 Nov 2015 15:03:33 -0700
Message-ID: <564E4735.5080609@codeaurora.org>
References: <1438710406-3822-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-6-git-send-email-sudeep.holla@arm.com>
 <CAJ5Y-ebOPE1oamRk31nxL6VkgSdDd6AmEe2Fw1ku5pGt25D2Rg@mail.gmail.com>
 <562EC3A5.2070402@codeaurora.org> <562F859E.4010105@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36735 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227AbbKSWDg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 17:03:36 -0500
In-Reply-To: <562F859E.4010105@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, x86@kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>

Hi Sudeep,

On 10/27/2015 8:09 AM, Sudeep Holla wrote:
> Hi Prashanth,
>
> On 27/10/15 00:21, Prakash, Prashanth wrote:
>> Hi Sudeep,
>>
>> While testing with these patches everything looked fine except that we
>> are flattening all the LPI
>> states even if it is disabled. I added a simple check to fix it. Please
>> let me know if you have any
>> feedback on the same.
>>
>
> Looks good to me and thanks for the nice catch. I completely missed to
> handle that case. Is it OK if I fold this patch into the next version ?
>
> I have worked on Ashwin's comments, but was waiting to get some feedback
> from Rafael before I post newer version.
>
Did you had an opportunity to update the LPI patch set? Please let me know
if you need any help in test/verification of the new patch set.

--
Thanks,
Prashanth
