From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of
 severity
Date: Thu, 9 Nov 2017 09:37:45 -0500
Message-ID: <2ec14466-bc71-3edd-7342-7cea1d754fb5@codeaurora.org>
References: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
 <1510168392-30114-3-git-send-email-tbaicar@codeaurora.org>
 <20171109094654.daymsvizctfrypbo@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbdKIOht (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2017 09:37:49 -0500
In-Reply-To: <20171109094654.daymsvizctfrypbo@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/9/2017 4:46 AM, Borislav Petkov wrote:
> On Wed, Nov 08, 2017 at 12:13:12PM -0700, Tyler Baicar wrote:
>> Currently the GHES code only calls into the AER driver for
>> recoverable type errors. This is incorrect because errors of
>> other severities do not get logged by the AER driver and do not
>> get exposed to user space via the AER trace event. So, call
>> into the AER driver for PCIe errors regardless of the severity
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 839c3d5..bb65fa6 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -458,14 +458,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>>   #endif
>>   }
> Where did the explanatory comment go?
Ah, forgot to but that back in. I'll send an update shortly.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

