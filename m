From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused
Date: Fri, 19 Dec 2008 13:39:34 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812191337160.3745@localhost.localdomain>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
 <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
 <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
 <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:39989 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYLSSjg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 13:39:36 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KC4007V8ZTZOQ02@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 12:39:35 -0600 (CST)
In-reply-to: <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-acpi@vger.kernel.org


> >  drivers/acpi/pci_link.c |   11 -----------
> >  1 files changed, 0 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index 595b131..0f7722d 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -693,18 +693,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
> >                printk(KERN_ERR PREFIX "Link isn't initialized\n");
> >                return -1;
> >        }
> > -#ifdef FUTURE_USE
> > -       /*
> > -        * The Link reference count allows us to _DISable an unused link
> > -        * and suspend time, and set it again  on resume.
> > -        * However, 2.6.12 still has irq_router.resume
> > -        * which blindly restores the link state.
> > -        * So we disable the reference count method
> > -        * to prevent duplicate acpi_pci_link_set()
> > -        * which would harm some systems
> > -        */
> >        link->refcnt--;
> > -#endif
> >        ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                          "Link %s is dereferenced %d\n",
> >                          acpi_device_bid(link->device), link->refcnt));
> > --
> 
> maybe could have one switch in /proc so could not disable that for
> some kexec path...

I fail to comprehend the benefits of kexec,
and the requirements that kexec puts on the kernel, other than:

# CONFIG_KEXEC is not set

-- Len Brown, Intel Open Source Technology Center
