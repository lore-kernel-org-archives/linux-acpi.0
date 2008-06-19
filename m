From: Pavel Machek <pavel@suse.cz>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Thu, 19 Jun 2008 22:10:52 +0200
Message-ID: <20080619201052.GA15587@elf.ucw.cz>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com> <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36382 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbYFSUwl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 16:52:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jeff Trull <linmodemstudent@gmail.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu 2008-06-19 15:02:12, Len Brown wrote:
> 
> 
> On Sat, 31 May 2008, Jeff Trull wrote:
> 
> > I made a breakthrough in my s2r debugging last night when I realized
> > that the sooner I pressed the power button after suspend, the more
> > life the system exhibited post-resume.  In fact when I attempted to
> > resume immediately after entering suspend, my system had a successful
> > resume from memory for the first time ever.  Therefore, I have a new
> > hypothesis: DRAM self-refresh mode is not being properly entered.

Hmm, or some other hardware... I ve seen machines where video ram was
not refreshed. If that piece of hw is critical enough, it will break
resume.

You could try with minimal system, with as little drivers as
possible... use acpi_sleep=s3_beep to determine where it fails.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
