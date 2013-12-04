From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC related
 stuff to make it more arch-independent
Date: Wed, 04 Dec 2013 22:11:54 +0800
Message-ID: <529F382A.9020800@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org> <20131203164623.GB13447@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131203164623.GB13447@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:46, Matthew Garrett wrote:
> On Wed, Dec 04, 2013 at 12:36:47AM +0800, Hanjun Guo wrote:
>
>> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>>   	/* Enable coordination with firmware's _TSD info */
>>   	buf[2] =3D ACPI_PDC_SMP_T_SWCOORD;
>> +	if (boot_option_idle_override =3D=3D IDLE_NOMWAIT) {
>> +		/*
>> +		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
>> +		 * mode will be disabled in the parameter of _PDC object.
>> +		 * Of course C1_FFH access mode will also be disabled.
>> +		 */
>> +		buf[2] &=3D ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>> +
>> +	}
>> +#endif
> This is (fairly) arch-specific, so why not move it to
> arch_acpi_set_pdc_bits()?

Ok, it will make the code much cleaner, will update in next version.

Thanks
Hanjun


>
