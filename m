From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [v2 PATCH 1/2] ACPI, APEI, EINJ, new parameter to control trigger
 action
Date: Mon, 20 Feb 2012 10:02:17 +0800
Message-ID: <4F41A9A9.5060100@linux.intel.com>
References: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com> <4F41217A.7040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55805 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab2BTCCV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Feb 2012 21:02:21 -0500
In-Reply-To: <4F41217A.7040909@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

=E4=BA=8E 2012/2/20 0:21, Jiang Liu =E5=86=99=E9=81=93:
> On 02/17/2012 03:11 PM, Chen Gong wrote:
>> Some APEI firmware implementation will access injected address
>> specified in param1 to trigger the error when injecting memory
>> error, which means if one SRAR error is injected, the crash
>> always happens because it is executed in kernel context. This
>> new parameter can disable trigger action and control is taken
>> over by the user. In this way, an SRAR error can happen in user
>> context instead of crashing the system. This function is highly
>> depended on BIOS implementation so please ensure you know the
>> BIOS trigger procedure before you enable this switch.
>>
>> v2:
>>    notrigger should be created together with param1/param2
>>
>> Tested-by: Tony Luck<tony.luck@lintel.com>
>> Signed-off-by: Chen Gong<gong.chen@linux.intel.com>
>> ---
>>   drivers/acpi/apei/einj.c |   15 ++++++++++++---
>>   1 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 4ca087d..afc380c 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -74,6 +74,8 @@ struct vendor_error_type_extension {
>>   	u8	reserved[3];
>>   };
>>
>> +static u32 notrigger;
>> +
>>   static u32 vendor_flags;
>>   static struct debugfs_blob_wrapper vendor_blob;
>>   static char vendor_dev[64];
>> @@ -496,9 +498,11 @@ static int __einj_error_inject(u32 type, u64 pa=
ram1, u64 param2)
>>   	if (rc)
>>   		return rc;
>>   	trigger_paddr =3D apei_exec_ctx_get_output(&ctx);
>> -	rc =3D __einj_error_trigger(trigger_paddr, type, param1, param2);
>> -	if (rc)
>> -		return rc;
>> +	if (notrigger =3D=3D 0) {
>> +		rc =3D __einj_error_trigger(trigger_paddr, type, param1, param2);
>> +		if (rc)
>> +			return rc;
>> +	}
>>   	rc =3D apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
> Suggest to reset the notrigger flag to default value (zero) after the=
 injection
> operation, so the test script doesn't need to explicitly set the notr=
igger flag
> for each injection operation and it's backward compatible with existi=
ng scripts.
> It would be better to reset the param2 too for the same reason.
>

I ever thought about this question, but it looks current implementation=
 is
established by usage so I don't think it needs to be fixed, otherwise i=
t has
strong requirement. As for the scripts, I assume you point to mce-test,=
 I will
update them after this patch is merged into the kernel.

Thx for your comments.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
