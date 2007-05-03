From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 00:27:02 +0200
Message-ID: <20070503222702.GC13426@elf.ucw.cz>
References: <200705032201.49071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45324 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1767449AbXECW1K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 18:27:10 -0400
Content-Disposition: inline
In-Reply-To: <200705032201.49071.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hi!

> I've got two questions regarding the implementation of the ACPI poweroff/sleep
> code in drivers/acpi/sleep and drivers/acpi/hardware .
> 
> 1) We don't seem to use the _TTS system-control method, although the ACPI
> specification (ACPI 3.0b) says that this method should be used for intiating
> and finishing power transitions.  Could you please tell me why we
> don't use it?

I guess we simply overlooked that :-(.

> 2) In the functions acpi_enter_sleep_state_prep(), acpi_enter_sleep_state(),
> acpi_leave_sleep_state() we manipulate GPEs quite extensively (we disable
> and enable them for a couple of times during a transition), although the
> specification doesn't tell anything about that explicitly.  Could you please
> explain to me what the purpose of that is?

We have had some notebooks auto-waking-up just after suspend. Perhaps
those hacks are workarounds for that problem?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
