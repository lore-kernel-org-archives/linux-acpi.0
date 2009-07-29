From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Wed, 29 Jul 2009 17:05:24 +0200
Message-ID: <20090729150524.GD1534@ucw.cz>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com> <1247574573.23871.8.camel@dax.rpnet.com> <1247644518.26272.88.camel@rzhang-dt> <1247646153.6248.3.camel@dax.rpnet.com> <1247647105.26272.99.camel@rzhang-dt> <1247649089.20241.5.camel@dax.rpnet.com> <20090715135808.GA19054@srcf.ucam.org> <1247711974.26272.190.camel@rzhang-dt> <20090716024057.GA2461@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54032 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbZG2PF2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 11:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20090716024057.GA2461@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "corentincj@iksaif.net" <corentincj@iksaif.net>


> > > You want smoothing even in a default policy, and doing that well might 
> > > be a bit much for the kernel?
> > > 
> > sorry, I don't understand.
> > do you mean that there should be a default policy in the kernel?
> 
> No, I mean that the only default policy you could reasonably have in the 
> kernel would be tying the backlight directly to the ALS. And that sucks. 
> You need some degree of smoothing, and that's a job better left to 
> userspace.

How would that be done? Wake up userspace 100times a second so it can
read an integer and ardd it to running average?

Is ALS device stupid sensor, or can it do some smoothing/watermarks
itself?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
