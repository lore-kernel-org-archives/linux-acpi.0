From: Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC 1/2] ACPI, APEI, Add apei_exec_run_optional
Date: Wed, 06 Jul 2011 08:26:49 +0800
Message-ID: <4E13ABC9.1090209@intel.com>
References: <1309846023-16459-1-git-send-email-ying.huang@intel.com> <4E13174B.30403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28878 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab1GFA0w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2011 20:26:52 -0400
In-Reply-To: <4E13174B.30403@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gong Chen <clumsycg@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@novell.com>

Hi, Gong,

Thanks for review.

On 07/05/2011 09:53 PM, Gong Chen wrote:
> =E4=BA=8E 2011/7/5 14:07, Huang Ying =E5=86=99=E9=81=93:
>> Some actions in APEI ERST and EINJ tables are optional, for example,
>> ACPI_EINJ_BEGIN_OPERATION action is used to do some preparation for
>> error injection, and firmware may choose to do nothing here.  While
>> some other actions are mandatory, for example, firmware must provide
>> ACPI_EINJ_GET_ERROR_TYPE implementation.
>>
>> Original implementation treats all actions as optional (that is, can
>> have no instructions), that may cause issue if firmware does not
>> provide some mandatory actions.  To fix this, this patch adds
>> apei_exec_run_optional, which should be used for optional actions.
>> The original apei_exec_run should be used for mandatory actions.
>>
>> Cc: Thomas Renninger<trenn@novell.com>
>> Signed-off-by: Huang Ying<ying.huang@intel.com>
>> ---
>>   drivers/acpi/apei/apei-base.c     |    9 +++++----
>>   drivers/acpi/apei/apei-internal.h |   13 ++++++++++++-
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> --- a/drivers/acpi/apei/apei-base.c
>> +++ b/drivers/acpi/apei/apei-base.c
>> @@ -157,9 +157,10 @@ EXPORT_SYMBOL_GPL(apei_exec_noop);
>>    * Interpret the specified action. Go through whole action table,
>>    * execute all instructions belong to the action.
>>    */
>> -int apei_exec_run(struct apei_exec_context *ctx, u8 action)
>> +int __apei_exec_run(struct apei_exec_context *ctx, u8 action,
>> +		    bool optional)
>>   {
>> -	int rc;
>> +	int rc =3D -ENOENT;
>>   	u32 i, ip;
>>   	struct acpi_whea_header *entry;
>>   	apei_exec_ins_func_t run;
>> @@ -198,9 +199,9 @@ rewind:
>>   			goto rewind;
>>   	}
>>
>> -	return 0;
>> +	return !optional&&  rc<  0 ? rc : 0;
>=20
> if one operation is optional but running into errors when executing t=
his=20
> kind of command,
> here just ignoring it. Is it reasonable ?

If we running into errors except there is no instructions for the
action, we will return the error code before this.  Please take a look
at the whole function.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
