From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Fri, 27 Oct 2006 10:40:52 +0200
Message-ID: <20061027084052.GC1831@elf.ucw.cz>
References: <453F77D4.2080706@linux.intel.com> <200610270122.34846.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47017 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965254AbWJ0Ik6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 04:40:58 -0400
Content-Disposition: inline
In-Reply-To: <200610270122.34846.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Hi!

> > There is a problem with swsuspend and GPE events.
> > Now they are restored from acpi_pm_finish(), which is called only if we
> > suspend with "platform" option, what means that if we suspended to disk
> > with the default "shutdown" option after resume all the GPEs will be disabled.
> > This presents us with the overheating problem after resume at very least.
> 
> > I see two solutions: one is to make "platform" to be default option if ACPI is enabled,
> > and second -- enable GPE events from some other function, which will be called in any case.
> 
> We need to do both.
> 
> "platform" needs to be the default on ACPI-enabled platforms because
> when "shutdown" is used, wakeup devices that function from S4
> but fail to function from S5 are unavailable.
> 
> Further, if somebody chooses to use "shutdown", certainly GPEs
> need to work when they resume.

Agreed. And rafael's patch is good step forward (in making "platform"
default). Time to push it to akpm?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
