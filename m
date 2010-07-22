From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH] ACPI: make acpi_idle Nehalem-aware
Date: Wed, 21 Jul 2010 17:53:25 -0700
Message-ID: <AANLkTik0RhHqT611oYbnyLfPQwgv0ExBLHK0mVruqbh3@mail.gmail.com>
References: <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
	<20100426194002.586fbaa5@fido5>
	<20100427124703.GA16706@jgarrett.org>
	<alpine.LFD.2.00.1004301218280.2489@sony>
	<20100430174447.GA14889@srcf.ucam.org>
	<d7f2dd35a4361e5156079278543769a0@localhost>
	<alpine.LFD.2.00.1005250125590.20648@localhost.localdomain>
	<CE761E84DADF2947A4AF22FB8D97A4731E0366B5@shsmsx501.ccr.corp.intel.com>
	<20100525124325.GC7876@srcf.ucam.org>
	<alpine.LFD.2.00.1005251114420.4114@localhost.localdomain>
	<20100525185507.GA15997@srcf.ucam.org>
	<alpine.LFD.2.00.1007211729550.409@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:8317 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab0GVAxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jul 2010 20:53:32 -0400
In-Reply-To: <alpine.LFD.2.00.1007211729550.409@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, Philip Langdale <philipl@overt.org>, Jeff Garrett <jeff@jgarrett.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Jul 21, 2010 at 2:31 PM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> The BIOS exports deep C-states on modern Intel processors
> as "C3-type" to satisfy various legacy Operating Systems.
>
> However, the hardware actually supports C2-type, and does
> not require the extra costs of C3-type.
>
> One of the costs is to check the BM_STS (Bus Master Status)
> bit before entering C3, and instead choose a shallower C-state
> if there was "recent bus master activity".
>
> We have found a number of systems in the field that erroneously
> set BM_STS and prevent entry into deep C-states.
> Re-define BIOS presented C3-type states as C2-type states
> on modern processors to avoid this issue.
>
> If a device in the system really does want to prevent use
> of a deep C-state, its Linux driver should register its
> constraints via pm_qos_add_request().
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15886
>

Agree with the intent. But, I think its cleaner to keep all arch model
checks in arch/x86/kernel/acpi/cstate.c.

Thanks,
Venki

> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> =A0drivers/acpi/processor_idle.c | =A0 38 +++++++++++++++++++++++++++=
+++++++++++
> =A01 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> index b1b3856..14d1a0c 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -607,6 +607,38 @@ static void acpi_processor_power_verify_c3(struc=
t acpi_processor *pr,
> =A0 =A0 =A0 =A0return;
> =A0}
>
> +/*
> + * Modern Intel processors support only ACPI C2-type C-states.
> + * But the BIOS tends to report its deepest C-state as C3-type
> + * to satisfy various old operating systems. =A0We can skip
> + * C3 OS overhead by treating the deep-states as C2-type.
> + * Also, we can avoid checking BM_STS, which on some systems
> + * erroneously prevents entry into C3-type states.
> + */
> +static int acpi_c3type_is_really_c2type(void) {
> +
> + =A0 =A0 =A0 if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (boot_cpu_data.x86 !=3D 6)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 switch(boot_cpu_data.x86_model) {
> + =A0 =A0 =A0 case 0x1A: =A0 =A0 =A0/* Core i7, Xeon 5500 series */
> + =A0 =A0 =A0 case 0x1E: =A0 =A0 =A0/* Core i7 and i5 Processor */
> + =A0 =A0 =A0 case 0x1F: =A0 =A0 =A0/* Core i7 and i5 Processor */
> + =A0 =A0 =A0 case 0x2E: =A0 =A0 =A0/* NHM-EX Xeon */
> + =A0 =A0 =A0 case 0x2F: =A0 =A0 =A0/* WSM-EX Xeon */
> + =A0 =A0 =A0 case 0x25: =A0 =A0 =A0/* WSM */
> + =A0 =A0 =A0 case 0x2C: =A0 =A0 =A0/* WSM */
> + =A0 =A0 =A0 case 0x2A: =A0 =A0 =A0/* SNB */
> + =A0 =A0 =A0 case 0x2D: =A0 =A0 =A0/* SNB Xeon */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +}
> +
> =A0static int acpi_processor_power_verify(struct acpi_processor *pr)
> =A0{
> =A0 =A0 =A0 =A0unsigned int i;
> @@ -617,6 +649,12 @@ static int acpi_processor_power_verify(struct ac=
pi_processor *pr)
> =A0 =A0 =A0 =A0for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER && i <=3D m=
ax_cstate; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct acpi_processor_cx *cx =3D &pr->=
power.states[i];
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cx->type =3D=3D ACPI_STATE_C3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && acpi_c3type_is_reall=
y_c2type()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_DE=
BUG_PRINT((ACPI_DB_INFO, "Redefining C3-type to C2\n"));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cx->typ=
e =3D ACPI_STATE_C2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (cx->type) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case ACPI_STATE_C1:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cx->valid =3D 1;
> --
> 1.7.2.rc3.43.g24e7a
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
