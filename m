From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4 5/5] ACPI: Replace printk with pr_* in tables.c
Date: Tue, 18 Feb 2014 22:37:46 +0800
Message-ID: <5303703A.8060002@linaro.org>
References: <1392731700-10992-1-git-send-email-hanjun.guo@linaro.org>  <1392731700-10992-6-git-send-email-hanjun.guo@linaro.org> <1392732373.22752.22.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392732373.22752.22.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B402=E6=9C=8818=E6=97=A5 22:06, Joe Perches wrote:
> On Tue, 2014-02-18 at 21:55 +0800, Hanjun Guo wrote:
>> This patch just do some clean up to replace printk with pr_*,
>> no functional change.
> trivial note:
>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> []
>> @@ -55,8 +55,7 @@ void acpi_table_print_madt_entry(struct acpi_subta=
ble_header *header)
>>   		{
>>   			struct acpi_madt_local_apic *p =3D
>>   			    (struct acpi_madt_local_apic *)header;
>> -			printk(KERN_INFO PREFIX
>> -			       "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>> +			pr_info(PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>>   			       p->processor_id, p->id,
>>   			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disa=
bled");
> It'd be nice to realign the additional lines to the open
> parenthesis, here and everywhere else in this patch
>
> 			pr_info(PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> 				p->processor_id, p->id,
> 				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");

Thanks for your comments, will update patch 1/5 and 5/5 follow your=20
suggestion :)

Hanjun
