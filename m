From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [RFC PATCH 2/2] x86: Prefer TSC Deadline Timer over LAPIC timer
Date: Wed, 28 Jul 2010 13:30:47 -0700
Message-ID: <AANLkTimYrRXy8wiaKdUEc1cTCG+B2d8zv5bVs=wrPpXp@mail.gmail.com>
References: <alpine.LFD.2.00.1007280033370.28038@localhost.localdomain>
	<alpine.LFD.2.00.1007280035480.28038@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:62063 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0G1Ua4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jul 2010 16:30:56 -0400
In-Reply-To: <alpine.LFD.2.00.1007280035480.28038@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tue, Jul 27, 2010 at 9:37 PM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> The LOCAL APIC on new processors has a mode where
> its underlying hardware timer can now be accessed
> via the non-serializing IA32_TSC_DEADLINE_MSR in TSC tick units.
>
> If this mode is present, prefer it over the
> traditional LAPIC timer mode. =A0KERN_DEBUG dmesg
> will print "TSC deadline timer enabled" when TDT is used.
>
> Bootparam "tdt_off" is available to revert to LAPIC timer mode.
>
> This patch is based on original work by Venkatesh Pallipadi.
>
> cc: Venkatesh Pallipadi <venki@google.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> =A0Documentation/kernel-parameters.txt | =A0 =A03 ++
> =A0arch/x86/kernel/apic/apic.c =A0 =A0 =A0 =A0 | =A0 44 +++++++++++++=
+++++++++++++++++++++-
> =A02 files changed, 46 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 2b2407d..73ec308 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2596,6 +2596,9 @@ and is between 256 and 4096 characters. It is d=
efined in the file
>
> =A0 =A0 =A0 =A0tdfx=3D =A0 =A0 =A0 =A0 =A0 [HW,DRM]
>
> + =A0 =A0 =A0 tdt_off =A0 =A0 =A0 =A0 [APIC,X86]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Disable TSC Deadline Ti=
mer, default back to LAPIC timer.
> +

How about renaming this to noapictdt or nolapictdt? Not that they are
good, but that would make it similar to other apic params.

> =A0 =A0 =A0 =A0test_suspend=3D =A0 [SUSPEND]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Specify "mem" (for Sus=
pend-to-RAM) or "standby" (for
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0standby suspend) as th=
e system sleep state to briefly
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.=
c
> index a96489e..64069ae 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -53,6 +53,15 @@
> =A0#include <asm/kvm_para.h>
> =A0#include <asm/tsc.h>
>
> +#define APIC_TIMER_MODE_ONESHOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 <<=
 17)
> +#define APIC_TIMER_MODE_PERIODIC =A0 =A0 =A0 (1 << 17)
> +#define APIC_TIMER_MODE_TSC_DEADLINE =A0 (2 << 17)
> +#define APIC_TIMER_MODE_MASK =A0 =A0 =A0 =A0 =A0 (3 << 17)
> +
> +static unsigned long tsc_per_apic_clock;
> +static int tdt_enabled;
> +static int tdt_disable;
> +
> =A0unsigned int num_processors;
>
> =A0unsigned disabled_cpus __cpuinitdata;
> @@ -355,6 +364,14 @@ static void __setup_APIC_LVTT(unsigned int clock=
s, int oneshot, int irqen)
> =A0 =A0 =A0 =A0if (!irqen)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lvtt_value |=3D APIC_LVT_MASKED;
>
> + =A0 =A0 =A0 if (oneshot && !tdt_disable &&
> + =A0 =A0 =A0 =A0 =A0 boot_cpu_has(X86_FEATURE_TSC_DEADLINE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk_once(KERN_DEBUG "TSC deadline ti=
mer enabled\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tdt_enabled =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvtt_value &=3D (~APIC_TIMER_MODE_MASK)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvtt_value |=3D APIC_TIMER_MODE_TSC_DEA=
DLINE;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0apic_write(APIC_LVTT, lvtt_value);
>
> =A0 =A0 =A0 =A0/*
> @@ -409,7 +426,20 @@ EXPORT_SYMBOL_GPL(setup_APIC_eilvt_ibs);
> =A0static int lapic_next_event(unsigned long delta,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct clock_e=
vent_device *evt)
> =A0{
> - =A0 =A0 =A0 apic_write(APIC_TMICT, delta);
> + =A0 =A0 =A0 if (tdt_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 tsc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 delta_tsc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 delta_tsc =3D delta * tsc_per_apic_cloc=
k;

About this conversion. I think it is cleaner and probably better in
terms of performance to deal with TSC natively in lapic_clockevent.
That would mean having the mult and min/max delta in terms of TSC.
That would also mean we can avoid APIC tick frequency calibration.
Also, having a different ->next_event for TSC deadline timer would be
better than checking this flag on every call.

Thanks,
Venki
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
