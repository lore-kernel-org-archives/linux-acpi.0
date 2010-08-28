From: Pavel Machek <pavel@ucw.cz>
Subject: Re: BUG: scheduling while atomic
Date: Sat, 28 Aug 2010 08:42:54 +0200
Message-ID: <20100828064254.GA2128@elf.ucw.cz>
References: <20100827075911.GA5966@swordfish.minsk.epam.com>
 <201008272102.52041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:57129 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750907Ab0H1GnC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Aug 2010 02:43:02 -0400
Content-Disposition: inline
In-Reply-To: <201008272102.52041.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri 2010-08-27 21:02:51, Rafael J. Wysocki wrote:
> On Friday, August 27, 2010, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > .36-rc2-git4
> 
> Well, that looks like an ACPI battery driver issue.
> 
> What was the last know good kernel?

Also you might want to see if unloading battery driver before hibernation
allows you do proceed...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
