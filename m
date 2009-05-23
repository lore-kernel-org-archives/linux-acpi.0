From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before
	entering?S3
Date: Sat, 23 May 2009 11:45:18 +0200
Message-ID: <20090523094518.GB8782@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905230959.23018.oliver@neukum.org> <20090523085018.GA8782@elf.ucw.cz> <200905231105.03828.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51072 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZEWJpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 May 2009 05:45:24 -0400
Content-Disposition: inline
In-Reply-To: <200905231105.03828.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi!

> > That will of course be less. 30 hours is really best case, on "good"
> > notebook.
> >
> > What I was trying to point out is that even if you go into s3 with
> > machine fully charged, you'll loose your data after like 30 hours.
> 
> OK, I see so this was an argument for syncing. Sorry for
> misunderstanding.

Yes; we need to sync.

> But we'd still loose RAM. Which makes me wonder whether S3 and STD
> really need to be mutually exclusive. Couldn't we write a snapshot to disk
> just in case. All it would take is the STR code to mark the snapshot invalid
> before any alteration of the filesystems.

suspend.sf.net, program s2both :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
