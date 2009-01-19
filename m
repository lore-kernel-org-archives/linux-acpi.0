From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [2.6.29-rc2] ALi USB OHCI enables interrupts during power down in suspend.
Date: Mon, 19 Jan 2009 21:37:23 +0300
Message-ID: <200901192137.25988.arvidjaar@mail.ru>
References: <200901181642.00886.arvidjaar@mail.ru> <200901190722.10762.arvidjaar@mail.ru> <200901191051.13211.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2089579.RIkFXiB8SQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753262AbZASSih@vger.kernel.org>
In-Reply-To: <200901191051.13211.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

--nextPart2089579.RIkFXiB8SQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 12:51:12 Rafael J. Wysocki =
wrote:
> On Monday 19 January 2009, Andrey Borzenkov wrote:
> > On 19 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 03:17:49 Rafael J. Wyso=
cki wrote:
> > > On Sunday 18 January 2009, Andrey Borzenkov wrote:
> > > > On 18 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2009 23:21:24 Rafael J. =
Wysocki wrote:
> > > > > > > As far as I can tell, timekeeping_resume is called via
> > > > > > > class ->resume method; and according to comments in
> > > > > > > sysdev_resume() and device_power_up(), they are called
> > > > > > > with interrupts disabled.
> > > > > > >
> > > > > > > Looking at suspend_enter, irqs *are* disabled at this
> > > > > > > point.
> > > > > > >
> > > > > > > So it actually looks like something (may be some driver)
> > > > > > > unconditionally enabled irqs in resume path.
> > > > > > >
> > > > > > > I believe the patch should be hold back until this is
> > > > > > > clarified.
> > > > > >
> > > > > > That's a nice theory!
> > > > >
> > > > > That would be a bad bug.
[...]
>
> However, I suspect the problem is somewhere else.
>

Right.=20

> Can you apply the patch I sent earlier in this thread
> (http://lkml.org/lkml/2009/1/18/183) and retest?
>

I did and it was silent. But with patch below I get:

[  152.526550] Freezing user space processes ... (elapsed 0.01 seconds)=20
done.
[  152.544162] Freezing remaining freezable tasks ... (elapsed 0.00 seconds=
)=20
done.
[  152.544854] Suspending console(s) (use no_console_suspend to debug)
[  152.556234] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  152.907091] sd 0:0:0:0: [sda] Stopping disk
[  153.579824] pci 0000:01:00.0: power state changed by ACPI to D3
[  153.594449] e100 0000:00:0a.0: PME# enabled
[  153.594688] e100 0000:00:0a.0: wake-up capability enabled by ACPI
[  153.594855] e100 0000:00:0a.0: PCI INT A disabled
[  153.650834] ALI 5451 0000:00:06.0: PCI INT A disabled
[  153.663826] ALI 5451 0000:00:06.0: power state changed by ACPI to D3
[  154.417072] pata_ali 0000:00:04.0: can't derive routing for PCI INT A
[  154.430275] ohci_hcd 0000:00:02.0: PME# enabled
[  154.430490] ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI
[  154.430520] ohci_hcd 0000:00:02.0: PCI INT A disabled
[  154.446867] ACPI: Preparing to enter system sleep state S3
[  154.460237] ------------[ cut here ]------------
[  154.460250] WARNING: at /home/bor/src/linux-
git/drivers/base/power/main.c:579 device_power_down+0x18f/0x1e0()
[  154.460259] Hardware name: PORTEGE 4000
[  154.460265] Interrupts enabled after 0000:00:02.0!

The device is

{pts/2}% lspci -nnv -s 00:02.0
00:02.0 USB Controller [0c03]: ALi Corporation USB 1.1 Controller=20
[10b9:5237] (rev 03) (prog-if 10 [OHCI])
        Subsystem: Toshiba America Info Systems Device [1179:0004]
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at f7eff000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: <access denied>
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

and this does not surprise me at all given all the problems I had with this=
=20
USB controller.

Suspicious is=20

ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI

this controller has history of broken wake up functionality.

Patch follows:

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 670c9d6..e5e9c11 100644
=2D-- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -569,12 +569,14 @@ int device_power_down(pm_message_t state)
        struct device *dev;
        int error =3D 0;

+       WARN_ONCE(!irqs_disabled(), "Interrupts enabled!\n");
        list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
                error =3D suspend_device_noirq(dev, state);
                if (error) {
                        pm_dev_err(dev, state, " late", error);
                        break;
                }
+               WARN_ONCE(!irqs_disabled(), "Interrupts enabled after %s!
\n", de
v_name(dev));
                dev->power.status =3D DPM_OFF_IRQ;
        }
        if (!error)


--nextPart2089579.RIkFXiB8SQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl0yGUACgkQR6LMutpd94xaRwCcD9Qp9iIc8MdkGWVUOWJAVxD8
skYAnAvpN/65ZCRuvi6FTLIezJu5Qm2c
=GzqB
-----END PGP SIGNATURE-----

--nextPart2089579.RIkFXiB8SQ--
