From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: 2.6.29-rc6-git7: Reported regressions from 2.6.28
Date: Sat, 04 Apr 2009 03:40:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904040339470.16220@localhost.localdomain>
References: <KiHv0irKPzE.A.l3.hUarJB@chimera>
 <1236129688.32297.264.camel@rzhang-dt> <200903072312.30158.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <200903072312.30158.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Natalie Protasevich <protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 7 Mar 2009, Rafael J. Wysocki wrote:

> On Wednesday 04 March 2009, Zhang Rui wrote:
> > On Wed, 2009-03-04 at 03:22 +0800, Rafael J. Wysocki wrote:
> > 
> > > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=12758
> > > Subject         : ACPI exception with 2.6.29-rc6
> > > Submitter       : Heinz Diehl <htd-HjJ2MNWy62to6+H+lsi3Gti2O/JbrIOy@public.gmane.org>
> > > Date            : 2009-02-23 16:46 (9 days old)
> > > References      : http://marc.info/?l=linux-kernel&m=123540758700861&w=4
> > > 
> > Handled by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Patch-available:
> > http://bugzilla.kernel.org/attachment.cgi?id=20368&action=view
> > 
> > not sure if this patch is in len's tree or not.
> 
> Thanks, updated.


per the bug report, this shipped in 2.6.29-rc8:

commit 7b46ecd5fcebf381a7bde966db352d8fb1b8e944
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Feb 25 18:00:18 2009 -0500

    Revert "ACPI: make some IO ports off-limits to AML"
