From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10 update 2x] PM: Measure suspend and resume times for individual devices
Date: Sun, 6 Sep 2009 14:13:43 +0200
Message-ID: <200909061413.43683.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org> <200909042356.59024.rjw@sisk.pl> <20090906044440.GA29963@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47592 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbZIFMNQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Sep 2009 08:13:16 -0400
In-Reply-To: <20090906044440.GA29963@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>

On Sunday 06 September 2009, Ingo Molnar wrote:
> 
> Thanks Rafael, the code looks a lot more natural IMHO.
> 
> this bit:
> 
> > +#ifdef DEBUG
> > +static void dbg_get_time(struct timeval *start)
> > +{
> > +	do_gettimeofday(start);
> > +}
> 
> is a plain wrapper over gettimeofday so you might want to inline 
> it. (although GCC will do it too most of the time)

I have a rule of not using 'inline' except for in headers.  In this case,
however, it's almost like a header, so I'll follow your suggestion.

Thanks,
Rafael
