From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] Asynchronous suspend/resume - test results
Date: Sun, 27 Dec 2009 15:20:08 +0100
Message-ID: <200912271520.08521.rjw@sisk.pl>
References: <200912210140.19713.rjw@sisk.pl> <200912262233.45626.rjw@sisk.pl> <4B36882D.5070002@crca.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59827 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZL0OTm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Dec 2009 09:19:42 -0500
In-Reply-To: <4B36882D.5070002@crca.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Saturday 26 December 2009, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > Yes, it did.  Please compare these lines:
> > 
> > (from the "sync" dmesg):
> > [   31.640676] PM: freeze of devices complete after 709.277 msecs
> > [   37.087548] PM: restore of devices complete after 4973.508 msecs
> > 
> > (from the "async" dmesg):
> > [   25.600067] PM: freeze of devices complete after 620.429 msecs
> > [   29.195366] PM: restore of devices complete after 3057.982 msecs
> > 
> > So clearly, there's a difference. :-)
> 
> Oh okay.
> 
> It still feels like a long time. How do I find out which device took the
> longest? It looks to me like the patch is only recording when things
> start their restore, not when they finish.

First, you need to boot with initcall_debug in the kernel command line.

Then, after a hibernate-resume cycle do something like this:

$ dmesg | grep "call .* returned " | awk '{print $8 "\t" $4;}' | sort -nr

That will give you both the suspend and resume times for all devices,
sorted in the decreasing order.

If you want to separate suspend times from resume times, you generally need
to save the dmesg output and cut everything except for the interesting part
(eg. device suspend) from it.  Then you'll get the times by running the above
command.
 
> > Of course, in terms of total hibernate/restore time this is only a little
> > improvement, but if that was suspend to RAM and resume, the reduction of
> > the device resume time by almost 2 s would be a big deal.
> > 
> >> I'll see if I can find the time to do the other computers, then.
> > 
> > I'd appreciate that very much.
> 
> I'm not sure I'll find the time now - it's Sunday morning here and we
> still have packing and so on to do after I take this morning's service.
> 
> Sorry!

No problem at all. :-)

Rafael
