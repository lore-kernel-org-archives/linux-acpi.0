From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 06/10] ACPI: call acpi_debug_init() explicitly rather than  as initcall
Date: Tue, 24 Mar 2009 17:15:53 -0600
Message-ID: <200903241715.53690.bjorn.helgaas@hp.com>
References: <20090324224834.1262.65260.stgit@bob.kio> <20090324225003.1262.39890.stgit@bob.kio> <86802c440903241608q65dd0d94i794dbbef7bf7d586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:45616 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZCXXP6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 19:15:58 -0400
In-Reply-To: <86802c440903241608q65dd0d94i794dbbef7bf7d586@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Zhao Yakui <yakui.zhao@intel.com>

On Tuesday 24 March 2009 05:08:12 pm Yinghai Lu wrote:
> On Tue, Mar 24, 2009 at 3:50 PM, Bjorn Helgaas <bjorn.helgaas@hp.com>=
 wrote:
> > This patch makes acpi_init() call acpi_debug_init() directly.
> > Previously, both were subsys_initcalls. =A0acpi_debug_init()
> > must happen after acpi_init(), and it's better to call it
> > explicitly rather than rely on link ordering.
> >
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> > =A0drivers/acpi/bus.c =A0 =A0 =A0| =A0 =A01 +
> > =A0drivers/acpi/debug.c =A0 =A0| =A0 14 ++++++--------
> > =A0drivers/acpi/internal.h | =A0 =A06 ++++++
> > =A03 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index c133072..f32cfd6 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -883,6 +883,7 @@ static int __init acpi_init(void)
> > =A0 =A0 =A0 =A0acpi_ec_init();
> > =A0 =A0 =A0 =A0acpi_power_init();
> > =A0 =A0 =A0 =A0acpi_system_init();
> > + =A0 =A0 =A0 acpi_debug_init();
> > =A0 =A0 =A0 =A0return result;
> > =A0}
> >
> > diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
> > index 20223cb..9cb189f 100644
> > --- a/drivers/acpi/debug.c
> > +++ b/drivers/acpi/debug.c
> > @@ -297,17 +297,15 @@ acpi_system_write_debug(struct file *file,
> >
> > =A0 =A0 =A0 =A0return count;
> > =A0}
> > +#endif
> >
> > -static int __init acpi_debug_init(void)
> > +int __init acpi_debug_init(void)
> > =A0{
> > +#ifdef CONFIG_ACPI_PROCFS
> > =A0 =A0 =A0 =A0struct proc_dir_entry *entry;
> > =A0 =A0 =A0 =A0int error =3D 0;
> > =A0 =A0 =A0 =A0char *name;
> >
> > -
> > - =A0 =A0 =A0 if (acpi_disabled)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > -
> > =A0 =A0 =A0 =A0/* 'debug_layer' [R/W] */
> > =A0 =A0 =A0 =A0name =3D ACPI_SYSTEM_FILE_DEBUG_LAYER;
> > =A0 =A0 =A0 =A0entry =3D
> > @@ -338,7 +336,7 @@ static int __init acpi_debug_init(void)
> > =A0 =A0 =A0 =A0remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi=
_root_dir);
> > =A0 =A0 =A0 =A0error =3D -ENODEV;
> > =A0 =A0 =A0 =A0goto Done;
> > -}
> > -
> > -subsys_initcall(acpi_debug_init);
> > +#else
> > + =A0 =A0 =A0 return 0;
> > =A0#endif
> > +}
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 4a35f6e..44b8402 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -3,6 +3,12 @@
> > =A0int acpi_scan_init(void);
> > =A0int acpi_system_init(void);
> >
> > +#ifdef CONFIG_ACPI_DEBUG
>=20
> =3D=3D> #if defined(CONFIG_ACPI_DEBUG) && defined(CONFIG_ACPI_PROCFS)

I could do that, and leave the #ifdefs in debug.c as they were,
but I thought it was cleaner to make it so that if we compile debug.c
(i.e., CONFIG_ACPI_DEBUG=3Dy), it always provides acpi_debug_init().

I moved the #ifdefs in debug.c so that acpi_debug_init() is a no-op
if CONFIG_ACPI_PROCFS=3Dn.

So I think my patch already addressed your concern, but let me
know if not.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
