From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Fri, 06 Aug 2004 11:50:53 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4113A8DD.20609@optonline.net>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Thu, 2004-08-05 at 14:49 -0400, Nathan Bryant wrote:
> 
> 
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

Oh, of course it isn't true. Everyone's just keeping their fingers 
crossed and hoping to avoid moving resume logic into complex special 
cases. But we might have to go there regardless...

In this case, it may make sense to consolidate all 
interrupt-controller-related suspend/resume into a single logical sys 
device so that we'll be sure to get the order right within that module.

Been thinking about this lately. There is some evidence that we may 
eventually need resume drivers for southbridge components. For example, 
my ACPI BIOS doesn't restore the ICH2 LPC bridge's SW_IRQ_GEN register 
on resume, which leads to some benign debug messages that might be 
concerning to some people who didn't know what the real problem is... 
this register is responsible for masking out IRQ1 and/or IRQ12 in 
legacy-free systems.

But if these southbridge components get their callbacks as a pci_driver, 
they might run AFTER various sys devices that are more accurately 
considered children of the south bridge: for example the PIC and the irq 
router.

> another example, I just had my wireless card fail to resume correctly.
> It tried to do a hotplug firmware load on resume. Which was difficult,
> because it was resumed before the IDE interface was. How can this sort
> of thing be avoided?
> 

That's a little more "interesting"...two possibilities
1) find a more generic mechanism to handle these special-case 
dependencies ;) Maybe let drivers register themselves as depending on 
other component classes, and then do a topological sort...
2) move everything that this driver needs to hotplug itself into kernel 
space



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
