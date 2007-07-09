From: David Brownell <david-b@pacbell.net>
Subject: Re: Hibernate after alarm wakes from STR
Date: Sun, 8 Jul 2007 19:44:03 -0700
Message-ID: <200707081944.04598.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200707081315.40560.david-b@pacbell.net> <20070708223121.GB4964@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:48906 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758370AbXGICoI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2007 22:44:08 -0400
In-Reply-To: <20070708223121.GB4964@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org

On Sunday 08 July 2007, Marcelo Tosatti wrote:
> On Sun, Jul 08, 2007 at 01:15:40PM -0700, David Brownell wrote:
> > On Sunday 08 July 2007, Richard Hughes wrote:
> > 
> > That is, we may want to provide a bit more information about the
> > specific event which triggered wakeup.  I don't believe there is
> > such an interface, in general.
> 
> What would be a nice interface? Perhaps an additional file under
> /sys/devices/.../power/wakeup_fired or something (only for devices with
> can_wakeup set).

Better a /sys/power/wakeup_event (or whatever) that's more easily
found.  It could link to the device issuing the event.


> > Plus, the notion seems kind of racey to me.  (If you press a key
> > right while the wakealarm fires, you don't want hibernation..)
> 
> Then you check if the any key or other wakeup event has happened other
> than RTC... I don't see any problem with that.

It might be best not to need to re-activate the whole system from
STR though ... it ought to be possible to just power off, having
already written the image to disk.  Right?

Yes, there's all that stuff about how to quiesce the system properly,
freezer/icebox/flamesuits/etc.  Regardless, going from STR to fully
operational and then hibernating would take time and energy that
might not be available...

- Dave


> > > Is this something we can do (or should do) for OLPC and general ACPI?
> > 
> > I'd certainly rather see laptops doing that than what they do now:
> > running the battery out, and needing filesystem recovery!!
> 
> Yep.
> 


