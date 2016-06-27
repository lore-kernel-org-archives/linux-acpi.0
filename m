From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Mon, 27 Jun 2016 16:11:54 +0100
Message-ID: <5771423A.1030708@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org> <57714043.5020207@arm.com>
 <577140A7.60904@linaro.org> <57714106.2040200@arm.com>
 <5771416E.1040000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40827 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0PL6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 11:11:58 -0400
In-Reply-To: <5771416E.1040000@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 27/06/16 16:08, Daniel Lezcano wrote:
> On 06/27/2016 05:06 PM, Sudeep Holla wrote:

[...]

>> Ah ok, anyways LPI always starts from index 0. IIUC that was your main
>> concern.
>
> Do you have a repo where I can see the code ?
>

Yes, you can get it from [1]

--
Regards,
Sudeep

[1] http://git.kernel.org/sudeep.holla/linux/h/for_review/arm64_lpi
