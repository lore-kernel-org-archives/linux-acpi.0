From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: 03 Aug 2004 22:55:55 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091588154.2297.43.camel@dhcppc4>
References: <B44D37711ED29844BEA67908EAF36F037BB9C6@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F037BB9C6-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stefan D?singer <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Shaohua,
pci=noacpi and acpi=noirq are boot workarounds --
not full-featured supported configurations -- YMMV!
We don't even guarantee that the ACPI SCI
will work with these configurations.
So I think we should spend 0 effort to support ACPI suspend/resume
in configurations where ACPI is partially disabled.

Sorry if this contradicts what I said yesterday,
I think I wasn't thinking clearly then.

thanks,
-Len


On Tue, 2004-08-03 at 22:36, Li, Shaohua wrote:
> Nathan,
> I agree your patch should be ok for the special case, but it's not
> sufficient. Please note a Link device is just an abstraction of PCI
> router, which possibly is in ICH. If we use pci=noacpi or acpi=noirq, we
> don't use link device but still use the router and may also change the
> sets of the router (look at i386/pci/irq.c) and so still fail after S3.
> Your patch can't handle this situation. This indicates adding
> suspend/resume code in pci_link.c is not a good idea. Generic solution
> should be to provide LPC driver.
> 
> Thanks,
> Shaohua
> 
> >-----Original Message-----
> >From: Nathan Bryant [mailto:nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org]
> >Sent: Wednesday, August 04, 2004 9:43 AM
> >To: Brown, Len
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Linux Kernel list; Li, Shaohua;
> >Stefan D?singer
> >Subject: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
> >
> >
> >This patch should fix multiple user-visible problems with the ACPI IRQ
> >routing after S3 resume:
> >
> >"irq x: nobody cared"
> >"my interrupts are gone"
> >
> >It probably applies to multiple bugzilla entries and mailing list
> posts.
> >
> >Tested on my machine, which is experiencing similar problems. Seems to
> >work - although I get some non-fatal "nobody cared" messages that might
> >be caused by the i8042 driver.
> >
> >Comments?
> >Stefan, can you test this?



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
