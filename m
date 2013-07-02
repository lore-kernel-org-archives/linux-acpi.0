From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] mce, acpi/apei: Soft-offline a page on firmware
 GHES notification
Date: Tue, 02 Jul 2013 16:35:43 +0530
Message-ID: <51D2B407.40601@linux.vnet.ibm.com>
References: <20130701153728.6197.14022.stgit@localhost.localdomain> <20130701153859.6197.59186.stgit@localhost.localdomain> <20130701230800.GO23515@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130701230800.GO23515@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org

On 07/02/2013 04:38 AM, Borislav Petkov wrote:
> On Mon, Jul 01, 2013 at 09:08:59PM +0530, Naveen N. Rao wrote:
>> If the firmware indicates in GHES error data entry that the error threshold
>> has exceeded for a corrected error event, then we try to soft-offline the
>> page. This could be called in interrupt context, so we queue this up similar
>> to how we handle memory failure scenarios.
>>
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   drivers/acpi/apei/ghes.c |   12 ++++++++++
>>   include/linux/mm.h       |    1 +
>>   mm/memory-failure.c      |   53 ++++++++++++++++++++++++++++++----------------
>>   3 files changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index fcd7d91..5a630ed 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -429,6 +429,18 @@ static void ghes_do_proc(struct ghes *ghes,
>>   						  mem_err);
>>   #endif
>>   #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>> +			if (sec_sev == GHES_SEV_CORRECTED &&
>> +			    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
>> +			    (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)) {
>> +				unsigned long pfn;
>> +				pfn = mem_err->physical_addr >> PAGE_SHIFT;
>> +				if (pfn_valid(pfn))
>> +					soft_memory_failure_queue(pfn, 0, 0);
>> +				else
>> +					pr_warning(FW_WARN GHES_PFX
>> +					"Invalid address in generic error data: %#lx\n",
>> +					mem_err->physical_addr);
>> +			}
>
> Yuck, this looks like BIOS code.
>
> Can we carve out this into a function and do
>
> void function(.. )
> {
> #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>
> 	<code at 1st indentation, much more readable>
>
> #endif
> }
>
> so that we can nicely call it from ghes_do_proc()?

Sure.

>
>>   			if (sev == GHES_SEV_RECOVERABLE &&
>>   			    sec_sev == GHES_SEV_RECOVERABLE &&
>>   			    mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS) {
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e0c8528..f9907d2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1787,6 +1787,7 @@ enum mf_flags {
>>   };
>>   extern int memory_failure(unsigned long pfn, int trapno, int flags);
>>   extern void memory_failure_queue(unsigned long pfn, int trapno, int flags);
>> +extern void soft_memory_failure_queue(unsigned long pfn, int trapno, int flags);
>>   extern int unpoison_memory(unsigned long pfn);
>>   extern int sysctl_memory_failure_early_kill;
>>   extern int sysctl_memory_failure_recovery;
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ceb0c7f..50caefd 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1222,6 +1222,7 @@ struct memory_failure_entry {
>>   	unsigned long pfn;
>>   	int trapno;
>>   	int flags;
>> +	bool soft_offline;
>
> Why a new bool? This flags int looks nice above. :)

D'uh! I considered that, but I can't recall why I chose not to use that! 
Let me redo this patch.

Thanks,
Naveen
