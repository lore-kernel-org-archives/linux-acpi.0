From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 5/5] ACPI/CPPC: add sysfs support to compute delivered
 performance
Date: Thu, 14 Jul 2016 09:44:48 -0600
Message-ID: <294c6b84-75b6-60b6-63b9-c4eec3d7ad87@codeaurora.org>
References: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
 <1467309758-26536-6-git-send-email-pprakash@codeaurora.org>
 <20160714132535.GA5796@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42782 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcGNPov (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2016 11:44:51 -0400
In-Reply-To: <20160714132535.GA5796@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, hotran@apm.com, cov@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Alexey,
>> +
>> +static ssize_t show_reference_perf(struct kobject *kobj,
>> +		struct attribute *attr, char *buf)
>> +{
>> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
>> +	struct cppc_perf_caps perf_caps;
>> +
>> +	cppc_get_perf_caps(cpc_ptr->cpu_id, &perf_caps);
>> +
>> +	if (perf_caps.reference_perf)
>> +		return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +				perf_caps.reference_perf);
>> +
>> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +			perf_caps.nominal_perf);
>> +}
> What do you think about exporting Counter Wraparound Time register
> as well if it's present?

Yes, that's a good point. I will add it in the next version.

Thanks,
Prashanth

