From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 11/17] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Tue, 20 Jan 2015 20:26:21 +0800
Message-ID: <54BE496D.3050604@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-12-git-send-email-hanjun.guo@linaro.org> <20150120111756.GE25575@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150120111756.GE25575@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, wangyijing@huawei
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B401=E6=9C=8820=E6=97=A5 19:17, Catalin Marinas wrote:
> On Wed, Jan 14, 2015 at 03:04:59PM +0000, Hanjun Guo wrote:
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -64,6 +64,38 @@ static int map_lsapic_id(struct acpi_subtable_hea=
der *entry,
>>   	return 0;
>>   }
>>
>> +/*
>> + * On ARM platform, MPIDR value is the hardware ID as apic ID
>> + * on Intel platforms
>> + */
>> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>> +		int device_declaration, u32 acpi_id, int *mpidr)
>> +{
>> +	struct acpi_madt_generic_interrupt *gicc =3D
>> +	    container_of(entry, struct acpi_madt_generic_interrupt, header=
);
>> +
>> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
>> +		return -ENODEV;
>> +
>> +	/* In the GIC interrupt model, logical processors are
>> +	 * required to have a Processor Device object in the DSDT,
>> +	 * so we should check device_declaration here
>> +	 */
>> +	if (device_declaration && (gicc->uid =3D=3D acpi_id)) {
>> +		/*
>> +		 * Only bits [0:7] Aff0, bits [8:15] Aff1, bits [16:23] Aff2
>> +		 * and bits [32:39] Aff3 are meaningful, so pack the Affx
>> +		 * fields into a single 32 bit identifier to accommodate the
>> +		 * acpi processor drivers.
>> +		 */
>> +		*mpidr =3D ((gicc->arm_mpidr & 0xff00000000) >> 8)
>> +			 | gicc->arm_mpidr;
>
> Nitpick: I would clarify the comment here since "meaningful" doesn't
> necessarily mean that the other bits are 0. And if they are not, the
> above masking is not enough. Looking at the ACPI 5.1 spec, bits other
> than Aff[0-3] must be zero.
>
> Same for the pack_mpidr() comment.

OK, how about:

/*
  * bits other than [0:7] Aff0, [8:15] Aff1, [16:23] Aff2 and
  * [32:39] Aff3 must be 0 which is defined in ACPI 5.1, so pack
  * the Affx fields into a single 32 bit identifier to accommodate
  * the acpi processor drivers.
  */

Thanks
Hanjun
