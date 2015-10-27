From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 5/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 27 Oct 2015 14:09:34 +0000
Message-ID: <562F859E.4010105@arm.com>
References: <1438710406-3822-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-6-git-send-email-sudeep.holla@arm.com>
 <CAJ5Y-ebOPE1oamRk31nxL6VkgSdDd6AmEe2Fw1ku5pGt25D2Rg@mail.gmail.com>
 <562EC3A5.2070402@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56646 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbbJ0OJi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2015 10:09:38 -0400
In-Reply-To: <562EC3A5.2070402@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, x86@kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>

Hi Prashanth,

On 27/10/15 00:21, Prakash, Prashanth wrote:
> Hi Sudeep,
>
> While testing with these patches everything looked fine except that we
> are flattening all the LPI
> states even if it is disabled. I added a simple check to fix it. Please
> let me know if you have any
> feedback on the same.
>

Looks good to me and thanks for the nice catch. I completely missed to
handle that case. Is it OK if I fold this patch into the next version ?

I have worked on Ashwin's comments, but was waiting to get some feedback
from Rafael before I post newer version.

-- 
Regards,
Sudeep
