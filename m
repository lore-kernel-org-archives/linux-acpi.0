From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH V3 0/7] CPPC enhancements
Date: Wed, 14 Sep 2016 09:33:40 -0600
Message-ID: <3eac6853-8718-7566-64e0-9cc7181c424f@codeaurora.org>
References: <1471379984-15712-1-git-send-email-pprakash@codeaurora.org>
 <2522176.850UacRmuH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762170AbcINPdo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 11:33:44 -0400
In-Reply-To: <2522176.850UacRmuH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org



On 9/12/2016 4:07 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 16, 2016 02:39:37 PM Prashanth Prakash wrote:
>> Hi,
>>
>> This series has patches related to cppc that either improves the performance
>> or adds some features.
>>
>> v3:
>>   * Fixed the error path in send_pcc_cmd in CPPC batching patch
>>   * Included a patch to consolidate all the global variables
>>   * Included a patch to check for PCC error bit (Alexey)
>> v2:
>>   * Sysfs entry for counter wraparound time(Alexey)
>>   * Updated latency calculation to sum of Nominal and MRTT(Alexey)
>>   * Moved refernce_perf from perf_caps to fb_ctrs
>>   * Addressed review comments from Hoan and few minor cleanups
>> v1:
>>   * Pulled in the CPPC batching path to this series
>>   * Addressed POSTCHANGE issue(Alexey) and switch to RW semaphore(Hoan)
>>
>> Thanks,
>> Prashanth
>> Ashwin Chaugule (2):
>>   ACPI/CPPC: restructure read/writes for efficient sys mapped reg ops
>>   ACPI/CPPC: add sysfs support to compute delivered performance
>>
>> Prashanth Prakash (5):
>>   ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
>>   ACPI/CPPC: support for batching CPPC requests
>>   ACPI/CPPC: set a non-zero value for transition_latency
>>   ACPI/CPPC: move all PCC related information into pcc_data
>>   ACPI/CPPC: check for error bit in PCC status field
>>
>>  drivers/acpi/cppc_acpi.c       | 600 +++++++++++++++++++++++++++++++----------
>>  drivers/cpufreq/cppc_cpufreq.c |   1 +
>>  include/acpi/cppc_acpi.h       |  14 +-
>>  3 files changed, 466 insertions(+), 149 deletions(-)
> All applied.

Thanks Rafael!

-Prashanth
>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

