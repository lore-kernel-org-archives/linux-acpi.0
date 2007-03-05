From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Mon, 5 Mar 2007 22:25:48 +0000
Message-ID: <20070305222548.GA4946@ucw.cz>
References: <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2485 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751552AbXCEWZ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2007 17:25:59 -0500
Content-Disposition: inline
In-Reply-To: <20070303105316.d51e032d.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi!

> > > Why would we end up with an overestimation if we check the I/O ports at
> > > boot time? Do you have concrete cases in mind?
> > 
> > ACPI will often describe large operation regions, but won't necessarily 
> > touch all of them. Effectively, every codepath would have to be walked 
> > through at boot time and checked for io access.
> 
> Is there anything preventing us from doing such a walk and pre-allocate
> all the I/O ranges? I am not familiar with the ACPI code at all, would
> you possibly propose a patch doing that?

ACPI AML is probably turing-complete: I'm afraid you are trying to
solve the halting problem (-> impossible).
						Pavel

> 
> If we can't do that, the overestimation approach might still work. I
> wonder if it would cause problems in practice. If it does, we're back
> to Pavel's AML lock.
> 
> -- 
> Jean Delvare

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
