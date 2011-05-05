From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Replace acpi_gbl_FADT.sci_interrupt with two functions in
 some places.
Date: Thu, 5 May 2011 11:30:44 -0600
Message-ID: <BANLkTi=H21X71SYeJHRZw0o0moj6ky3ruQ@mail.gmail.com>
References: <1304403041.3179.29.camel@lantianyu-ws> <1304473718.3924.56.camel@minggr.sh.intel.com>
 <1304555063.5286.2.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:48705 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1EERbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2011 13:31:15 -0400
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id p45HVCMb003514
	for <linux-acpi@vger.kernel.org>; Thu, 5 May 2011 10:31:13 -0700
Received: from gyg13 (gyg13.prod.google.com [10.243.50.141])
	by kpbe15.cbf.corp.google.com with ESMTP id p45HTLVw006979
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 5 May 2011 10:31:06 -0700
Received: by gyg13 with SMTP id 13so1388661gyg.27
        for <linux-acpi@vger.kernel.org>; Thu, 05 May 2011 10:31:06 -0700 (PDT)
In-Reply-To: <1304555063.5286.2.camel@lantianyu-ws>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "lan,Tianyu" <tianyu.lan@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

>> On Tue, 2011-05-03 at 14:10 +0800, Lan, Tianyu wrote:
>> > Some places use the acpi_gbl_FADT.sci_interrupt directly to get th=
e ACPI SCI.ACPI SCI will not only be stored in the FADT.

You need at least one space after a sentence-ending period, e.g., "...
get the ACPI SCI.  ACPI SCI will not ..."

I can't figure out the intent of the patch as a whole.  It seems to be
connected with "ACPI SCI will not only be stored in the FADT," but
that isn't clear enough to tell me what's going on.  Is there a
scenario where we'll want to look somewhere else first, then fall back
to looking at the FADT?  This patch didn't implement anything like
that, but maybe you intend future changes to acpi_get_sci_interrupt()
and acpi_set_sci_interrupt()?

I think the name "acpi_get_sci_interrupt()" is somewhat redundant, or
at least confusing: "SCI" means "system control interrupt," so you're
really saying "acpi_get_system_control_interrupt_interrupt."  I guess
the first "interrupt" refers to the mechanism itself, and the second
to the vector number or GSI.  Maybe "acpi_get_sci_gsi()" would be
better?

There's also an fadt->sci_interrupt reference in
arch/ia64/kernel/acpi.c.  I don't know the intent of your patch or
whether that intent applies to ia64 as well as x86, but it's always
better if you can converge things rather than make x86 and ia64 more
different.

Unless I missed something, this patch makes no functional change.
That's fine, especially if you're getting ready for some future work,
but it's worth mentioning that this patch is reorganization only.

Bjorn

>> > So this patch replaces acpi_gbl_FADT.sci_interrupt with two functi=
ons for getting and setting.
>>
>> Some trivial patch style comments,
>>
>> We usually add "acpi:" prefix to the subject, like
>>
>> [PATCH] acpi: xxxxx
>>
>> And if acpica files are also touched, we add "acpi/acpica:" prefix, =
like
>>
>> [PATCH] acpi/acpica: xxxx
>>
>> Another thing, the change logs seems too long for each line, you'd
>> better split them short for each line. So that makes logs easy to re=
ad.
>>
>> Thanks,
>> Lin Ming
>>
>> >
>> > Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> > ---
>> > =A0arch/x86/kernel/acpi/boot.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A08 ++---
>> > =A0drivers/acpi/acpica/evgpeinit.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A05 +--
>> > =A0drivers/acpi/acpica/evgpeutil.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
>> > =A0drivers/acpi/acpica/evsci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
>> > =A0drivers/acpi/acpica/evxface.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 38 +++++++++++++++++++++++++++
>> > =A0drivers/acpi/bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A04 +-
>> > =A0drivers/acpi/osl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A06 ++--
>> > =A0drivers/acpi/pci_link.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 -
>> > =A0drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | =A0 =A02 -
>> > =A0include/acpi/acpixf.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 ++
>> > =A010 files changed, 59 insertions(+), 18 deletions(-)
>> >
>> > Index: linux-2.6/arch/x86/kernel/acpi/boot.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/arch/x86/kernel/acpi/boot.c =A0 =A0 =A02011-05-=
03 10:19:00.163029998 +0800
>> > +++ linux-2.6/arch/x86/kernel/acpi/boot.c =A0 2011-05-03 10:20:50.=
833030004 +0800
>> > @@ -408,7 +408,7 @@
>> >
>> > =A0 =A0 acpi_table_print_madt_entry(header);
>> >
>> > - =A0 if (intsrc->source_irq =3D=3D acpi_gbl_FADT.sci_interrupt) {
>> > + =A0 if (intsrc->source_irq =3D=3D acpi_get_sci_interrupt()) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 acpi_sci_ioapic_setup(intsrc->source_irq,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
>> > @@ -1100,7 +1100,7 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 return gsi;
>> >
>> > =A0 =A0 /* Don't set up the ACPI SCI because it's already set up *=
/
>> > - =A0 if (acpi_gbl_FADT.sci_interrupt =3D=3D gsi)
>> > + =A0 if (acpi_get_sci_interrupt() =3D=3D gsi)
>> > =A0 =A0 =A0 =A0 =A0 =A0 return gsi;
>> >
>> > =A0 =A0 ioapic =3D mp_find_ioapic(gsi);
>> > @@ -1184,8 +1184,8 @@
>> > =A0 =A0 =A0* pretend we got one so we can set the SCI flags.
>> > =A0 =A0 =A0*/
>> > =A0 =A0 if (!acpi_sci_override_gsi)
>> > - =A0 =A0 =A0 =A0 =A0 acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_inte=
rrupt, 0, 0,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
acpi_gbl_FADT.sci_interrupt);
>> > + =A0 =A0 =A0 =A0 =A0 acpi_sci_ioapic_setup(acpi_get_sci_interrupt=
(), 0, 0,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
acpi_get_sci_interrupt());
>> >
>> > =A0 =A0 /* Fill in identity legacy mappings where no override */
>> > =A0 =A0 mp_config_acpi_legacy_irqs();
>> > Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c =A02011-05-03 1=
0:19:00.243029997 +0800
>> > +++ linux-2.6/drivers/acpi/acpica/evgpeinit.c =A0 =A0 =A0 2011-05-=
03 10:20:50.833030004 +0800
>> > @@ -131,7 +131,7 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_ev_create_gpe_block(acpi_g=
bl_fadt_gpe_device,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &acpi_gbl_FADT.xgpe0_block,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 register_count0, 0,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 acpi_gbl_FADT.sci_interrupt,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 acpi_get_sci_interrupt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &acpi_gbl_gpe_fadt_blocks[0]);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
>> > @@ -170,8 +170,7 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&acpi_gbl_FADT.xgpe1_block,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0register_count1,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_gbl_FADT.gpe1_base,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_gbl_FADT.
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sci_interrupt,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_get_sci_interrupt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&acpi_gbl_gpe_fadt_blocks
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1]);
>> >
>> > Index: linux-2.6/drivers/acpi/acpica/evgpeutil.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/acpica/evgpeutil.c =A02011-05-03 1=
0:19:00.213030003 +0800
>> > +++ linux-2.6/drivers/acpi/acpica/evgpeutil.c =A0 =A0 =A0 2011-05-=
03 10:20:50.833030004 +0800
>> > @@ -253,7 +253,7 @@
>> >
>> > =A0 =A0 /* Install new interrupt handler if not SCI_INT */
>> >
>> > - =A0 if (interrupt_number !=3D acpi_gbl_FADT.sci_interrupt) {
>> > + =A0 if (interrupt_number !=3D acpi_get_sci_interrupt()) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_os_install_interrupt_handl=
er(interrupt_number,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_ev_gpe_xrupt_handler,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpe_xrupt);
>> > @@ -290,7 +290,7 @@
>> >
>> > =A0 =A0 /* We never want to remove the SCI interrupt handler */
>> >
>> > - =A0 if (gpe_xrupt->interrupt_number =3D=3D acpi_gbl_FADT.sci_int=
errupt) {
>> > + =A0 if (gpe_xrupt->interrupt_number =3D=3D acpi_get_sci_interrup=
t()) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 gpe_xrupt->gpe_block_list_head =3D NULL;
>> > =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(AE_OK);
>> > =A0 =A0 }
>> > Index: linux-2.6/drivers/acpi/acpica/evsci.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/acpica/evsci.c =A0 =A0 =A02011-05-=
03 10:19:00.223030004 +0800
>> > +++ linux-2.6/drivers/acpi/acpica/evsci.c =A0 2011-05-03 10:20:50.=
833030004 +0800
>> > @@ -142,7 +142,7 @@
>> > =A0 =A0 ACPI_FUNCTION_TRACE(ev_install_sci_handler);
>> >
>> > =A0 =A0 status =3D
>> > - =A0 =A0 =A0 acpi_os_install_interrupt_handler((u32) acpi_gbl_FAD=
T.sci_interrupt,
>> > + =A0 =A0 =A0 acpi_os_install_interrupt_handler((u32) acpi_get_sci=
_interrupt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 acpi_ev_sci_xrupt_handler,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 acpi_gbl_gpe_xrupt_list_head);
>> > =A0 =A0 return_ACPI_STATUS(status);
>> > @@ -176,7 +176,7 @@
>> > =A0 =A0 /* Just let the OS remove the handler and disable the leve=
l */
>> >
>> > =A0 =A0 status =3D
>> > - =A0 =A0 =A0 acpi_os_remove_interrupt_handler((u32) acpi_gbl_FADT=
=2Esci_interrupt,
>> > + =A0 =A0 =A0 acpi_os_remove_interrupt_handler((u32) acpi_get_sci_=
interrupt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0acpi_ev_sci_xrupt_handler);
>> >
>> > =A0 =A0 return_ACPI_STATUS(status);
>> > Index: linux-2.6/drivers/acpi/acpica/evxface.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/acpica/evxface.c =A0 =A02011-05-03=
 10:19:00.213030003 +0800
>> > +++ linux-2.6/drivers/acpi/acpica/evxface.c 2011-05-03 10:20:50.83=
3030004 +0800
>> > @@ -983,3 +983,41 @@
>> > =A0}
>> >
>> > =A0ACPI_EXPORT_SYMBOL(acpi_release_global_lock)
>> > +
>> > +/****************************************************************=
***************
>> > + *
>> > + * FUNCTION: =A0 =A0acpi_get_sci_interrupt
>> > + *
>> > + * PARAMETERS: =A0none
>> > + *
>> > + * RETURN: =A0 =A0 =A0SCI Interrupt
>> > + *
>> > + * DESCRIPTION: Return the ACPI SCI interrupt
>> > + *
>> > + ****************************************************************=
**************/
>> > +u16 acpi_get_sci_interrupt(void)
>> > +{
>> > + =A0 return acpi_gbl_FADT.sci_interrupt;
>> > +}
>> > +
>> > +ACPI_EXPORT_SYMBOL(acpi_get_sci_interrupt)
>> > +
>> > +/****************************************************************=
***************
>> > + =A0 =A0 =A0 =A0 =A0 *
>> > + =A0 =A0 =A0 =A0 =A0 * FUNCTION: =A0 =A0acpi_set_sci_interrupt
>> > + =A0 =A0 =A0 =A0 =A0 *
>> > + =A0 =A0 =A0 =A0 =A0 * PARAMETERS: =A0override sci irq
>> > + =A0 =A0 =A0 =A0 =A0 *
>> > + =A0 =A0 =A0 =A0 =A0 * RETURN: =A0 =A0 =A0status
>> > + =A0 =A0 =A0 =A0 =A0 *
>> > + =A0 =A0 =A0 =A0 =A0 * DESCRIPTION: Set the ACPI SCI interrupt
>> > + =A0 =A0 =A0 =A0 =A0 *
>> > + ****************************************************************=
**************/
>> > +acpi_status acpi_set_sci_interrupt(u16 irq)
>> > +{
>> > + =A0 acpi_gbl_FADT.sci_interrupt =3D irq;
>> > + =A0 return AE_OK;
>> > +}
>> > +
>> > +ACPI_EXPORT_SYMBOL(acpi_set_sci_interrupt)
>> > +
>> > Index: linux-2.6/drivers/acpi/bus.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/bus.c =A0 =A0 =A0 2011-05-03 10:19=
:00.203030002 +0800
>> > +++ linux-2.6/drivers/acpi/bus.c =A0 =A02011-05-03 10:20:50.833030=
004 +0800
>> > @@ -890,14 +890,14 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_sci_flags |=3D ACPI_M=
ADT_TRIGGER_LEVEL;
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0 =A0 =A0 /* Set PIC-mode SCI trigger type */
>> > - =A0 =A0 =A0 =A0 =A0 acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_i=
nterrupt,
>> > + =A0 =A0 =A0 =A0 =A0 acpi_pic_sci_set_trigger(acpi_get_sci_interr=
upt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK) >> 2);
>> > =A0 =A0 } else {
>> > =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0* now that acpi_gbl_FADT is initialized=
,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0* update it with result from INT_SRC_OV=
R parsing
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > - =A0 =A0 =A0 =A0 =A0 acpi_gbl_FADT.sci_interrupt =3D acpi_sci_ove=
rride_gsi;
>> > + =A0 =A0 =A0 =A0 =A0 acpi_set_sci_interrupt(acpi_sci_override_gsi=
);
>> > =A0 =A0 }
>> > =A0#endif
>> >
>> > Index: linux-2.6/drivers/acpi/osl.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/osl.c =A0 =A0 =A0 2011-05-03 10:19=
:48.993030009 +0800
>> > +++ linux-2.6/drivers/acpi/osl.c =A0 =A02011-05-03 10:20:50.833030=
004 +0800
>> > @@ -534,7 +534,7 @@
>> > =A0 =A0 =A0* ACPI interrupts different from the SCI in our copy of=
 the FADT are
>> > =A0 =A0 =A0* not supported.
>> > =A0 =A0 =A0*/
>> > - =A0 if (gsi !=3D acpi_gbl_FADT.sci_interrupt)
>> > + =A0 if (gsi !=3D acpi_get_sci_interrupt())
>> > =A0 =A0 =A0 =A0 =A0 =A0 return AE_BAD_PARAMETER;
>> >
>> > =A0 =A0 if (acpi_irq_handler)
>> > @@ -559,7 +559,7 @@
>> >
>> > =A0acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_=
handler handler)
>> > =A0{
>> > - =A0 if (irq !=3D acpi_gbl_FADT.sci_interrupt)
>> > + =A0 if (irq !=3D acpi_get_sci_interrupt())
>> > =A0 =A0 =A0 =A0 =A0 =A0 return AE_BAD_PARAMETER;
>> >
>> > =A0 =A0 free_irq(irq, acpi_irq);
>> > @@ -1622,7 +1622,7 @@
>> > =A0acpi_status acpi_os_terminate(void)
>> > =A0{
>> > =A0 =A0 if (acpi_irq_handler) {
>> > - =A0 =A0 =A0 =A0 =A0 acpi_os_remove_interrupt_handler(acpi_gbl_FA=
DT.sci_interrupt,
>> > + =A0 =A0 =A0 =A0 =A0 acpi_os_remove_interrupt_handler(acpi_get_sc=
i_interrupt(),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0acpi_irq_handler);
>> > =A0 =A0 }
>> >
>> > Index: linux-2.6/drivers/acpi/pci_link.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/acpi/pci_link.c =A02011-05-03 10:19:00.=
203030002 +0800
>> > +++ linux-2.6/drivers/acpi/pci_link.c =A0 =A0 =A0 2011-05-03 10:20=
:50.833030004 +0800
>> > @@ -508,7 +508,7 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 }
>> > =A0 =A0 /* Add a penalty for the SCI */
>> > - =A0 acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] +=3D PIRQ_PENA=
LTY_PCI_USING;
>> > + =A0 acpi_irq_penalty[acpi_get_sci_interrupt()] +=3D PIRQ_PENALTY=
_PCI_USING;
>> > =A0 =A0 return 0;
>> > =A0}
>> >
>> > Index: linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c =A0=
 =A0 2011-05-03 10:19:00.193030001 +0800
>> > +++ linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c =A02011=
-05-03 10:20:50.833030004 +0800
>> > @@ -104,7 +104,7 @@
>> > =A0 =A0 pci_dev_put(pdev);
>> >
>> > =A0 =A0 /* we're sharing the IRQ with ACPI */
>> > - =A0 irq =3D acpi_gbl_FADT.sci_interrupt;
>> > + =A0 irq =3D acpi_get_sci_interrupt();
>> > =A0 =A0 if (request_irq(irq, &dcon_interrupt, IRQF_SHARED, "DCON",=
 dcon)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR PREFIX "DCON (IRQ%d) alloc=
ation failed\n", irq);
>> > =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> > Index: linux-2.6/include/acpi/acpixf.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/include/acpi/acpixf.h =A0 =A02011-05-03 10:19:0=
0.253029998 +0800
>> > +++ linux-2.6/include/acpi/acpixf.h 2011-05-03 10:20:50.833030004 =
+0800
>> > @@ -411,6 +411,10 @@
>> > =A0acpi_info(const char *module_name,
>> > =A0 =A0 =A0 u32 line_number, const char *format, ...) ACPI_PRINTF_=
LIKE(3);
>> >
>> > +u16 acpi_get_sci_interrupt(void);
>> > +
>> > +acpi_status acpi_set_sci_interrupt(u16 irq);
>> > +
>> > =A0/*
>> > =A0 * Debug output
>> > =A0 */
>> >
>> > ---
>> >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
