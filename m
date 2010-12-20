From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] eliminate the usage of printk_ratelimit
Date: Mon, 20 Dec 2010 09:38:02 +0800
Message-ID: <4D0EB37A.4090608@linux.intel.com>
References: <1292408294-30584-1-git-send-email-gong.chen@linux.intel.com> <1292408294-30584-2-git-send-email-gong.chen@linux.intel.com> <alpine.LFD.2.00.1012170123140.20940@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54211 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab0LTBiQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Dec 2010 20:38:16 -0500
In-Reply-To: <alpine.LFD.2.00.1012170123140.20940@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

=E4=BA=8E 12/17/2010 2:27 PM, Len Brown =E5=86=99=E9=81=93:
> On Wed, 15 Dec 2010, Chen Gong wrote:
>
>> To avoid messages to be suppressed, use __ratelimit to
>> substitute printk_ratelimit.
>>
>> Signed-off-by: Chen Gong<gong.chen@linux.intel.com>
>> ---
>>   drivers/acpi/apei/ghes.c |    4 +++-
>>   1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 51905d0..29d38ad 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -180,13 +180,15 @@ static int ghes_copy_tofrom_phys(void *buffer,=
 u64 paddr, u32 len,
>>   static int ghes_read_estatus(struct ghes *ghes, int silent)
>>   {
>>   	struct acpi_hest_generic *g =3D ghes->generic;
>> +	/* Not more than 2 messages every 5 seconds */
>> +	static DEFINE_RATELIMIT_STATE(ratelimit, 5*HZ, 2);
>>   	u64 buf_paddr;
>>   	u32 len;
>>   	int rc;
>>
>>   	rc =3D acpi_atomic_read(&buf_paddr,&g->error_status_address);
>>   	if (rc) {
>> -		if (!silent&&  printk_ratelimit())
>> +		if (!silent&&  __ratelimit(&ratelimit))
>
> So you want to change 10 messages/5s into 2 messages/5s?
>
> That isn't a very big change.

No, it is because printk_ratelimit shares ratelimiting state
with all other *unrelated* printk_ratelimit() callsites.

>
> Is using ratelimit better than using printk_once()?
>
> -Len
>
>>   			pr_warning(FW_WARN GHES_PFX
>>   "Failed to read error status block address for hardware error sour=
ce: %d.\n",
>>   				   g->header.source_id);
>> --
>> 1.7.3.1.120.g38a18
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
