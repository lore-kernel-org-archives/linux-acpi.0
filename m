From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: tg3 ethernet not coming back properly after S3 suspend
	on Dell M70
Date: Fri, 10 Jun 2005 10:45:04 +0800
Message-ID: <1118371504.3930.4.camel@linux-hp.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575023E30BC@pdsmsx402.ccr.corp.intel.com>
	 <9540d0105060911066a4d4867@mail.gmail.com>
	 <1118368773.3860.3.camel@linux-hp.sh.intel.com>
	 <9540d0105060919283b48a35b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9540d0105060919283b48a35b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-06-09 at 19:28 -0700, Vladimir Vukicevic wrote:
> On 6/9/05, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > Please try below patch.
> > 
> > Long, is this patch ok to you? PCIE bridge itself requires to
> > save/restore config space.
> > 
> > Thanks,
> > Shaohua
> > 
> > 
> > --- a/drivers/pci/pcie/portdrv_pci.c    2005-06-08 10:36:05.000000000 +0800
> > +++ b/drivers/pci/pcie/portdrv_pci.c    2005-06-10 09:34:55.760496584 +0800
> > @@ -69,11 +69,16 @@ static void pcie_portdrv_remove (struct
> >  #ifdef CONFIG_PM
> >  static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
> >  {
> > -       return pcie_port_device_suspend(dev, state);
> > +       int ret = pcie_port_device_suspend(dev, state);
> > +       pci_save_state(dev);
> > +       return ret;
> >  }
> > 
> >  static int pcie_portdrv_resume (struct pci_dev *dev)
> >  {
> > +       pci_restore_state(dev);
> > +       pci_enable_device(dev);
> > +       pci_set_master(dev);
> >         return pcie_port_device_resume(dev);
> >  }
> >  #endif
> 
> That patch did the trick!  All the devices seem to come back with
> their config space identical to before the suspend.  I noticed that
> pci_save_state/pci_restore_state only save 64 bytes of state -- I did
> a separate patch before I saw your mail that saved the full size of
> the config space (based on dev->cfg_size) that also fixed things...
> should the full config space size be saved, or is that not necessary?
Great! It's ideal to save/restore full size config, but there is no
standard way to save full size config. Some config spaces can't be
accessed in many cards, like a LPC bridge. They don't follow PCI
standard.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
