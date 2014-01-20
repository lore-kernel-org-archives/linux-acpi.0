From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing
 MADT table
Date: Mon, 20 Jan 2014 16:49:00 +0800
Message-ID: <52DCE2FC.30003@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org> <201401171512.42850.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:61464 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaATItP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jan 2014 03:49:15 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so6728277pbb.37
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jan 2014 00:49:15 -0800 (PST)
In-Reply-To: <201401171512.42850.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com

On 2014-1-17 22:12, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>>  
>> +/*
>> + * Local interrupt controller address,
>> + * GIC cpu interface base address on ARM/ARM64
>> + */
>> +static u64 acpi_lapic_addr __initdata;
> 
> If it's cpu local, don't you need more than one address to support SMP?

Good point, thanks for pointing this out. I have a question, do we really
have some SoCs without banked registers?

I ask this question because we can do something for GIC cpu interface
with per cpu offset, but ACPI do NOT support per cpu offset for GIC
distributor.

> Also, the variable appears to be write-only.

Actually not, it will be used for GIC initialization.

> 
>> +#define BAD_MADT_ENTRY(entry, end) (					\
>> +	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||	\
>> +	((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
>> +
> 
> Better make this an inline function.
> 
>> +static int __init
>> +acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
>> +{
>> +	struct acpi_madt_generic_interrupt *processor = NULL;
>> +
>> +	processor = (struct acpi_madt_generic_interrupt *)header;
> 
> You don't need the initialization in the first line when you write to the
> variable before reading it. Same in the other functions.

Ok, I will update them all in next version.

Thanks
hanjun
