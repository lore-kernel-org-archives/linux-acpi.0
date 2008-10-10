From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc8: throttling broken
Date: Fri, 10 Oct 2008 23:35:18 +0200
Message-ID: <20081010213518.GB15285@elf.ucw.cz>
References: <20081009171238.GB1370@ucw.cz> <200810092327.26301.rjw@sisk.pl> <1223601125.3990.4.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56097 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764004AbYJJVdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 17:33:40 -0400
Content-Disposition: inline
In-Reply-To: <1223601125.3990.4.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jikos@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@ucw.cz, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri 2008-10-10 09:12:05, Zhao Yakui wrote:
> On Thu, 2008-10-09 at 23:27 +0200, Rafael J. Wysocki wrote:
> > On Thursday, 9 of October 2008, Pavel Machek wrote:
> > > Hi!
> > > 
> > > On 2.6.27-rc8 on via/fic subnotebook, throttling seems to be broken. I
> > > can do echo 15 > /proc/acpi/processor/*/throttling, and proc file
> > > reflects new value, but cpu still runs at same speed.
> > > 
> > > It worked on opensuse11/sled10 kernels at least...
> After echo 15 > /proc/acpi/processor/*/throttling, what T-state is
> displayed by cat /proc/acpi/processor/*/throttling?

IIRC that worked correctly. I.e. "*" moved to T15.

> If you do the above test on the 2.6.26.x kernel, what T-state is
> displayed ?

Throttling seems to work there and T15 is correctly marked by "*".

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
