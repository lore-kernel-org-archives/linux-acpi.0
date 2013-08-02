From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v2 05/18] x86, acpi: Split acpi_boot_table_init() into
 two parts.
Date: Fri, 02 Aug 2013 15:01:28 +0800
Message-ID: <51FB5948.6080802@cn.fujitsu.com>
References: <1375340800-19332-1-git-send-email-tangchen@cn.fujitsu.com>  <1375340800-19332-6-git-send-email-tangchen@cn.fujitsu.com> <1375399931.10300.36.camel@misato.fc.hp.com> <1AE640813FDE7649BE1B193DEA596E8802437AC8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802437AC8@SHSMSX101.ccr.corp.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Toshi Kani <toshi.kani@hp.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tj@kernel.org" <tj@kernel.org>, "trenn@suse.de" <trenn@suse.de>, "yinghai@kernel.org" <yinghai@kernel.org>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "mgorman@suse.de" <mgorman@suse.de>, "minchan@kernel.org" <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, gong.chen@linux.
List-Id: linux-acpi@vger.kernel.org

On 08/02/2013 01:25 PM, Zheng, Lv wrote:
......
>>> index ce3d5db..9d68ffc 100644
>>> --- a/drivers/acpi/acpica/tbutils.c
>>> +++ b/drivers/acpi/acpica/tbutils.c
>>> @@ -766,9 +766,30 @@
>> acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
>>>   	*/
>>>   	acpi_os_unmap_memory(table, length);
>>>
>>> +	return_ACPI_STATUS(AE_OK);
>>> +}
>>> +
>>>
>
> I don't think you can split the function here.
> ACPICA still need to continue to parse the table using the logic implemented in the acpi_tb_install_table() and acpi_tb_parse_fadt(). (for example, endianess of the signature).
> You'd better to keep them as is and split some codes from 'acpi_tb_install_table' to form another function: acpi_tb_override_table().

I'm sorry, I don't quite follow this.

I split acpi_tb_parse_root_table(), not acpi_tb_install_table() and 
acpi_tb_parse_fadt().
If ACPICA wants to use these two functions somewhere else, I think it is 
OK, isn't it?

And the reason I did this, please see below.

......
>>> + *
>>> + * FUNCTION:    acpi_tb_install_root_table
>
> I think this function should be acpi_tb_override_tables, and call acpi_tb_override_table() inside this function for each table.

It is not just about acpi initrd table override.

acpi_tb_parse_root_table() was split into two steps:
1. initialize acpi_gbl_root_table_list
2. install tables into acpi_gbl_root_table_list

I need step1 earlier because I want to find SRAT at early time.
But I don't want step2 earlier because before install the tables in 
firmware,
acpi initrd table override could happen. I want only SRAT, I don't want to
touch much existing code.

Would you please explain more about your comment ? I think maybe I 
missed something
important to you guys. :)

And all the other ACPICA rules will be followed in the next version.

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
