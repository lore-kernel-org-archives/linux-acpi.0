From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Fri, 21 Jun 2013 00:32:29 +0530
Message-ID: <51C351C5.80906@linux.vnet.ibm.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain> <20130619175728.2852.73156.stgit@localhost.localdomain> <20130620074824.GF32694@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130620074824.GF32694@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org

On 06/20/2013 01:18 PM, Borislav Petkov wrote:
> On Wed, Jun 19, 2013 at 11:27:42PM +0530, Naveen N. Rao wrote:
>> Add a boot option to disable firmware first mode for corrected errors.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   Documentation/x86/x86_64/boot-options.txt |    5 +++++
>>   arch/x86/include/asm/acpi.h               |    2 ++
>>   arch/x86/kernel/acpi/boot.c               |    5 +++++
>>   drivers/acpi/apei/hest.c                  |    3 ++-
>>   4 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
>> index e9e8ddb..1228b22 100644
>> --- a/Documentation/x86/x86_64/boot-options.txt
>> +++ b/Documentation/x86/x86_64/boot-options.txt
>> @@ -176,6 +176,11 @@ ACPI
>>
>>     acpi=noirq	Don't route interrupts
>>
>> +  acpi=nocmcff	Disable firmware first mode for corrected errors. This
>> +		disables parsing the HEST CMC error source to check if
>> +		firmware has set the FF flag. This may result in
>> +		duplicate corrected error reports.
>
> Ok, this option should be called something more vendor-agnostic like
>
> acpi=noff
>
> for example.
>
> CMCI is Intel-specific and Firmware First is a generic way to say that
> firmware would like to look at the errors first.
>
> AMD has similar thing called error thresholding so...
>

nocmcff actually refers to CMC (Corrected Machine Check) Error source 
which is APEI terminology, so this is not actually Intel-specific and 
should apply equally well for AMD. I chose nocmcff over noff since there 
is also a firmware first flag for MCE Error source in APEI and this 
option only disables FF for CMC.

Thanks,
Naveen
