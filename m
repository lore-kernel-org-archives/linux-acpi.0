From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc8: throttling broken
Date: Fri, 10 Oct 2008 23:34:27 +0200
Message-ID: <20081010213427.GA15285@elf.ucw.cz>
References: <20081009171238.GB1370@ucw.cz> <200810092327.26301.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56091 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761063AbYJJVcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 17:32:50 -0400
Content-Disposition: inline
In-Reply-To: <200810092327.26301.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jikos@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@ucw.cz, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu 2008-10-09 23:27:25, Rafael J. Wysocki wrote:
> On Thursday, 9 of October 2008, Pavel Machek wrote:
> > Hi!
> > 
> > On 2.6.27-rc8 on via/fic subnotebook, throttling seems to be broken. I
> > can do echo 15 > /proc/acpi/processor/*/throttling, and proc file
> > reflects new value, but cpu still runs at same speed.
> > 
> > It worked on opensuse11/sled10 kernels at least...
> 
> Any chance to check 2.6.26.x on that?

2.6.26 seems to be okay, and my thinkpad seems to be okay, too...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
