From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Tue, 26 Apr 2016 17:01:43 +0100
Message-ID: <571F90E7.3010801@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
 <571F8E7D.4000706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55833 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcDZQBt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2016 12:01:49 -0400
In-Reply-To: <571F8E7D.4000706@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Hi Prashanth,

On 26/04/16 16:51, Prakash, Prashanth wrote:
> Hi Sudeep,
>
> On 4/19/2016 6:30 AM, Sudeep Holla wrote:
>> +struct acpi_processor_lpi *lpi;
>> +int acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
>> +{
>> +	int ret;
>> +
>> +	if (!idx) {
>> +		cpu_do_idle();
>> +		return idx;
>> +	}
>> +
>> +	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
>> +	ret = cpu_pm_enter();
> Can we avoid calling cpu_pm_enter and cpu_pm_exit for retention
> states as it is not necessary? May be we can check LPI architecture
> specific context loss flags prior to calling these.

Ah right, you had mentioned this before. Sorry for missing that.
Anyways, we need to get the driver reviewed before we can finalize arch
specific callbacks, so I will include this change when I post next version.

>> +	}
>> +
>> +	return ret ? -1 : idx;
>> +}
>> +
>
> By the way, thanks for posting these patches!
>

Thanks for taking look at these patches again :)

-- 
Regards,
Sudeep
