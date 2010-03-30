From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 12/14] x86 ioapic: Simplify probe_nr_irqs_gsi.
Date: Mon, 29 Mar 2010 19:16:10 -0700
Message-ID: <86802c441003291916u3381aae7r5cd76c754871421@mail.gmail.com>
References: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
	 <1269904825-27462-12-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39430 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0C3CQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2010 22:16:12 -0400
In-Reply-To: <1269904825-27462-12-git-send-email-ebiederm@xmission.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>

On Mon, Mar 29, 2010 at 4:20 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
>
> Use the global gsi_end value now that all ioapics have
> valid gsi numbers instead of a combination of acpi_probe_gsi
> and walking all of the ioapics and couting their number of
> entries by hand if acpi_probe_gsi gave us an answer we did
> not like.
>
> This fixes a small bug in probe_nr_irqs_gsi. =A0Previously
> acpi_probe_gsi unnecessarily added 1 to the maximum
> gsi_end value. =A0gsi_end is already one past the end of
> the number of gsi's so the additional increment was
> superfluous.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> =A0arch/x86/include/asm/mpspec.h =A0| =A0 =A06 ------
> =A0arch/x86/kernel/acpi/boot.c =A0 =A0| =A0 23 ----------------------=
-
> =A0arch/x86/kernel/apic/io_apic.c | =A0 17 +++--------------
> =A03 files changed, 3 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mps=
pec.h
> index 29994f0..c82868e 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -105,12 +105,6 @@ extern void mp_config_acpi_legacy_irqs(void);
> =A0struct device;
> =A0extern int mp_register_gsi(struct device *dev, u32 gsi, int edge_l=
evel,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int a=
ctive_high_low);
> -extern int acpi_probe_gsi(void);
> -#else /* !CONFIG_ACPI: */
> -static inline int acpi_probe_gsi(void)
> -{
> - =A0 =A0 =A0 return 0;
> -}
> =A0#endif /* CONFIG_ACPI */
>
> =A0#define PHYSID_ARRAY_SIZE =A0 =A0 =A0BITS_TO_LONGS(MAX_APICS)
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.=
c
> index 9c48e99..0e514a1 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -875,29 +875,6 @@ static int __init acpi_parse_madt_lapic_entries(=
void)
> =A0extern int es7000_plat;
> =A0#endif
>
> -int __init acpi_probe_gsi(void)
> -{
> - =A0 =A0 =A0 int idx;
> - =A0 =A0 =A0 int gsi;
> - =A0 =A0 =A0 int max_gsi =3D 0;
> -
> - =A0 =A0 =A0 if (acpi_disabled)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (!acpi_ioapic)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 max_gsi =3D 0;
> - =A0 =A0 =A0 for (idx =3D 0; idx < nr_ioapics; idx++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gsi =3D mp_gsi_routing[idx].gsi_end;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gsi > max_gsi)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_gsi =3D gsi;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return max_gsi + 1;
> -}
> -
> =A0static void assign_to_mp_irq(struct mpc_intsrc *m,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mpc_intsrc *mp_irq)
> =A0{
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io=
_apic.c
> index 996cf8f..b57b7a3 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -3837,22 +3837,11 @@ int __init io_apic_get_redir_entries (int ioa=
pic)
>
> =A0void __init probe_nr_irqs_gsi(void)
> =A0{
> - =A0 =A0 =A0 int nr =3D 0;
> + =A0 =A0 =A0 int nr;
>
> - =A0 =A0 =A0 nr =3D acpi_probe_gsi();
> - =A0 =A0 =A0 if (nr > nr_irqs_gsi) {
> + =A0 =A0 =A0 nr =3D gsi_end;

you may need +1 here

YH

> + =A0 =A0 =A0 if (nr > nr_irqs_gsi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nr_irqs_gsi =3D nr;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* for acpi=3Doff or acpi is not compil=
ed in */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int idx;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (idx =3D 0; idx < nr_ioapics; idx++=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr +=3D io_apic_get_red=
ir_entries(idx) + 1;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr > nr_irqs_gsi)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_irqs_gsi =3D nr;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0printk(KERN_DEBUG "nr_irqs_gsi: %d\n", nr_irqs_gsi);
> =A0}
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
