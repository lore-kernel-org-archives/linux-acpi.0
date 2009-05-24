From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before
	entering?S3
Date: Sun, 24 May 2009 23:14:33 +0200
Message-ID: <20090524211433.GB1693@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905231105.03828.oliver@neukum.org> <20090523094518.GB8782@elf.ucw.cz> <200905242302.55640.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55052 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZEXVOi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 May 2009 17:14:38 -0400
Content-Disposition: inline
In-Reply-To: <200905242302.55640.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun 2009-05-24 23:02:55, Oliver Neukum wrote:
> Am Samstag, 23. Mai 2009 11:45:18 schrieb Pavel Machek:
> > suspend.sf.net, program s2both :-).
> 
> Cool. What happens if you crash after unfreezing user space but before you
> declare the image invalid?

I'd have to check the code to make sure, but it should first kill the
image and then unfreeze :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
