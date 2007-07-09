From: David Brownell <david-b@pacbell.net>
Subject: Re: Hibernate after alarm wakes from STR
Date: Mon, 9 Jul 2007 09:26:32 -0700
Message-ID: <200707090926.32826.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200707081944.04598.david-b@pacbell.net> <20070709154014.GF27828@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34495 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758680AbXGIQ0x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 12:26:53 -0400
In-Reply-To: <20070709154014.GF27828@dmt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Richard Hughes <hughsient@gmail.com>, linux-pm@lists.linux-foundation.org, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org

On Monday 09 July 2007, Marcelo Tosatti wrote:
> On Sun, Jul 08, 2007 at 07:44:03PM -0700, David Brownell wrote:

> > Better a /sys/power/wakeup_event (or whatever) that's more easily
> > found.  It could link to the device issuing the event.
> 
> As you mentioned, there might be two wakeup sources (RTC and power
> button for instance) or even more at the same time.

Actually I though I said that there would be races.  Though come
to think of it, one way they'd show up on a typical embedded system
would be to have multiple wake IRQs pending ... you couldn't tell
which one came first.  (The typical case would be a single event,
of course.)  ACPI-ish systems would do that with GPEs and the
magic "rtc woke" flag.

And then there are shared IRQ lines serving as wake sources.  There
could be three wake-enabled devices on that line (plus others that
aren't wake-enabled); the drivers returning IRQ_HANDLED should likely
be reported as having been wake sources, but not the ones returning
IRQ_NONE ...

... so yes, systems might need to present multiple wake events.


> Do you think its fine to simply but the device separated by spaces in
> the wakeup_event file?
> 
> Sounds fine by me, but what about the one-value-per-file sysfs rule?

Better to have that node be a directory of links then, rather than
a single link.

Note that I'm just throwing ideas out there.  I suspect that
in the general case it may not be easy to map from wake event
to device, without infrastructure that's now missing.

- Dave
