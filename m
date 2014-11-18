From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
Date: Tue, 18 Nov 2014 21:45:49 +0800
Message-ID: <546B4D8D.2020605@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32891 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbaKRNqA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 08:46:00 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so8220404pdi.23
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2014 05:46:00 -0800 (PST)
In-Reply-To: <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, Kangkang.Shen@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger

Hi Catalin,

On 2014=E5=B9=B410=E6=9C=8817=E6=97=A5 21:36, Hanjun Guo wrote:
> It always make sense to initialize CPU0's logical map entry from the
> hardware values, so move the initialization of cpu_logical_map(0)
> before unflatten_device_tree() which is needed by ACPI code later.
>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Could you merge this patch first in 3.19? It was acked by Olof and
Mark, and it will make sense without ACPI too.

Thanks
Hanjun

> ---
>   arch/arm64/kernel/setup.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d..8f33f72 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -393,11 +393,11 @@ void __init setup_arch(char **cmdline_p)
>
>   	efi_idmap_init();
>
> +	cpu_logical_map(0) =3D read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	unflatten_device_tree();
>
>   	psci_init();
>
> -	cpu_logical_map(0) =3D read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	cpu_read_bootcpu_ops();
>   #ifdef CONFIG_SMP
>   	smp_init_cpus();
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
