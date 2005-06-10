From: "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: tg3 ethernet not coming back properly after S3 suspendon Dell M70
Date: Fri, 10 Jun 2005 06:23:53 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408DF0320@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, June 09, 2005 7:45 PM Shaohua Li wrote:
> On Thu, 2005-06-09 at 19:28 -0700, Vladimir Vukicevic wrote:
> > On 6/9/05, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > Please try below patch.
> > >=20
> > > Long, is this patch ok to you? PCIE bridge itself requires to
> > > save/restore config space.
> > >=20
> > > Thanks,
> > > Shaohua
> > >=20
> > >=20
> > > --- a/drivers/pci/pcie/portdrv_pci.c    2005-06-08
10:36:05.000000000 > > > +0800
> > > +++ b/drivers/pci/pcie/portdrv_pci.c    2005-06-10
09:34:55.760496584 > > > +0800
> > > @@ -69,11 +69,16 @@ static void pcie_portdrv_remove (struct
> > >  #ifdef CONFIG_PM
> > >  static int pcie_portdrv_suspend (struct pci_dev *dev,
pm_message_t=20
> > > state)
> > > {
> > > -       return pcie_port_device_suspend(dev, state);
> > > +       int ret =3D pcie_port_device_suspend(dev, state);
> > > +       pci_save_state(dev);
> > > +       return ret;
> > >  }
> > >
> > > static int pcie_portdrv_resume (struct pci_dev *dev)
> > > {
> > > +       pci_restore_state(dev);
> > > +       pci_enable_device(dev);
> > > +       pci_set_master(dev);
> > >        return pcie_port_device_resume(dev);
> > > }
> > > #endif
> > >
> > That patch did the trick!  All the devices seem to come back with
> > their config space identical to before the suspend.  I noticed that
> > pci_save_state/pci_restore_state only save 64 bytes of state -- I
did
> > a separate patch before I saw your mail that saved the full size of
> > the config space (based on dev->cfg_size) that also fixed things...
> > should the full config space size be saved, or is that not
necessary?
> Great! It's ideal to save/restore full size config, but there is no
> standard way to save full size config. Some config spaces can't be
> accessed in many cards, like a LPC bridge. They don't follow PCI
> standard.

This patch is great!

Thanks,
Long


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
