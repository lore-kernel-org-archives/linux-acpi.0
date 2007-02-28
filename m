From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: bugzilla.kernel.org bug 7988: Resume from RAM on Toshiba A100 fails
Date: Wed, 28 Feb 2007 11:36:19 +0100
Message-ID: <200702281136.20116.rjw@sisk.pl>
References: <8956d4ca0702210648v43f99a5el53f5a15b2b99a8d1@mail.gmail.com> <200702280120.46036.rjw@sisk.pl> <8956d4ca0702271727g63959d2bk77201c2624aab882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40344 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbXB1KeL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Feb 2007 05:34:11 -0500
In-Reply-To: <8956d4ca0702271727g63959d2bk77201c2624aab882@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mitch Davis <mjd-kernel-org@afork.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, 28 February 2007 02:27, Mitch Davis wrote:
> On 2/28/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, 28 February 2007 01:04, Mitch Davis wrote:
> > > >
> > > >  http://bugzilla.kernel.org/show_bug.cgi?id=7988
> > >
> > > In the bug, Rafael J. Wysocki suggested:
> > > >
> > > > Can you try the latest -mm kernel (but please do not compile it with
> > > > CONFIG_PREEMPT set)?
> > >
> > > I have now tried 2.6.20-mm2, and the result is exactly the same: The laptop
> > > suspends but never gets to first base on resume.
> >
> > I was hoping that the fix might go into -mm.
> >
> > The hardware configuration of your system is very similar to one and the only
> > substantial difference I can see is
> 
> Hi Rafael,
> 
> Sorry, similar to what?  A laptop of yours?

Yes, I've "cut" one part of the sentence, sorry.

> > 00:00.0 Host bridge: ATI Technologies Inc Unknown device 5a31 (rev 01)
> 
> As far as I can tell, this is something in the ATI RS400 Northbridge:
> 
>   http://lxr.linux.no/ident?i=PCI_DEVICE_ID_ATI_RS400_133
> 
> > Does your system suspend to disk?
> 
> I tried suspend2.  I had problems with the laptop hanging at "atomic
> copy".  Others have had the same problem:
> 
>   http://linux-on-laptops.com/forum/archive/index.php/t-295.html

OK

Could you please try to boot with init=/bin/bash and do

# echo 8 > /proc/sys/kernel/printk
# echo disk > /sys/power/state

Please see if that works without the "noapic" .
 
> The solution to that problem was to boot with "noapic".  (suspend2
> works reliably most of the time, but 2G of RAM takes so long to write
> that I want S-T-R to work).
> 
> With "noapic", the RTL8139 ethernet stopped working, so I added
> "acpi=noirq".  Now both suspend2 and ethernet work.
> 
> PCMCIA still doesn't work but I think the link above may be a useful workaround.
> 
> Please, can anyone help me with my resume-after-suspend-to-RAM problem?

I'm trying.

Greetings,
Rafael
