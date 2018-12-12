From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name
 support
Date: Wed, 12 Dec 2018 01:56:15 +0000
Message-ID: <af65cc4b4b404f15b063429215eb7b68@HXTBJIDCEMVIW02.hxtcorp.net>
References: <254f789dee7773b938db7a204ca8800db10e4588.1542105349.git.dongsheng.wang@hxt-semitech.com>
 <f5908f1f727c41dfa90038d27734f67f@HXTBJIDCEMVIW02.hxtcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "robert.moore@intel.com" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Hello all,

Any comments about this patch?

Cheers
Dongsheng

On 2018/11/23 16:12, Wang, Dongsheng wrote:
> Hello Robert,
>
> Do you have any comments about this patch?
> Thanks.
>
>
> Cheers
> Dongsheng
>
> On 2018/11/13 18:46, Wang, Dongsheng wrote:
>> The new naming rule is added in acpica version 20180427.
>> So the dsdt aml code name changes from "AmlCode" to "dsdt_aml_code".
>>
>> The patch that introduces naming rules is:
>> https://github.com/acpica/acpica/commit/f9a88a4c1cd020b6a5475d63b29626852a0b5f37
>>
>> Tested:
>> ACPICA release version 20180427+.
>> ARM64: QCOM QDF2400
>> GCC: 4.8.5 20150623
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>>  drivers/acpi/Kconfig  |  2 +-
>>  drivers/acpi/tables.c | 10 ++++++++--
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 9705fc986da9..15ab53a52fdc 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -336,7 +336,7 @@ config ACPI_CUSTOM_DSDT_FILE
>>  	  See Documentation/acpi/dsdt-override.txt
>>  
>>  	  Enter the full path name to the file which includes the AmlCode
>> -	  declaration.
>> +	  or dsdt_aml_code declaration.
>>  
>>  	  If unsure, don't enter a file name.
>>  
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index a3d012b08fc5..297020bbaade 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -713,6 +713,9 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>>  					  table_length);
>>  }
>>  
>> +static void *amlcode __attribute__ ((weakref("AmlCode")));
>> +static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
>> +
>>  acpi_status
>>  acpi_os_table_override(struct acpi_table_header *existing_table,
>>  		       struct acpi_table_header **new_table)
>> @@ -723,8 +726,11 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
>>  	*new_table = NULL;
>>  
>>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
>> -	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
>> -		*new_table = (struct acpi_table_header *)AmlCode;
>> +	if (!strncmp(existing_table->signature, "DSDT", 4)) {
>> +		*new_table = (struct acpi_table_header *)&amlcode;
>> +		if (!(*new_table))
>> +			*new_table = (struct acpi_table_header *)&dsdt_amlcode;
>> +	}
>>  #endif
>>  	if (*new_table != NULL)
>>  		acpi_table_taint(existing_table);
>
>
