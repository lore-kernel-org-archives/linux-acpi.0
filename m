From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] eeepc-laptop: fix wlan rfkill state
	change during init
Date: Sun, 29 Mar 2009 22:55:11 +0100
Message-ID: <20090329215511.GE13446@srcf.ucam.org>
References: <49CFADDF.4040007@tuffmail.co.uk>
	<71cd59b00903291416o4e8d6013n8a061098bb4fabef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <71cd59b00903291416o4e8d6013n8a061098bb4fabef-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 29, 2009 at 11:16:25PM +0200, Corentin Chary wrote:
> On Sun, Mar 29, 2009 at 7:20 PM, Alan Jenkins
> <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org> wrote:
> > When an rfkill device is registered, the rfkill core will change its
> > state to the system default. So we need to prepare for state changes
> > *before* we register it. That means installing the eeepc-specific ACPI
> > callback which handles the hotplug of the wireless network adaptor.
> >
> > This problem doesn't occur during normal operation. =A0You have to
> >
> > 1) Boot with wireless enabled. eeepc-laptop should load automatically.
> > 2) modprobe -r eeepc-laptop
> > 3) modprobe eeepc-laptop
> >
> > On boot, the default rfkill state will be set to enabled.
> > With the current core code, step 2) will disable the wireless.
> > Therefore in step 3), the wireless will change state during registratio=
n,
> > from disabled to enabled. =A0But without this fix, the PCI device for t=
he
> > wireless adaptor will not appear.
> >
> > Signed-off-by: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
> >
> > diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86=
/eeepc-laptop.c
> > index 786ed86..b8951b9 100644
> > --- a/drivers/platform/x86/eeepc-laptop.c
> > +++ b/drivers/platform/x86/eeepc-laptop.c
> > @@ -645,6 +645,9 @@ static int eeepc_hotk_add(struct acpi_device *devic=
e)
> > =A0 =A0 =A0 =A0if (ACPI_FAILURE(status))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(EEEPC_ERR "Error installing notif=
y handler\n");
> >
> > + =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
> > + =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
> > +
> > =A0 =A0 =A0 =A0if (get_acpi(CM_ASL_WLAN) !=3D -1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ehotk->eeepc_wlan_rfkill =3D rfkill_allo=
cate(&device->dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RFKILL_TYPE_WLAN);
> > @@ -700,9 +703,6 @@ static int eeepc_hotk_add(struct acpi_device *devic=
e)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bluetooth_fail;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
> > - =A0 =A0 =A0 eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
> > -
> > =A0 =A0 =A0 =A0return 0;
> >
> > =A0bluetooth_fail:
> >
> >
> >
> =

> Hi,
> Cc'd linux-acpi to get more review about that.
> I'm not very familiar with rfkill interface.

Looks fine to me.

Acked-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

-- =

Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

---------------------------------------------------------------------------=
---
