From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Fri, 06 Aug 2004 09:38:27 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4113B403.10700@root.org>
References: <4112814C.2070808@optonline.net> <1091805831.3893.6.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091805831.3893.6.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Thu, 2004-08-05 at 14:49 -0400, Nathan Bryant wrote:
>>The ELCR save/restore patch is causing regressions for some people. What 
>>if the problem is that we're saving/restoring registers at the wrong time?
> 
> 
> On closer investigation, I found that the system was restoring my ioapic
> state /after/ it had started the programmable interrupt timer back up.
> Changing line 310 of drivers/base/sys.c to list_for_each_entry_reverse
> seems to have greatly improved my ability to suspend and resume (which
> worked fine before the interrupt controller suspend/resume patches,
> except that I didn't get many interrupts...) 
> 
> There doesn't seem to be any fine-grained way to control the order of
> suspend/resume for individual drivers. It seems to be assumed that
> everything that devices depend on will be higher than them in the tree,
> and so everything will "just work" - I'm not sure this is true. As
> another example, I just had my wireless card fail to resume correctly.
> It tried to do a hotplug firmware load on resume. Which was difficult,
> because it was resumed before the IDE interface was. How can this sort
> of thing be avoided?

With a real device framework.  We (FreeBSD) propagate suspend requests 
throough our generic device structure.  Each parent and child has a 
method which can be overridden.  This starts at the root and is 
propagated downward.

For instance, the PCI driver has methods that save/restore BARs:
         DEVMETHOD(device_suspend,       pci_suspend),
         DEVMETHOD(device_resume,        pci_resume),

The suspend function does its work and then calls bus_generic_suspend() 
which propagates the request down to the children.  Or if it knows that 
it needs to run after all children have suspended, it calls 
bus_generic_suspend() first, then does its work.

/**
  * @brief Helper function for implementing DEVICE_SUSPEND()
  *
  * This function can be used to help implement the DEVICE_SUSPEND()
  * for a bus. It calls DEVICE_SUSPEND() for each of the device's
  * children. If any call to DEVICE_SUSPEND() fails, the suspend
  * operation is aborted and any devices which were suspended are
  * resumed immediately by calling their DEVICE_RESUME() methods.
  */
int
bus_generic_suspend(device_t dev)
{
         int             error;
         device_t        child, child2;

         TAILQ_FOREACH(child, &dev->children, link) {
                 error = DEVICE_SUSPEND(child);
                 if (error) {
                         for (child2 = TAILQ_FIRST(&dev->children);
                              child2 && child2 != child;
                              child2 = TAILQ_NEXT(child2, link))
                                 DEVICE_RESUME(child2);
                         return (error);
                 }
         }
         return (0);
}

The key helpful thing is that each driver can specify its own methods 
through its device object but they can be called in a generic way.  For 
instance, if the root bus does "device_suspend(pci_dev)", then the 
actual function call expanded at run time is "pci_suspend(pci_dev)"

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
