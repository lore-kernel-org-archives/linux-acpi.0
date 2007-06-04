From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Mon, 4 Jun 2007 13:16:10 +0200
Message-ID: <20070604111610.GR4363@elf.ucw.cz>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <200705171842.44134.lenb@kernel.org> <20070521121139.GB8332@elf.ucw.cz> <200705312246.11576.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42296 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752631AbXFDLQR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2007 07:16:17 -0400
Content-Disposition: inline
In-Reply-To: <200705312246.11576.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu 2007-05-31 22:46:11, Len Brown wrote:
> On Monday 21 May 2007 08:11, Pavel Machek wrote:
> > On Thu 2007-05-17 18:42:43, Len Brown wrote:
> > > > Something similar happened to me on XE3, yes.
> > > > 
> > > > (Actual values were different; BIOS specified critical temperature at
> > > > cca 95C, but hw killed the power at cca 83C. Setting critical trip
> > > > point at 80C made the problem go away.)
> > > 
> > > Great, please file a bug and include the acpidump from the XE3
> > > and we'll fix it, rather than supporting a bogus (manual) workaround for it.
> > 
> > It is few years since I do not have that XE3 machine.
> > 
> > > Of course if your system is running at 80*C and the hardware shuts
> > > off at 83*C, you may have a broken fan, or one clogged with dust...
> > 
> > It _did_ have broken fan. It also had broken trip points.
> 
> Thanks for clarifying this, Pavel.
> If you come upon an XE3 where Linux-2.6.22 doesn't work as well
> as Windows, please let me know.

"work as well as windows" is not good enough goal as far as I'm
concerned. Please don't break working setups.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
