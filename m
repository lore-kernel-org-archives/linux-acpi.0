From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Tue, 29 Aug 2017 15:27:42 -0600
Message-ID: <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 8/29/2017 2:20 AM, Borislav Petkov wrote:
> On Mon, Aug 28, 2017 at 11:11:54AM -0600, Tyler Baicar wrote:
>> Currently the GHES code only calls into the AER driver for
>> recoverable type errors. This is incorrect because errors of
>> other severities do not get logged by the AER driver and do not
>> get exposed to user space via the AER trace event. So, call
>> into the AER driver for PCIe errors regardless of the severity.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/acpi/apei/ghes.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d661d45..5cab238 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -489,9 +489,7 @@ static void ghes_do_proc(struct ghes *ghes,
>>   		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>>   			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>>   
>> -			if (sev == GHES_SEV_RECOVERABLE &&
>> -			    sec_sev == GHES_SEV_RECOVERABLE &&
> Did you make the effort to see which commit added those lines and read
> its commit message?
>
> Doesn't look like it...
Hello Boris,

Here is that commit text:

"ACPI, APEI, GHES: Add PCIe AER recovery support

     aer_recover_queue() is called when recoverable PCIe AER errors are
     notified by firmware to do the recovery work."

The function with the real bulk of the code we need here is 
aer_recover_work_func() which calls into cper_print_aer() and 
do_recovery(). The do_recovery() function is the only function that 
should be specific to recoverable errors. We need cper_print_aer() to 
handle printing of AER specific information and to trigger the aer_event 
to notify user space. Otherwise tools such as RAS Daemon will not be 
notified of correctable type PCIe errors. You can clearly see by looking 
at cper_print_aer() that it expects to be called with correctable errors 
as well. To avoid calling the do_recovery() function for correctable 
errors I created https://patchwork.kernel.org/patch/9925877/

The AER core framework for non-FF systems prints all the AER error 
information for all errors and then only calls do_recovery() for 
non-correctable errors. See aer_process_err_devices() and 
handle_error_source().

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
