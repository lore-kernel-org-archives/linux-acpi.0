From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] acpi/apei/einj: Add extensions to EINJ from rev 5.0 of
 acpi spec
Date: Mon, 13 Feb 2012 10:24:32 +0800
Message-ID: <4F387460.8090506@linux.intel.com>
References: <1e89d444cd527f11ff9c24ccca741a25cfab3962.1326831060.git.tony.luck@intel.com> <4F37874F.4010107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20071 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247Ab2BMCYl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Feb 2012 21:24:41 -0500
In-Reply-To: <4F37874F.4010107@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ying.huang@intel.com

=E4=BA=8E 2012/2/12 17:33, Jiang Liu =E5=86=99=E9=81=93:
> Hi Tony and Gong,
> 	Should we remove the target memory address from the resource list of
> ACPI5 trigger too? Otherwise we may also encounter resource conflict =
with ACPI5
> trigger table.
>
> @@ -365,7 +365,7 @@ static int __einj_error_trigger(u64 trigger_paddr=
, u32 type,
>           * This will cause resource conflict with regular memory.  S=
o
>           * remove it from trigger table resources.
>           */
> -       if (param_extension&&  (type&  0x0038)&&  param2) {
> +       if ((param_extension || acpi5)&&  (type&  0x0038)&&  param2) =
{
>                  struct apei_resources addr_resources;
>                  apei_resources_init(&addr_resources);
>                  trigger_param_region =3D einj_get_trigger_parameter_=
region(
> =09
> On 01/18/2012 04:10 AM, Tony Luck wrote:
>> @@ -293,12 +386,56 @@ static int __einj_error_inject(u32 type, u64 p=
aram1, u64 param2)
>>   	if (rc)
>>   		return rc;
>>   	apei_exec_ctx_set_input(&ctx, type);
>> -	rc =3D apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>> -	if (rc)
>> -		return rc;
>> -	if (einj_param) {
>> -		writeq(param1,&einj_param->param1);
>> -		writeq(param2,&einj_param->param2);
>> +	if (acpi5) {
>> +		struct set_error_type_with_address *v5param =3D einj_param;
>> +
>> +		writel(type,&v5param->type);
>> +		if (type&  0x80000000) {
>> +			switch (vendor_flags) {
>> +			case SETWA_FLAGS_APICID:
>> +				writel(param1,&v5param->apicid);
>> +				break;
>> +			case SETWA_FLAGS_MEM:
>> +				writeq(param1,&v5param->memory_address);
>> +				writeq(param2,&v5param->memory_address_range);
>> +				break;
>> +			case SETWA_FLAGS_PCIE_SBDF:
>> +				writel(param1,&v5param->pcie_sbdf);
>> +				break;
>> +			}
>> +			writel(vendor_flags,&v5param->flags);
>> +		} else {
>> +			switch (type) {
>> +			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
>> +			case ACPI_EINJ_PROCESSOR_UNCORRECTABLE:
>> +			case ACPI_EINJ_PROCESSOR_FATAL:
>> +				writel(param1,&v5param->apicid);
>> +				writel(SETWA_FLAGS_APICID,&v5param->flags);
>> +				break;
>> +			case ACPI_EINJ_MEMORY_CORRECTABLE:
>> +			case ACPI_EINJ_MEMORY_UNCORRECTABLE:
>> +			case ACPI_EINJ_MEMORY_FATAL:
>> +				writeq(param1,&v5param->memory_address);
>> +				writeq(param2,&v5param->memory_address_range);
>> +				writel(SETWA_FLAGS_MEM,&v5param->flags);
>> +				break;
>> +			case ACPI_EINJ_PCIX_CORRECTABLE:
>> +			case ACPI_EINJ_PCIX_UNCORRECTABLE:
>> +			case ACPI_EINJ_PCIX_FATAL:
>> +				writel(param1,&v5param->pcie_sbdf);
>> +				writel(SETWA_FLAGS_PCIE_SBDF,&v5param->flags);
>> +				break;
>> +			}
>> +		}
> I'm a little confused about the ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS=
 command in ACPI5.
> The above code seems like a hard-coded version of
> apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS).
> Hi Gong, could you please share the ACPI5 version of EINJ table with =
me? So I could
> get better understanding of the ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS=
 command.
>

You can check ACPI5.0 spec 18.6 for detail. We have internal BIOS to su=
pport
ACPI5 and I'm not sure if there is external product to support ACPI5 fo=
rmally.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
