From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ibm-acpi bay and acpi generic bay convergence
Date: Mon, 19 Mar 2007 21:25:18 -0300
Message-ID: <20070320002518.GG5932@khazad-dum.debian.net>
References: <20070315220414.GC15572@khazad-dum.debian.net> <20070317192429.GA6508@khazad-dum.debian.net> <20070319113219.0ca52dd8.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53885 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030782AbXCTAZo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 20:25:44 -0400
Content-Disposition: inline
In-Reply-To: <20070319113219.0ca52dd8.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

On Mon, 19 Mar 2007, Kristen Carlson Accardi wrote:
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > So the first step is to improve is_ejectable_bay.  What reason did you have
> > to limit it only to devices where is_ata returns true?  Is there a reason
> > why anything that is not a dock and is ejectable should not be handled as a
> > bay ?
> 
> The only reason the generic bay driver is limited to only ata devices is
> simply because that's all I decided to implement for the first revision
> of the driver.  So, the perfect time to expand is now :).
> 
> Yes - there's a reason why we can't just blindly claim anything ejectable
> that isn't a dock.  PCI Hotplug for example.  What I think would be
> ideal would be if the bay driver could register for events on anything
> ejectable iff no other driver has claimed them.  I couldn't find an easy
> way to do this last time I checked (months ago).  Seems like we might have
> to change the way ACPI notifications are sent - I was hoping they could be
> changed to be more like interrupts - so that you could have a return code
> from the notification call that indicates whether the driver handled the
> event or not - and allow multiple drivers to register for the same event.
> This would also make it possible to eliminate weird stuff like what I'm doing
> with the dock driver to allow the bay driver to get dock notifications -
> the bay driver could just check to see if it's dependent on another object
> using _EJD and then request events on that object as well.

I like this idea quite a lot.  Only, we probably need to not only support a
"walk until someone consumes the event" chain, but also a "notify every
interested party that an event has happened and was consumed/was not
consumed" functionality.  You also may wany the "consume event" chain to
understand priorities when inserting drivers in it, so that you can be a
"well, if nobody else wants it..." consumer or a "me! me! me!" consumer.

It is not complete (it doesn't allow ibm-acpi to talk to bay and dock
without using module dependencies for example), but it is quite a good
start.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
