From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] x86 ACPI: Fix resume from suspend to RAM on uniprocessor x86-64
Date: Wed, 9 Jul 2008 11:35:05 +0200
Message-ID: <20080709093504.GA10023@ucw.cz>
References: <200807050005.31272.rjw@sisk.pl> <200807050008.30497.Rafal.Wysocki@fuw.edu.pl> <20080705064404.GB12991@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1131 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753224AbYGIOiR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 10:38:17 -0400
Content-Disposition: inline
In-Reply-To: <20080705064404.GB12991@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Dionisus Torimens <djtm@gmx.net>

On Sat 2008-07-05 08:44:04, Ingo Molnar wrote:
> 
> * R. J. Wysocki <Rafal.Wysocki@fuw.edu.pl> wrote:
> 
> > On Saturday, 5 of July 2008, Rafael J. Wysocki wrote:
> > > Hi Ingo,
> > > 
> > > This is a regression fix, please push to Linus ASAP.
> 
> > Reported-by: Dionisus Torimens <djtm@gmx.net>
> 
> applied to tip/x86/urgent - thanks Rafael. I also queued up Peter's "x86 
> ACPI: normalize segment descriptor register on resume" fix.

You can add my acked-by... and sorry for the error.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
