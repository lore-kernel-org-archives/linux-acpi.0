From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Wed, 20 Jun 2007 18:30:51 -0700
Message-ID: <200706201830.52277.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200704011728.10966.david-b@pacbell.net> <20070619170048.GA342@dmt.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:45996 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753856AbXFUBtK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jun 2007 21:49:10 -0400
In-Reply-To: <20070619170048.GA342@dmt.media.mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org

On Tuesday 19 June 2007, Marcelo Tosatti wrote:
>
> > Since OLPC isn't using ACPI,  it can be more like embedded Linux,
> > and just Do The Right Thing ... create platform devices, etc.  :)
> 
> As you know we want user configuration of enabled wakeup events (unlike
> embedded platforms where this is hardcoded). It seems that the current
> interface available for that is /sys/devices/../power/wakeup hook (when
> !ACPI).

And, when some issues get sorted, for ACPI too.  Patches have circulated
which make it all behave properly ... except for some platform-specific
oddities that haven't gotten sorted out yet.  (As I recall, there was
one instance of the "EHCI wrongly issues wakeups" problems; and then the
mess with PCI init sequence on powerpc vs most other systems.)


> However there are several wakeup capable devices in OLPC which do not
> have drivers, thus no platform devices:
> 
> - power button 
> - lid
> 
> It seems that creating platform devices for these two just for the
> purpose of a having an interface for enabling wakeup events is overkill.

What Jens said.  ;)  

I'll disagree.  Not just because ACPI already creates devices for
those two cases, but because creating normal device nodes there is
the Right Thing To Do.  It's cheap, and won't surprise anyone. 


> Given that, we probably want something similar to what was initially    
> described in http://wiki.laptop.org/go/Power_Management_Interface ?     
> 
> The downside of doing that is a non-unified interface: platform
> devices via /sys/devices/../power/wakeup and otherwise
> /sys/whatever/wakeup/source?

That's exactly why "we" do *NOT* want something like what was
sketched in that Wiki.  Gratuitous divergence hurts ... and in
this case, it's trivial to adopt that common solution (just add
platform device, managed the usual way) and not diverge.

- Dave

