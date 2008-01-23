From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] More updates for 2.6.25
Date: Wed, 23 Jan 2008 09:30:10 +0100
Message-ID: <20080123083010.GB11223@elf.ucw.cz>
References: <200801110118.46106.rjw@sisk.pl> <200801152322.33984.lenb@kernel.org> <20080116114446.GB22460@elf.ucw.cz> <200801161337.19070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55083 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750994AbYAWMRJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 07:17:09 -0500
Content-Disposition: inline
In-Reply-To: <200801161337.19070.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed 2008-01-16 13:37:18, Rafael J. Wysocki wrote:
> On Wednesday, 16 of January 2008, Pavel Machek wrote:
> > On Tue 2008-01-15 23:22:33, Len Brown wrote:
> > > On Thursday 10 January 2008 19:18, Rafael J. Wysocki wrote:
> > > > Len,
> > > > 
> > > > Please add the following three patches to the suspend branch.
> > > 
> > > Applied (and suspend branch has been re-based to latest linus tree)
> > 
> > Was that "lets reorder notifications, old order was more logical, but
> > it fixes apm?" series?
> 
> Yes, plus the docs update from Dave Brownell.

Can we stop that reordering? I do not think it is such a good idea.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
