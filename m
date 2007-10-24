From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] x86/kernel/acpi/processor.c: fix SMP=n warning
Date: Wed, 24 Oct 2007 18:27:13 +0200
Message-ID: <20071024162713.GQ30533@stusta.de>
References: <tueoct232007613pm.likjasfdlkjdas987@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32784 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760333AbXJXQ0o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 12:26:44 -0400
Content-Disposition: inline
In-Reply-To: <tueoct232007613pm.likjasfdlkjdas987@havoc.gtf.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, lenb@kernel.org, mingo@redhat.com, hpa@zytor.com
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, tglx@linutronix.de, linux-acpi@vger.kernel.org

On Tue, Oct 23, 2007 at 06:36:33PM -0400, Jeff Garzik wrote:
> Fix !CONFIG_SMP warning:
>=20
> arch/x86/kernel/acpi/processor.c: In function =E2=80=98arch_acpi_proc=
essor_init_pdc=E2=80=99:
> arch/x86/kernel/acpi/processor.c:65: warning: unused variable =E2=80=98=
cpu=E2=80=99
>=20
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> ---
> Ideally this warning should be hidden inside a wrapper or somesuch, t=
o
> camouflage the unneeded argument in !SMP case.
>=20
> diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/=
processor.c
> index 2ed0a4c..45e262a 100644
> --- a/arch/x86/kernel/acpi/processor.c
> +++ b/arch/x86/kernel/acpi/processor.c
> @@ -62,7 +62,9 @@ static void init_intel_pdc(struct acpi_processor *p=
r, struct cpuinfo_x86 *c)
>  /* Initialize _PDC data based on the CPU vendor */
>  void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
>  {
> +#ifdef CONFIG_SMP
>  	unsigned int cpu =3D pr->id;
> +#endif
>...

The #ifdef is ugly.

What about the patch below instead?

cu
Adrian


<--  snip  -->



This patch fixes the following warning with CONFIG_SMP=3Dn:

<--  snip  -->

=2E..
arch/x86/kernel/acpi/processor.c: In function `arch_acpi_processor_init=
_pdc':
arch/x86/kernel/acpi/processor.c:65: warning: unused variable `cpu'
=2E..

<--  snip  -->

Based on a patch by Jeff Garzik.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
96d83d412fb6530173110c872f1125ae21938a99=20
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/pr=
ocessor.c
index 2ed0a4c..f63e5ff 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -62,8 +62,7 @@ static void init_intel_pdc(struct acpi_processor *pr,=
 struct cpuinfo_x86 *c)
 /* Initialize _PDC data based on the CPU vendor */
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 {
-	unsigned int cpu =3D pr->id;
-	struct cpuinfo_x86 *c =3D &cpu_data(cpu);
+	struct cpuinfo_x86 *c =3D &cpu_data(pr->id);
=20
 	pr->pdc =3D NULL;
 	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
