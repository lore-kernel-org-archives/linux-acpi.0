From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of pr_info()
 for MADT table scanning
Date: Tue, 10 Mar 2015 10:35:58 +0800
Message-ID: <54FE588E.4030406@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>	 <20150306201718.9363CC40AA9@trevor.secretlab.ca> <1425673876.12017.50.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38136 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbCJCgH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2015 22:36:07 -0400
Received: by pdbfl12 with SMTP id fl12so68255061pdb.5
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2015 19:36:06 -0700 (PDT)
In-Reply-To: <1425673876.12017.50.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, Grant Likely <grant.likely@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B403=E6=9C=8807=E6=97=A5 04:31, Joe Perches wrote:
> On Fri, 2015-03-06 at 20:17 +0000, Grant Likely wrote:
>> On Wed, 25 Feb 2015 16:39:41 +0800 Hanjun Guo <hanjun.guo@linaro.org=
> wrote:
>>> This patch just use pr_debug() instead of pr_info() for ioapic/iosa=
pic,
>>> local apic/x2apic/sapic structures when scanning the MADT table to =
remove
>>> those verbose information, but leave other structures unchanged.
> []
>> One nitpick below, but don't respin over this, and don't do a fixup.
> []
>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> []
>>> @@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subt=
able_header *header)
>>>   		{
>>>   			struct acpi_madt_local_apic *p =3D
>>>   			    (struct acpi_madt_local_apic *)header;
>>> -			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>>> -				p->processor_id, p->id,
>>> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled")=
;
>>> +			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>>> +				 p->processor_id, p->id,
>>> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled"=
);
>>
>> The whitespace changes makes each 1 line change into 3 line changes.=
 In
>> these situations, I would chose to leave the whitespace alone to kee=
p
>> the diffstat as small as possible. It makes it less likely to confli=
ct
>> with other patches and easier to find context.
>
> I think it's mostly better to use a consistent indentation style
> regardless of the number in whitespace changes surrounding the change=
=2E

I think both would be fine. Since this patch only touches acpi core
code and ACPI maintainer Rafael already acked it, I will keep it as
it is.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
