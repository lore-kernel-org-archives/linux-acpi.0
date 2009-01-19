From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.29-rc2] ALi USB OHCI enables interrupts during power down in suspend.
Date: Mon, 19 Jan 2009 21:48:01 +0100
Message-ID: <200901192148.02096.rjw@sisk.pl>
References: <200901181642.00886.arvidjaar@mail.ru> <200901192013.46962.rjw@sisk.pl> <200901192333.40757.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39561 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbZASUs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2009 15:48:27 -0500
In-Reply-To: <200901192333.40757.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Monday 19 January 2009, Andrey Borzenkov wrote:
> On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 22:13:46 Rafael J. Wy=
socki wrote:
> > On Monday 19 January 2009, Andrey Borzenkov wrote:
> > > On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 12:51:12 Rafael J=
=2E Wysocki wrote:
> > > > On Monday 19 January 2009, Andrey Borzenkov wrote:
> > > > > On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 03:17:49 Rafa=
el J. Wysocki wrote:
> > > > > > On Sunday 18 January 2009, Andrey Borzenkov wrote:
> > > > > > > On 18 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 23:21:24 =
Rafael J. Wysocki wrote:
> > > > > > > > > > As far as I can tell, timekeeping_resume is called
> > > > > > > > > > via class ->resume method; and according to comment=
s
> > > > > > > > > > in sysdev_resume() and device_power_up(), they are
> > > > > > > > > > called with interrupts disabled.
> > > > > > > > > >
> > > > > > > > > > Looking at suspend_enter, irqs *are* disabled at th=
is
> > > > > > > > > > point.
> > > > > > > > > >
> > > > > > > > > > So it actually looks like something (may be some
> > > > > > > > > > driver) unconditionally enabled irqs in resume path=
=2E
> > > > > > > > > >
> > > > > > > > > > I believe the patch should be hold back until this =
is
> > > > > > > > > > clarified.
> > > > > > > > >
> > > > > > > > > That's a nice theory!
> > > > > > > >
> > > > > > > > That would be a bad bug.
> > >
> > > [...]
> > >
> > > > However, I suspect the problem is somewhere else.
> > >
> > > Right.
> > >
> > > > Can you apply the patch I sent earlier in this thread
> > > > (http://lkml.org/lkml/2009/1/18/183) and retest?
> > >
> > > I did and it was silent. But with patch below I get:
> > >
> > > [  152.526550] Freezing user space processes ... (elapsed 0.01
> > > seconds) done.
> > > [  152.544162] Freezing remaining freezable tasks ... (elapsed 0.=
00
> > > seconds) done.
> > > [  152.544854] Suspending console(s) (use no_console_suspend to
> > > debug) [  152.556234] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > [  152.907091] sd 0:0:0:0: [sda] Stopping disk
> > > [  153.579824] pci 0000:01:00.0: power state changed by ACPI to D=
3
> > > [  153.594449] e100 0000:00:0a.0: PME# enabled
> > > [  153.594688] e100 0000:00:0a.0: wake-up capability enabled by
> > > ACPI [  153.594855] e100 0000:00:0a.0: PCI INT A disabled
> > > [  153.650834] ALI 5451 0000:00:06.0: PCI INT A disabled
> > > [  153.663826] ALI 5451 0000:00:06.0: power state changed by ACPI
> > > to D3 [  154.417072] pata_ali 0000:00:04.0: can't derive routing
> > > for PCI INT A [  154.430275] ohci_hcd 0000:00:02.0: PME# enabled
> > > [  154.430490] ohci_hcd 0000:00:02.0: wake-up capability enabled =
by
> > > ACPI [  154.430520] ohci_hcd 0000:00:02.0: PCI INT A disabled
> > > [  154.446867] ACPI: Preparing to enter system sleep state S3
> > > [  154.460237] ------------[ cut here ]------------
> > > [  154.460250] WARNING: at /home/bor/src/linux-
> > > git/drivers/base/power/main.c:579 device_power_down+0x18f/0x1e0()
> > > [  154.460259] Hardware name: PORTEGE 4000
> > > [  154.460265] Interrupts enabled after 0000:00:02.0!
> > >
> > > The device is
> > >
> > > {pts/2}% lspci -nnv -s 00:02.0
> > > 00:02.0 USB Controller [0c03]: ALi Corporation USB 1.1 Controller
> > > [10b9:5237] (rev 03) (prog-if 10 [OHCI])
> > >         Subsystem: Toshiba America Info Systems Device [1179:0004=
]
> > >         Flags: bus master, medium devsel, latency 64, IRQ 11
> > >         Memory at f7eff000 (32-bit, non-prefetchable) [size=3D4K]
> > >         Capabilities: <access denied>
> > >         Kernel driver in use: ohci_hcd
> > >         Kernel modules: ohci-hcd
> > >
> > > and this does not surprise me at all given all the problems I had
> > > with this USB controller.
> > >
> > > Suspicious is
> > >
> > > ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI
> > >
> > > this controller has history of broken wake up functionality.
> >
> > Ah.
> >
> > Can you please check if the appended patch fixes the issue for you?
> >
> > Rafael
> >
>=20
> Yes.
>=20
> Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>

OK, thanks for the confirmation.

Time to write a changelog ...

> > ---
> >  drivers/usb/core/hcd-pci.c  |  116
> > ++++++++++---------------------------------- drivers/usb/core/hcd.h=
 =20
> >    |    1
> >  drivers/usb/host/ehci-pci.c |    1
> >  drivers/usb/host/ohci-pci.c |    1
> >  drivers/usb/host/uhci-hcd.c |    1
> >  5 files changed, 27 insertions(+), 93 deletions(-)
> >
> > Index: linux-2.6/drivers/usb/core/hcd-pci.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/usb/core/hcd-pci.c
> > +++ linux-2.6/drivers/usb/core/hcd-pci.c
> > @@ -200,6 +200,7 @@ int usb_hcd_pci_suspend(struct pci_dev *
> >  	struct usb_hcd		*hcd =3D pci_get_drvdata(dev);
> >  	int			retval =3D 0;
> >  	int			wake, w;
> > +	int			has_pci_pm;
> >
> >  	/* Root hub suspend should have stopped all downstream traffic,
> >  	 * and all bus master traffic.  And done so for both the interfac=
e
> > @@ -229,6 +230,15 @@ int usb_hcd_pci_suspend(struct pci_dev *
> >
> >  	synchronize_irq(dev->irq);
> >
> > +	/* Downstream ports from this root hub should already be quiesced=
,
> > so +	 * there will be no DMA activity.  Now we can shut down the
> > upstream +	 * link (except maybe for PME# resume signaling) and ent=
er
> > some PCI +	 * low power state, if the hardware allows.
> > +	 */
> > +	pci_disable_device(dev);
> > +
> > +	pci_save_state(dev);
> > +
> >  	/* Don't fail on error to enable wakeup.  We rely on pci code
> >  	 * to reject requests the hardware can't implement, rather
> >  	 * than coding the same thing.
> > @@ -240,35 +250,6 @@ int usb_hcd_pci_suspend(struct pci_dev *
> >  		wake =3D w;
> >  	dev_dbg(&dev->dev, "wakeup: %d\n", wake);
> >
> > -	/* Downstream ports from this root hub should already be quiesced=
,
> > so -	 * there will be no DMA activity.  Now we can shut down the
> > upstream -	 * link (except maybe for PME# resume signaling) and ent=
er
> > some PCI -	 * low power state, if the hardware allows.
> > -	 */
> > -	pci_disable_device(dev);
> > - done:
> > -	return retval;
> > -}
> > -EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
> > -
> > -/**
> > - * usb_hcd_pci_suspend_late - suspend a PCI-based HCD after IRQs a=
re
> > disabled - * @dev: USB Host Controller being suspended
> > - * @message: Power Management message describing this state
> > transition - *
> > - * Store this function in the HCD's struct pci_driver as
> > .suspend_late. - */
> > -int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t
> > message) -{
> > -	int			retval =3D 0;
> > -	int			has_pci_pm;
> > -
> > -	/* We might already be suspended (runtime PM -- not yet written) =
*/
> > -	if (dev->current_state !=3D PCI_D0)
> > -		goto done;
> > -
> > -	pci_save_state(dev);
> > -
> >  	/* Don't change state if we don't need to */
> >  	if (message.event =3D=3D PM_EVENT_FREEZE ||
> >  			message.event =3D=3D PM_EVENT_PRETHAW) {
> > @@ -314,7 +295,7 @@ int usb_hcd_pci_suspend_late(struct pci_
> >   done:
> >  	return retval;
> >  }
> > -EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend_late);
> > +EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
> >
> >  /**
> >   * usb_hcd_pci_resume_early - resume a PCI-based HCD before IRQs a=
re
> > enabled @@ -324,65 +305,8 @@ EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend_=
la
> > */
> >  int usb_hcd_pci_resume_early(struct pci_dev *dev)
> >  {
> > -	int		retval =3D 0;
> > -	pci_power_t	state =3D dev->current_state;
> > -
> > -#ifdef CONFIG_PPC_PMAC
> > -	/* Reenable ASIC clocks for USB */
> > -	if (machine_is(powermac)) {
> > -		struct device_node *of_node;
> > -
> > -		of_node =3D pci_device_to_OF_node(dev);
> > -		if (of_node)
> > -			pmac_call_feature(PMAC_FTR_USB_ENABLE,
> > -						of_node, 0, 1);
> > -	}
> > -#endif
> > -
> > -	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
> > -	 * calls "standby", "suspend to RAM", and so on).  There are also
> > -	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
> > -	 */
> > -	if (state !=3D PCI_D0) {
> > -#ifdef	DEBUG
> > -		int	pci_pm;
> > -		u16	pmcr;
> > -
> > -		pci_pm =3D pci_find_capability(dev, PCI_CAP_ID_PM);
> > -		pci_read_config_word(dev, pci_pm + PCI_PM_CTRL, &pmcr);
> > -		pmcr &=3D PCI_PM_CTRL_STATE_MASK;
> > -		if (pmcr) {
> > -			/* Clean case:  power to USB and to HC registers was
> > -			 * maintained; remote wakeup is easy.
> > -			 */
> > -			dev_dbg(&dev->dev, "resume from PCI D%d\n", pmcr);
> > -		} else {
> > -			/* Clean:  HC lost Vcc power, D0 uninitialized
> > -			 *   + Vaux may have preserved port and transceiver
> > -			 *     state ... for remote wakeup from D3cold
> > -			 *   + or not; HCD must reinit + re-enumerate
> > -			 *
> > -			 * Dirty: D0 semi-initialized cases with swsusp
> > -			 *   + after BIOS init
> > -			 *   + after Linux init (HCD statically linked)
> > -			 */
> > -			dev_dbg(&dev->dev, "resume from previous PCI D%d\n",
> > -					state);
> > -		}
> > -#endif
> > -
> > -		retval =3D pci_set_power_state(dev, PCI_D0);
> > -	} else {
> > -		/* Same basic cases: clean (powered/not), dirty */
> > -		dev_dbg(&dev->dev, "PCI legacy resume\n");
> > -	}
> > -
> > -	if (retval < 0)
> > -		dev_err(&dev->dev, "can't resume: %d\n", retval);
> > -	else
> > -		pci_restore_state(dev);
> > -
> > -	return retval;
> > +	pci_restore_state(dev);
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(usb_hcd_pci_resume_early);
> >
> > @@ -397,6 +321,18 @@ int usb_hcd_pci_resume(struct pci_dev *d
> >  	struct usb_hcd		*hcd;
> >  	int			retval;
> >
> > +#ifdef CONFIG_PPC_PMAC
> > +	/* Reenable ASIC clocks for USB */
> > +	if (machine_is(powermac)) {
> > +		struct device_node *of_node;
> > +
> > +		of_node =3D pci_device_to_OF_node(dev);
> > +		if (of_node)
> > +			pmac_call_feature(PMAC_FTR_USB_ENABLE,
> > +						of_node, 0, 1);
> > +	}
> > +#endif
> > +
> >  	hcd =3D pci_get_drvdata(dev);
> >  	if (hcd->state !=3D HC_STATE_SUSPENDED) {
> >  		dev_dbg(hcd->self.controller,
> > @@ -404,6 +340,8 @@ int usb_hcd_pci_resume(struct pci_dev *d
> >  		return 0;
> >  	}
> >
> > +	pci_enable_wake(dev, PCI_D0, false);
> > +
> >  	retval =3D pci_enable_device(dev);
> >  	if (retval < 0) {
> >  		dev_err(&dev->dev, "can't re-enable after resume, %d!\n",
> > Index: linux-2.6/drivers/usb/core/hcd.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/usb/core/hcd.h
> > +++ linux-2.6/drivers/usb/core/hcd.h
> > @@ -257,7 +257,6 @@ extern void usb_hcd_pci_remove(struct pc
> >
> >  #ifdef CONFIG_PM
> >  extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t
> > msg); -extern int usb_hcd_pci_suspend_late(struct pci_dev *dev,
> > pm_message_t msg); extern int usb_hcd_pci_resume_early(struct pci_d=
ev
> > *dev);
> >  extern int usb_hcd_pci_resume(struct pci_dev *dev);
> >  #endif /* CONFIG_PM */
> > Index: linux-2.6/drivers/usb/host/ehci-pci.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/usb/host/ehci-pci.c
> > +++ linux-2.6/drivers/usb/host/ehci-pci.c
> > @@ -432,7 +432,6 @@ static struct pci_driver ehci_pci_driver
> >
> >  #ifdef	CONFIG_PM
> >  	.suspend =3D	usb_hcd_pci_suspend,
> > -	.suspend_late =3D	usb_hcd_pci_suspend_late,
> >  	.resume_early =3D	usb_hcd_pci_resume_early,
> >  	.resume =3D	usb_hcd_pci_resume,
> >  #endif
> > Index: linux-2.6/drivers/usb/host/ohci-pci.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/usb/host/ohci-pci.c
> > +++ linux-2.6/drivers/usb/host/ohci-pci.c
> > @@ -487,7 +487,6 @@ static struct pci_driver ohci_pci_driver
> >
> >  #ifdef	CONFIG_PM
> >  	.suspend =3D	usb_hcd_pci_suspend,
> > -	.suspend_late =3D	usb_hcd_pci_suspend_late,
> >  	.resume_early =3D	usb_hcd_pci_resume_early,
> >  	.resume =3D	usb_hcd_pci_resume,
> >  #endif
> > Index: linux-2.6/drivers/usb/host/uhci-hcd.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/usb/host/uhci-hcd.c
> > +++ linux-2.6/drivers/usb/host/uhci-hcd.c
> > @@ -942,7 +942,6 @@ static struct pci_driver uhci_pci_driver
> >
> >  #ifdef	CONFIG_PM
> >  	.suspend =3D	usb_hcd_pci_suspend,
> > -	.suspend_late =3D	usb_hcd_pci_suspend_late,
> >  	.resume_early =3D	usb_hcd_pci_resume_early,
> >  	.resume =3D	usb_hcd_pci_resume,
> >  #endif	/* PM */
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
