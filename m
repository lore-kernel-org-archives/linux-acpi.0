From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ACPI / Processor: add sysfs support for low power idle
Date: Tue, 1 Aug 2017 10:18:45 +0100
Message-ID: <ad046d13-1c51-981d-d4d7-997f0cbf4b6b@arm.com>
References: <1499968082-7753-1-git-send-email-pprakash@codeaurora.org>
 <3212e387-9f7d-5bd9-4612-79dddc77b05f@arm.com>
 <8beff6e7-e27c-0b44-6236-a95fcd5335d5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdHAJSs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Aug 2017 05:18:48 -0400
In-Reply-To: <8beff6e7-e27c-0b44-6236-a95fcd5335d5@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lenb@kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 31/07/17 19:18, Prakash, Prashanth wrote:
> Hi Sudeep,
> 
> On 7/31/2017 10:25 AM, Sudeep Holla wrote:
>> Sorry for the delay, I initial thought having this ABI under testing is
>> fine as I really don't want any *real* user space programs to depend on
>> this for various reasons stated in earlier threads, e.g. h/w auto
>> promotable states, accuracy of the stats, ..etc
> <sorry for repeating this part>
> These fields are optional, so if there is no reliable way to keep track of  stats, platform
> can choose not to expose it. If a platform is exposing inaccurate stats via this ACPI
> interface, it is breaking the spec.

Fair enough.

>> But from Documentation/ABI/README, I see
>>
>> testing/
>> 	This directory documents interfaces that are felt to be stable,
>> 	as the main development of this interface has been completed.
>> 	The interface can be changed to add new features, but the
>> 	current interface will not break by doing this, unless grave
>> 	errors or security problems are found in them. User space
>> 	programs can start to rely on these interfaces,...
>>
>> which makes me worry. Since the use for this is purely for debug or
>> optimization purposes, I still prefer simple single file debugfs entry.
>> I still can't digest the fact that reading single file is time consuming
>> as we are not using this interface at runtime IIUC. i.e. statistic are
>> collected and analyzed offline.>> These fields has the same utility/use-cases as the usage & time
fields in cpuidle sysfs,
> but provides more granularity - idle stats for different levels hierarchy and accurate
> idle stats for states that require platform co-ordination.
>

I completely agree with that and that's not the argument.

> The argument for having a single sysfs file per node was that reading individual
> files might get expensive to get a snapshot(not the other way around). But, that
> argument was weak as we typically read these only in debug settings and not that
> often during runtime. So, the summary_stats file was removed and went with one
> value per file.
> 

You are contradicting yourself above :). You say the argument you made
is weak :) but still went ahead and dropped single debugfs file vs the
standard per entry sysfs file which is an ABI.

Since we already have CPUIdle sysfs which is an ABI, I am really not
sure if we need another set of ABI files which are used only for debug
and optimization purposes. Why is single debugfs file not sufficient ?

As hardware evolves, most of the platforms can't provide these
information accurately. So if we are trying to address a problem which
is short-lived and on very small class of platforms, I would avoid
creating a new ABI for it. That's my main argument against this
interface instead go with debugfs entry. That's my opinion though.

-- 
Regards,
Sudeep
