From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/2] ACPI PM: Add possibility to change suspend
	sequence
Date: Tue, 20 May 2008 00:36:12 +0200
Message-ID: <20080519223612.GA2320@elf.ucw.cz>
References: <200805062342.42789.rjw@sisk.pl> <20080512072301.GC24094@elf.ucw.cz> <200805130034.06604.rjw@sisk.pl> <200805130103.26644.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45045 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbYESWfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 May 2008 18:35:25 -0400
Content-Disposition: inline
In-Reply-To: <200805130103.26644.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> There are some systems out there that don't work correctly with
> our current suspend/hibernation code ordering.  Provide a workaround
> for these systems allowing them to pass the
> 'acpi_sleep=old_ordering' in the kernel command line which will make
> the kernel use the pre-ACPI 2.0 suspend code ordering.
> 
> Unfortunately, that requires us to rework the resuming of devices for
> recovering the platform in case one of the device drivers' .suspend()
> routines returns error code.  Namely, ACPI 1.0 specifies that _PTS
> should be called before suspending devices, but _WAK still should be
> called before resuming them in order to undo the changes made by
> _PTS.  However, if there is an error during suspending devices, they
> are automatically resumed without returning control to the PM core
> and that has to be changed.  For this reason, the high-level suspend
> and hibernation code has to be changed as well and new platform
> callbacks are necessary.
> 
> The patch also reorders and refactors the ACPI suspend/hibernation
> code to avoid duplication as far as reasonably possible.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I like it. ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
