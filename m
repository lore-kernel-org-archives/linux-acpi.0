From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Mon, 04 Sep 2006 22:19:49 -0400
Message-ID: <1157422789.3777.17.camel@localhost.localdomain>
References: <1156884681.1781.120.camel@localhost.localdomain>
	 <20060904125921.GB6279@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from peabody.ximian.com ([130.57.169.10]:705 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965087AbWIECRY
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Sep 2006 22:17:24 -0400
In-Reply-To: <20060904125921.GB6279@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, ACPI ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Arjan van de Ven <arjan@linux.intel.com>

Hi Pavel,

On Mon, 2006-09-04 at 12:59 +0000, Pavel Machek wrote:
> Hi!
> 
> > This patch improves the ACPI c-state selection algorithm.  It also
> > includes a major cleanup and simplification of the processor idle code.
> 
> Nice!
> 
> > @@ -1009,7 +883,7 @@
> >  
> >  	seq_printf(seq, "active state:            C%zd\n"
> >  		   "max_cstate:              C%d\n"
> > -		   "bus master activity:     %08x\n",
> > +		   "bus master activity:     %d\n",
> >  		   pr->power.state ? pr->power.state - pr->power.states : 0,
> >  		   max_cstate, (unsigned)pr->power.bm_activity);
> >  
> 
> This changes kernel - user interface. You should change the field
> description, or keep it in hex...

Good catch!  Essentially the field now counts the number of times bus
master activity was detected, rather than bitshifting.  I'll change its
name in the next iteration.

> 
> BTW will you be on september's labs conference?

It's not currently in my plans, but I'd love to attend one at some
point.

> 
> 							Pavel

Thanks for the comments.

Regards,
Adam


