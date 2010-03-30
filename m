From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 12/14] x86 ioapic: Simplify probe_nr_irqs_gsi.
Date: Mon, 29 Mar 2010 21:43:54 -0700
Message-ID: <m17houwh9x.fsf@fess.ebiederm.org>
References: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
	<1269904825-27462-12-git-send-email-ebiederm@xmission.com>
	<86802c441003291916u3381aae7r5cd76c754871421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:44070 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0C3EoG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 00:44:06 -0400
In-Reply-To: <86802c441003291916u3381aae7r5cd76c754871421@mail.gmail.com> (Yinghai Lu's message of "Mon\, 29 Mar 2010 19\:16\:10 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>

Yinghai Lu <yinghai@kernel.org> writes:

> On Mon, Mar 29, 2010 at 4:20 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> From: Eric W. Biederman <ebiederm@xmission.com>
>>
>> Use the global gsi_end value now that all ioapics have
>> valid gsi numbers instead of a combination of acpi_probe_gsi
>> and walking all of the ioapics and couting their number of
>> entries by hand if acpi_probe_gsi gave us an answer we did
>> not like.
>>
>> This fixes a small bug in probe_nr_irqs_gsi. =C2=A0Previously
>> acpi_probe_gsi unnecessarily added 1 to the maximum
>> gsi_end value. =C2=A0gsi_end is already one past the end of
>> the number of gsi's so the additional increment was
>> superfluous.
>>
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>> =C2=A0arch/x86/include/asm/mpspec.h =C2=A0| =C2=A0 =C2=A06 ------
>> =C2=A0arch/x86/kernel/acpi/boot.c =C2=A0 =C2=A0| =C2=A0 23 ---------=
--------------
>> =C2=A0arch/x86/kernel/apic/io_apic.c | =C2=A0 17 +++--------------
>> =C2=A03 files changed, 3 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mp=
spec.h
>> index 29994f0..c82868e 100644
>> --- a/arch/x86/include/asm/mpspec.h
>> +++ b/arch/x86/include/asm/mpspec.h
>> @@ -105,12 +105,6 @@ extern void mp_config_acpi_legacy_irqs(void);
>> =C2=A0struct device;
>> =C2=A0extern int mp_register_gsi(struct device *dev, u32 gsi, int ed=
ge_level,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int active_high_low);
>> -extern int acpi_probe_gsi(void);
>> -#else /* !CONFIG_ACPI: */
>> -static inline int acpi_probe_gsi(void)
>> -{
>> - =C2=A0 =C2=A0 =C2=A0 return 0;
>> -}
>> =C2=A0#endif /* CONFIG_ACPI */
>>
>> =C2=A0#define PHYSID_ARRAY_SIZE =C2=A0 =C2=A0 =C2=A0BITS_TO_LONGS(MA=
X_APICS)
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot=
=2Ec
>> index 9c48e99..0e514a1 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -875,29 +875,6 @@ static int __init acpi_parse_madt_lapic_entries=
(void)
>> =C2=A0extern int es7000_plat;
>> =C2=A0#endif
>>
>> -int __init acpi_probe_gsi(void)
>> -{
>> - =C2=A0 =C2=A0 =C2=A0 int idx;
>> - =C2=A0 =C2=A0 =C2=A0 int gsi;
>> - =C2=A0 =C2=A0 =C2=A0 int max_gsi =3D 0;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 if (acpi_disabled)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 if (!acpi_ioapic)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 max_gsi =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 for (idx =3D 0; idx < nr_ioapics; idx++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gsi =3D mp_gsi_ro=
uting[idx].gsi_end;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gsi > max_gsi=
)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 max_gsi =3D gsi;
>> - =C2=A0 =C2=A0 =C2=A0 }
>> -
>> - =C2=A0 =C2=A0 =C2=A0 return max_gsi + 1;
>> -}
>> -
>> =C2=A0static void assign_to_mp_irq(struct mpc_intsrc *m,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mpc_ints=
rc *mp_irq)
>> =C2=A0{
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/i=
o_apic.c
>> index 996cf8f..b57b7a3 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -3837,22 +3837,11 @@ int __init io_apic_get_redir_entries (int io=
apic)
>>
>> =C2=A0void __init probe_nr_irqs_gsi(void)
>> =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 int nr =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 int nr;
>>
>> - =C2=A0 =C2=A0 =C2=A0 nr =3D acpi_probe_gsi();
>> - =C2=A0 =C2=A0 =C2=A0 if (nr > nr_irqs_gsi) {
>> + =C2=A0 =C2=A0 =C2=A0 nr =3D gsi_end;
>
> you may need +1 here

As documented in my comment that extra +1 has every appearance of a
bug.  Nothing is at gsi_end.  gsi_end is already at 1 past the last in
use gsi.  Therefore an extra +1 puts us two past the end for no
apparent reason.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
