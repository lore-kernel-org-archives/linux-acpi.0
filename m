From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] hmat: Register attributes for memory hot add
Date: Thu, 11 Apr 2019 09:00:57 -0600
Message-ID: <20190411150057.GA7247@localhost.localdomain>
References: <20190409214415.3722-1-keith.busch@intel.com>
 <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Brice Goglin <Brice.Goglin@inria.fr>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 11, 2019 at 04:42:45PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 9, 2019 at 11:42 PM Keith Busch <keith.busch@intel.com> wrote:
> > -static __init void hmat_register_targets(void)
> > +static void hmat_register_targets(void)
> >  {
> >         struct memory_target *target;
> >
> >         list_for_each_entry(target, &targets, node) {
> > +               if (!node_online(pxm_to_node(target->memory_pxm)))
> > +                       continue;
> > +
> >                 hmat_register_target_initiators(target);
> >                 hmat_register_target_perf(target);
> > +               target->registered = true;
> >         }
> >  }
> >
> > +static int hmat_callback(struct notifier_block *self,
> > +                        unsigned long action, void *arg)
> > +{
> > +       struct memory_notify *mnb = arg;
> > +       int pxm, nid = mnb->status_change_nid;
> > +       struct memory_target *target;
> > +
> > +       if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> > +               return NOTIFY_OK;
> > +
> > +       pxm = node_to_pxm(nid);
> > +       target = find_mem_target(pxm);
> > +       if (!target || target->registered)
> > +               return NOTIFY_OK;
> > +
> > +       hmat_register_target_initiators(target);
> > +       hmat_register_target_perf(target);
> > +       target->registered = true;
> > +
> > +       return NOTIFY_OK;
> > +}
> 
> This appears to assume that there will never be any races between the
> two functions above.
> 
> It this guaranteed to be the case?

The hmat_init() will call this directly before registering the memory
notifier callback, so those two paths should be 'ok'.

I may have assumed memory notification callbacks were single threaded,
but after taking a quick look, I think I do need additional locking for
this to be safe. I'll get that fixed up, thanks for the catch.
