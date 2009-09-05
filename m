From: Olaf Dabrunz <Olaf.Dabrunz@gmx.net>
Subject: Re: [RFC][PATCH 2/2] disable boot interrupts on Intel X58 and 55x0
Date: Sat, 5 Sep 2009 18:18:52 +0200
Message-ID: <20090905161852.GA19706@santana.dyndns.org>
References: <20090904165525.26294.31112.sendpatchset@t500> <20090904165545.26294.94612.sendpatchset@t500> <1252084019.22928.39.camel@desktop> <4AA22A6F.30003@redhat.com> <1252162040.6877.7.camel@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752292AbZIEQVR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Sep 2009 12:21:17 -0400
Content-Disposition: inline
In-Reply-To: <1252162040.6877.7.camel@desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Stefan Assmann <sassmann@redhat.com>, linux-kernel@vger.kernel.org, jcm@redhat.com, sdietrich@novell.com, linux-acpi@vger.kernel.org, andi@firstfloor.org, hpa@zytor.com, mingo@elte.hu, Olaf.Dabrunz@gmx.net, ktokunag@redhat.com, tglx@linutronix.de, lenb@kernel.org

On 05-Sep-09, Daniel Walker wrote:
> On Sat, 2009-09-05 at 11:07 +0200, Stefan Assmann wrote:
> > On 04.09.2009 19:06, Daniel Walker wrote:
> > > On Fri, 2009-09-04 at 12:55 -0400, Stefan Assmann wrote:
> > >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_QPI_TBG15,  quirk_disable_intel_tylersburg_boot_interrupt);
> > >> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,  PCI_DEVICE_ID_INTEL_QPI_TBG15,  quirk_disable_intel_tylersburg_boot_interrupt);
> > > 
> > > 
> > > These lines are wildly long .. Could you reduce these down to a max of
> > > 80 characters..
> > 
> > Hi Daniel,
> > 
> > you're right about the lines being to long, however if you take a peek
> > at drivers/pci/quirks.c you'll see that all the quirks are done this
> > way. :)
> 
> I looked, the whole thing is a mess .. Really all these lines need to be
> cleaned up.. It doesn't help to have you add more to it tho. Especially
> the tab's or spaces between the commas, I can say I understand why that
> is.. If there is a good reason why it's like that I'm all ears..

It makes adding/deleting/modifying the entries easier, with one-line
editor operations. And if all data for one ID-to-quirk relationship is
on one line, with tabs to make for nice columns, I can more easily see
which device is linked to which quirk. That is why I usually prefer one
line per entry. And the entries in quirks.c are long, but not too long
for that IMHO.

I agree that the 80 columns restriction is a good thing in almost all
cases, as it limits the amount of information that is put on a single
line, and it limits the number of indentation levels within a function.

But in this case I think we are better off with one line per entry, even
if the line becomes longer than 80 characters. The information on one
line is not that much (one macro with 3 parameters), only the
identifiers try to be readable and discernible and therefore become
long.

So this will only be a problem for terminals that are limited to 80
rows, and I do not think that anyone is that restricted nowadays.

Regards,

-- 
Olaf Dabrunz (Olaf.Dabrunz <at> gmx.net)

