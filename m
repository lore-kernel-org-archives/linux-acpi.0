From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 20:59:10 +0200
Message-ID: <20070621185910.GH18481@elf.ucw.cz>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706211442.41140.rjw@sisk.pl> <20070621130312.GB18392@elf.ucw.cz> <200706210837.29857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44380 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752386AbXFUS7V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 14:59:21 -0400
Content-Disposition: inline
In-Reply-To: <200706210837.29857.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>

Hi!

> > > IMO it can be done in two different ways:
> > > 1) via a .suspend() argument
> > > 2) via a global variable that the drivers can read.
> 
> For sufficiently small values of "two" that is.  
> 
> Other solutions that have been described on the PM list include
> 
>   3) Providing accessors to the information actually needed
>      in drivers ... e.g. say whether this clock or power domain
>      will be available in that target state.
> 
>   4) Act more like "current" ... there's a function returning
>      whatever "state" struct is settled on.  (But ideally
>      without the pseudo-global.)
> 
> I'm amused that nobody really reacted to the technical comments in
> my previous posts on this thread.  That's unfortunate, since from
> where I sit it feels to me like everyone else is a johnny-come-lately
> on this issue, and is now grasping at the quickest and dirtiest ways
> to work around the issue instead of coming to grasp with the various
> underlying issues.

Well, rest of the word is still using PC here, so johny-come-lately
may not be completely unexpected.

Could you push framework for some embedded system you care about? OLPC
by chance?

> IMO #3 is strongly preferable.

3) actually looks ok to me. For acpi it would mean

int acpi_state_we_are_entering(void)

returning S1..S4, right?

> But I really thought the discussion on new PM methods, back a
> couple months now, was going to finally get rid of that.

Umm, well, when someone gets to implement that...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
