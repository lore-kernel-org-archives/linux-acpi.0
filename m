From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 4/7] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
Date: Wed, 04 Dec 2013 22:30:06 +0800
Message-ID: <529F3C6E.5080802@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-5-git-send-email-hanjun.guo@linaro.org> <CAL_JsqKmKsZtYgFrLBU+vOnHkC6x5nB9WfhM7hC=DipzEj8qhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKmKsZtYgFrLBU+vOnHkC6x5nB9WfhM7hC=DipzEj8qhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Linaro Patches <patches@linaro.org>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 01:12, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 10:36 AM, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
[...]
> +#ifndef _ASM_ARM_ACPI_H
> +#define _ASM_ARM_ACPI_H
> +
> +static inline bool arch_has_acpi_pdc(void)
> +{
> +       return false;   /* always false for now */
> +}
> +
> +static inline void arch_acpi_set_pdc_bits(u32 *buf)
> +{
> +       return;
> +}
> +
> +#endif /*_ASM_ARM_ACPI_H*/
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/=
asm/processor.h
> index 45b20cd..73b1d3a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -162,6 +162,17 @@ static inline void spin_lock_prefetch(const void=
 *x)
>
>   #define HAVE_ARCH_PICK_MMAP_LAYOUT
>
> +#ifdef CONFIG_ACPI
> The ifdef is not necessary.

Good catch, will fix it in next version.

Thanks for the comments.

Hanjun
