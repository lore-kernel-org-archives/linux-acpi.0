From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: Re: [PATCH] Replace acpi_gbl_FADT.sci_interrupt with two functions
 in some places.
Date: Fri, 06 May 2011 10:07:13 +0800
Message-ID: <1304647633.5286.1487.camel@lantianyu-ws>
References: <1304403041.3179.29.camel@lantianyu-ws>
	 <1304473718.3924.56.camel@minggr.sh.intel.com>
	 <1304555063.5286.2.camel@lantianyu-ws>
	 <BANLkTi=H21X71SYeJHRZw0o0moj6ky3ruQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35964 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab1EFCIH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 May 2011 22:08:07 -0400
In-Reply-To: <BANLkTi=H21X71SYeJHRZw0o0moj6ky3ruQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

hi Bjorn:
     Thanks for your comments and advices. This patch is for ACPI 5.0.
Just like you said, I intend future changes to acpi_get_sci_interrupt()
and acpi_set_sci_interrupt(). This accord to ACPI 5.0 which is not
stable now.
     The name "acpi_get_sci_interrupt" is not reasonable.Your analysis
is very comprehensive. I will notice it.
     For fadt->sci_interrupt reference=20
>static int __init acpi_parse_fadt(struct acpi_table_header *table)
>{ =20
>   struct acpi_table_header *fadt_header;
>   struct acpi_table_fadt *fadt;
>
>   if (!table)
>       return -EINVAL;
>
>   fadt_header =3D (struct acpi_table_header *)table;
>   if (fadt_header->revision !=3D 3)
>       return -ENODEV; /* Only deal with ACPI 2.0 FADT */
>
>   fadt =3D (struct acpi_table_fadt *)fadt_header;
>
>   acpi_register_gsi(NULL, fadt->sci_interrupt, ACPI_LEVEL_SENSITIVE,
>                ACPI_ACTIVE_LOW);
>   return 0;
>}
    The code just is be used when it is ACPI 2.0. So I haven't
considered it. This blame my unclear comment.=20
    Thank you again. You advices are very useful and helpful.

Tianyu

=E5=9C=A8 2011-05-06=E4=BA=94=E7=9A=84 01:30 +0800=EF=BC=8CBjorn Helgaa=
s=E5=86=99=E9=81=93=EF=BC=9A
> >> On Tue, 2011-05-03 at 14:10 +0800, Lan, Tianyu wrote:
> >> > Some places use the acpi_gbl_FADT.sci_interrupt directly to get =
the ACPI SCI.ACPI SCI will not only be stored in the FADT.
>=20
> You need at least one space after a sentence-ending period, e.g., "..=
=2E
> get the ACPI SCI.  ACPI SCI will not ..."
>=20
> I can't figure out the intent of the patch as a whole.  It seems to b=
e
> connected with "ACPI SCI will not only be stored in the FADT," but
> that isn't clear enough to tell me what's going on.  Is there a
> scenario where we'll want to look somewhere else first, then fall bac=
k
> to looking at the FADT?  This patch didn't implement anything like
> that, but maybe you intend future changes to acpi_get_sci_interrupt()
> and acpi_set_sci_interrupt()?
>=20
> I think the name "acpi_get_sci_interrupt()" is somewhat redundant, or
> at least confusing: "SCI" means "system control interrupt," so you're
> really saying "acpi_get_system_control_interrupt_interrupt."  I guess
> the first "interrupt" refers to the mechanism itself, and the second
> to the vector number or GSI.  Maybe "acpi_get_sci_gsi()" would be
> better?
>=20
> There's also an fadt->sci_interrupt reference in
> arch/ia64/kernel/acpi.c.  I don't know the intent of your patch or
> whether that intent applies to ia64 as well as x86, but it's always
> better if you can converge things rather than make x86 and ia64 more
> different.
>=20
> Unless I missed something, this patch makes no functional change.
> That's fine, especially if you're getting ready for some future work,
> but it's worth mentioning that this patch is reorganization only.
>=20
> Bjorn
>=20
> >> > So this patch replaces acpi_gbl_FADT.sci_interrupt with two func=
tions for getting and setting.
> >>
> >> Some trivial patch style comments,
> >>
> >> We usually add "acpi:" prefix to the subject, like
> >>
> >> [PATCH] acpi: xxxxx
> >>
> >> And if acpica files are also touched, we add "acpi/acpica:" prefix=
, like
> >>
> >> [PATCH] acpi/acpica: xxxx
> >>
> >> Another thing, the change logs seems too long for each line, you'd
> >> better split them short for each line. So that makes logs easy to =
read.
> >>
> >> Thanks,
> >> Lin Ming
> >>
> >> >
> >> > Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> > ---
> >> >  arch/x86/kernel/acpi/boot.c                  |    8 ++---
> >> >  drivers/acpi/acpica/evgpeinit.c              |    5 +--
> >> >  drivers/acpi/acpica/evgpeutil.c              |    4 +-
> >> >  drivers/acpi/acpica/evsci.c                  |    4 +-
> >> >  drivers/acpi/acpica/evxface.c                |   38 +++++++++++=
++++++++++++++++
> >> >  drivers/acpi/bus.c                           |    4 +-
> >> >  drivers/acpi/osl.c                           |    6 ++--
> >> >  drivers/acpi/pci_link.c                      |    2 -
> >> >  drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c |    2 -
> >> >  include/acpi/acpixf.h                        |    4 ++
> >> >  10 files changed, 59 insertions(+), 18 deletions(-)
> >> >
> >> > Index: linux-2.6/arch/x86/kernel/acpi/boot.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/arch/x86/kernel/acpi/boot.c      2011-05-03 1=
0:19:00.163029998 +0800
> >> > +++ linux-2.6/arch/x86/kernel/acpi/boot.c   2011-05-03 10:20:50.=
833030004 +0800
> >> > @@ -408,7 +408,7 @@
> >> >
> >> >     acpi_table_print_madt_entry(header);
> >> >
> >> > -   if (intsrc->source_irq =3D=3D acpi_gbl_FADT.sci_interrupt) {
> >> > +   if (intsrc->source_irq =3D=3D acpi_get_sci_interrupt()) {
> >> >             acpi_sci_ioapic_setup(intsrc->source_irq,
> >> >                                   intsrc->inti_flags & ACPI_MADT=
_POLARITY_MASK,
> >> >                                   (intsrc->inti_flags & ACPI_MAD=
T_TRIGGER_MASK) >> 2,
> >> > @@ -1100,7 +1100,7 @@
> >> >             return gsi;
> >> >
> >> >     /* Don't set up the ACPI SCI because it's already set up */
> >> > -   if (acpi_gbl_FADT.sci_interrupt =3D=3D gsi)
> >> > +   if (acpi_get_sci_interrupt() =3D=3D gsi)
> >> >             return gsi;
> >> >
> >> >     ioapic =3D mp_find_ioapic(gsi);
> >> > @@ -1184,8 +1184,8 @@
> >> >      * pretend we got one so we can set the SCI flags.
> >> >      */
> >> >     if (!acpi_sci_override_gsi)
> >> > -           acpi_sci_ioapic_setup(acpi_gbl_FADT.sci_interrupt, 0=
, 0,
> >> > -                                 acpi_gbl_FADT.sci_interrupt);
> >> > +           acpi_sci_ioapic_setup(acpi_get_sci_interrupt(), 0, 0=
,
> >> > +                                 acpi_get_sci_interrupt());
> >> >
> >> >     /* Fill in identity legacy mappings where no override */
> >> >     mp_config_acpi_legacy_irqs();
> >> > Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c  2011-05-03 1=
0:19:00.243029997 +0800
> >> > +++ linux-2.6/drivers/acpi/acpica/evgpeinit.c       2011-05-03 1=
0:20:50.833030004 +0800
> >> > @@ -131,7 +131,7 @@
> >> >             status =3D acpi_ev_create_gpe_block(acpi_gbl_fadt_gp=
e_device,
> >> >                                               &acpi_gbl_FADT.xgp=
e0_block,
> >> >                                               register_count0, 0=
,
> >> > -                                             acpi_gbl_FADT.sci_=
interrupt,
> >> > +                                             acpi_get_sci_inter=
rupt(),
> >> >                                               &acpi_gbl_gpe_fadt=
_blocks[0]);
> >> >
> >> >             if (ACPI_FAILURE(status)) {
> >> > @@ -170,8 +170,7 @@
> >> >                                                  &acpi_gbl_FADT.=
xgpe1_block,
> >> >                                                  register_count1=
,
> >> >                                                  acpi_gbl_FADT.g=
pe1_base,
> >> > -                                                acpi_gbl_FADT.
> >> > -                                                sci_interrupt,
> >> > +                                                acpi_get_sci_in=
terrupt(),
> >> >                                                  &acpi_gbl_gpe_f=
adt_blocks
> >> >                                                  [1]);
> >> >
> >> > Index: linux-2.6/drivers/acpi/acpica/evgpeutil.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/acpica/evgpeutil.c  2011-05-03 1=
0:19:00.213030003 +0800
> >> > +++ linux-2.6/drivers/acpi/acpica/evgpeutil.c       2011-05-03 1=
0:20:50.833030004 +0800
> >> > @@ -253,7 +253,7 @@
> >> >
> >> >     /* Install new interrupt handler if not SCI_INT */
> >> >
> >> > -   if (interrupt_number !=3D acpi_gbl_FADT.sci_interrupt) {
> >> > +   if (interrupt_number !=3D acpi_get_sci_interrupt()) {
> >> >             status =3D acpi_os_install_interrupt_handler(interru=
pt_number,
> >> >                                                        acpi_ev_g=
pe_xrupt_handler,
> >> >                                                        gpe_xrupt=
);
> >> > @@ -290,7 +290,7 @@
> >> >
> >> >     /* We never want to remove the SCI interrupt handler */
> >> >
> >> > -   if (gpe_xrupt->interrupt_number =3D=3D acpi_gbl_FADT.sci_int=
errupt) {
> >> > +   if (gpe_xrupt->interrupt_number =3D=3D acpi_get_sci_interrup=
t()) {
> >> >             gpe_xrupt->gpe_block_list_head =3D NULL;
> >> >             return_ACPI_STATUS(AE_OK);
> >> >     }
> >> > Index: linux-2.6/drivers/acpi/acpica/evsci.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/acpica/evsci.c      2011-05-03 1=
0:19:00.223030004 +0800
> >> > +++ linux-2.6/drivers/acpi/acpica/evsci.c   2011-05-03 10:20:50.=
833030004 +0800
> >> > @@ -142,7 +142,7 @@
> >> >     ACPI_FUNCTION_TRACE(ev_install_sci_handler);
> >> >
> >> >     status =3D
> >> > -       acpi_os_install_interrupt_handler((u32) acpi_gbl_FADT.sc=
i_interrupt,
> >> > +       acpi_os_install_interrupt_handler((u32) acpi_get_sci_int=
errupt(),
> >> >                                           acpi_ev_sci_xrupt_hand=
ler,
> >> >                                           acpi_gbl_gpe_xrupt_lis=
t_head);
> >> >     return_ACPI_STATUS(status);
> >> > @@ -176,7 +176,7 @@
> >> >     /* Just let the OS remove the handler and disable the level =
*/
> >> >
> >> >     status =3D
> >> > -       acpi_os_remove_interrupt_handler((u32) acpi_gbl_FADT.sci=
_interrupt,
> >> > +       acpi_os_remove_interrupt_handler((u32) acpi_get_sci_inte=
rrupt(),
> >> >                                          acpi_ev_sci_xrupt_handl=
er);
> >> >
> >> >     return_ACPI_STATUS(status);
> >> > Index: linux-2.6/drivers/acpi/acpica/evxface.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/acpica/evxface.c    2011-05-03 1=
0:19:00.213030003 +0800
> >> > +++ linux-2.6/drivers/acpi/acpica/evxface.c 2011-05-03 10:20:50.=
833030004 +0800
> >> > @@ -983,3 +983,41 @@
> >> >  }
> >> >
> >> >  ACPI_EXPORT_SYMBOL(acpi_release_global_lock)
> >> > +
> >> > +/**************************************************************=
*****************
> >> > + *
> >> > + * FUNCTION:    acpi_get_sci_interrupt
> >> > + *
> >> > + * PARAMETERS:  none
> >> > + *
> >> > + * RETURN:      SCI Interrupt
> >> > + *
> >> > + * DESCRIPTION: Return the ACPI SCI interrupt
> >> > + *
> >> > + **************************************************************=
****************/
> >> > +u16 acpi_get_sci_interrupt(void)
> >> > +{
> >> > +   return acpi_gbl_FADT.sci_interrupt;
> >> > +}
> >> > +
> >> > +ACPI_EXPORT_SYMBOL(acpi_get_sci_interrupt)
> >> > +
> >> > +/**************************************************************=
*****************
> >> > +           *
> >> > +           * FUNCTION:    acpi_set_sci_interrupt
> >> > +           *
> >> > +           * PARAMETERS:  override sci irq
> >> > +           *
> >> > +           * RETURN:      status
> >> > +           *
> >> > +           * DESCRIPTION: Set the ACPI SCI interrupt
> >> > +           *
> >> > + **************************************************************=
****************/
> >> > +acpi_status acpi_set_sci_interrupt(u16 irq)
> >> > +{
> >> > +   acpi_gbl_FADT.sci_interrupt =3D irq;
> >> > +   return AE_OK;
> >> > +}
> >> > +
> >> > +ACPI_EXPORT_SYMBOL(acpi_set_sci_interrupt)
> >> > +
> >> > Index: linux-2.6/drivers/acpi/bus.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/bus.c       2011-05-03 10:19:00.=
203030002 +0800
> >> > +++ linux-2.6/drivers/acpi/bus.c    2011-05-03 10:20:50.83303000=
4 +0800
> >> > @@ -890,14 +890,14 @@
> >> >                     acpi_sci_flags |=3D ACPI_MADT_TRIGGER_LEVEL;
> >> >             }
> >> >             /* Set PIC-mode SCI trigger type */
> >> > -           acpi_pic_sci_set_trigger(acpi_gbl_FADT.sci_interrupt=
,
> >> > +           acpi_pic_sci_set_trigger(acpi_get_sci_interrupt(),
> >> >                                      (acpi_sci_flags & ACPI_MADT=
_TRIGGER_MASK) >> 2);
> >> >     } else {
> >> >             /*
> >> >              * now that acpi_gbl_FADT is initialized,
> >> >              * update it with result from INT_SRC_OVR parsing
> >> >              */
> >> > -           acpi_gbl_FADT.sci_interrupt =3D acpi_sci_override_gs=
i;
> >> > +           acpi_set_sci_interrupt(acpi_sci_override_gsi);
> >> >     }
> >> >  #endif
> >> >
> >> > Index: linux-2.6/drivers/acpi/osl.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/osl.c       2011-05-03 10:19:48.=
993030009 +0800
> >> > +++ linux-2.6/drivers/acpi/osl.c    2011-05-03 10:20:50.83303000=
4 +0800
> >> > @@ -534,7 +534,7 @@
> >> >      * ACPI interrupts different from the SCI in our copy of the=
 FADT are
> >> >      * not supported.
> >> >      */
> >> > -   if (gsi !=3D acpi_gbl_FADT.sci_interrupt)
> >> > +   if (gsi !=3D acpi_get_sci_interrupt())
> >> >             return AE_BAD_PARAMETER;
> >> >
> >> >     if (acpi_irq_handler)
> >> > @@ -559,7 +559,7 @@
> >> >
> >> >  acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_=
handler handler)
> >> >  {
> >> > -   if (irq !=3D acpi_gbl_FADT.sci_interrupt)
> >> > +   if (irq !=3D acpi_get_sci_interrupt())
> >> >             return AE_BAD_PARAMETER;
> >> >
> >> >     free_irq(irq, acpi_irq);
> >> > @@ -1622,7 +1622,7 @@
> >> >  acpi_status acpi_os_terminate(void)
> >> >  {
> >> >     if (acpi_irq_handler) {
> >> > -           acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_i=
nterrupt,
> >> > +           acpi_os_remove_interrupt_handler(acpi_get_sci_interr=
upt(),
> >> >                                              acpi_irq_handler);
> >> >     }
> >> >
> >> > Index: linux-2.6/drivers/acpi/pci_link.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/acpi/pci_link.c  2011-05-03 10:19:00.=
203030002 +0800
> >> > +++ linux-2.6/drivers/acpi/pci_link.c       2011-05-03 10:20:50.=
833030004 +0800
> >> > @@ -508,7 +508,7 @@
> >> >             }
> >> >     }
> >> >     /* Add a penalty for the SCI */
> >> > -   acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] +=3D PIRQ_PENA=
LTY_PCI_USING;
> >> > +   acpi_irq_penalty[acpi_get_sci_interrupt()] +=3D PIRQ_PENALTY=
_PCI_USING;
> >> >     return 0;
> >> >  }
> >> >
> >> > Index: linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c =
    2011-05-03 10:19:00.193030001 +0800
> >> > +++ linux-2.6/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c  2011=
-05-03 10:20:50.833030004 +0800
> >> > @@ -104,7 +104,7 @@
> >> >     pci_dev_put(pdev);
> >> >
> >> >     /* we're sharing the IRQ with ACPI */
> >> > -   irq =3D acpi_gbl_FADT.sci_interrupt;
> >> > +   irq =3D acpi_get_sci_interrupt();
> >> >     if (request_irq(irq, &dcon_interrupt, IRQF_SHARED, "DCON", d=
con)) {
> >> >             printk(KERN_ERR PREFIX "DCON (IRQ%d) allocation fail=
ed\n", irq);
> >> >             return 1;
> >> > Index: linux-2.6/include/acpi/acpixf.h
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- linux-2.6.orig/include/acpi/acpixf.h    2011-05-03 10:19:00.=
253029998 +0800
> >> > +++ linux-2.6/include/acpi/acpixf.h 2011-05-03 10:20:50.83303000=
4 +0800
> >> > @@ -411,6 +411,10 @@
> >> >  acpi_info(const char *module_name,
> >> >       u32 line_number, const char *format, ...) ACPI_PRINTF_LIKE=
(3);
> >> >
> >> > +u16 acpi_get_sci_interrupt(void);
> >> > +
> >> > +acpi_status acpi_set_sci_interrupt(u16 irq);
> >> > +
> >> >  /*
> >> >   * Debug output
> >> >   */
> >> >
> >> > ---
> >> >
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
