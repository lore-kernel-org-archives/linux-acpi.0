From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Sat, 23 Feb 2008 12:17:49 +0100
Message-ID: <20080223111749.GB31098@elte.hu>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802211302.27002.jesse.barnes@intel.com> <b6a2187b0802211620q47f6601fuf7e88395d89b90c8@mail.gmail.com> <200802211623.55450.jesse.barnes@intel.com> <b6a2187b0802211642i17730ccav6744b614c086df72@mail.gmail.com> <20080222103727.GA25781@srcf.ucam.org> <20080222130615.GA29123@elte.hu> <20080222180132.GA32623@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:32824 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYBWLSR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Feb 2008 06:18:17 -0500
Content-Disposition: inline
In-Reply-To: <20080222180132.GA32623@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Linus Torvalds <torvalds@linux-foundation.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org


* Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> We've got i915 suspend/resume now, which already fixes this for a 
> large number of users. Recent ATI is easy, now that we actually have 
> specs for ATOM. The nouveau guys are almost at the point where we can 
> do it for nvidia. That basically just leaves VIA.
> 
> The other s2r issues are pretty much just driver bugs at this point.

ok - sounds good :-)

	Ingo
