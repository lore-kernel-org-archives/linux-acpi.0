From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Tue, 22 May 2007 00:42:00 +0200
Message-ID: <20070521224200.GF10714@elf.ucw.cz>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <200705171517.14087.lenb@kernel.org> <1179604609.16465.83.camel@sublime.suse.de> <200705202350.45145.lenb@kernel.org> <20070521121048.GA8332@elf.ucw.cz> <20070521132711.GA7540@srcf.ucam.org> <20070521132948.GD8332@elf.ucw.cz> <20070521133608.GB7540@srcf.ucam.org> <20070521134046.GE8332@elf.ucw.cz> <20070521134553.GA7911@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43984 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756020AbXEUWmI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 18:42:08 -0400
Content-Disposition: inline
In-Reply-To: <20070521134553.GA7911@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, trenn@suse.de, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

On Mon 2007-05-21 14:45:53, Matthew Garrett wrote:
> On Mon, May 21, 2007 at 03:40:46PM +0200, Pavel Machek wrote:
> > On Mon 2007-05-21 14:36:08, Matthew Garrett wrote:
> > > On Mon, May 21, 2007 at 03:29:48PM +0200, Pavel Machek wrote:
> > > > Significantly more correct? It forces you to do all the thermal
> > > > management in userspace!
> > > 
> > > Why's that a problem? 
> > 
> > Duplicating all the kernel logic in userspace, badly?
> 
> So don't do it badly. The advantage of doing so is that you can make it 
> work properly, which you can't by putting it in the kernel.

You want stuff like critical shutdowns to work even if userspace is
dead.

I do not think you can control passive cooling adequately from
userspace, and you can certainly not prevent kernel from slowing
machine down too soon.

Plus, this is actually nasty user-visible change, and a regression
from 2.6.21. I am not sure why we are even debating this; user-kernel
interface changed without warning. Patch should be simply reverted.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
