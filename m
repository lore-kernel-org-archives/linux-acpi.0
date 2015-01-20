From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision
 is less than 5.1
Date: Tue, 20 Jan 2015 11:05:28 +0800
Message-ID: <54BDC5F8.5000702@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org> <20150119115017.GH11835@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119115017.GH11835@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, wangyijing@huawei
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B401=E6=9C=8819=E6=97=A5 19:50, Catalin Marinas wrote:
> On Wed, Jan 14, 2015 at 03:04:55PM +0000, Hanjun Guo wrote:
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
> [...]
>> @@ -64,8 +88,13 @@ void __init acpi_boot_table_init(void)
>>   		return;
>>
>>   	/* Initialize the ACPI boot-time table parser. */
>> -	if (acpi_table_init())
>> +	if (acpi_table_init()) {
>>   		disable_acpi();
>> +		return;
>> +	}
>> +
>> +	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
>> +		pr_err("Can't find FADT or error happened during parsing FADT\n")=
;
>>   }
>
> Do you need a disable_acpi() call here as well?

Yes, if we can not find the FADT table, we should disable ACPI, I will
update it in next version, thanks for pointing this out :)

Thanks
Hanjun
