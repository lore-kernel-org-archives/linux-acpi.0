From: Pavel Machek <pavel@suse.cz>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Mon, 23 Jun 2008 12:15:08 +0200
Message-ID: <20080623101508.GA3003@elf.ucw.cz>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com> <alpine.LFD.1.10.0806191437580.3040@localhost.localdomain> <20080619201052.GA15587@elf.ucw.cz> <685450530806202313v4ec63bc8n5213330d77e1b6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53749 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbYFWKOL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 06:14:11 -0400
Content-Disposition: inline
In-Reply-To: <685450530806202313v4ec63bc8n5213330d77e1b6d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Trull <linmodemstudent@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri 2008-06-20 23:13:06, Jeff Trull wrote:
> On Thu, Jun 19, 2008 at 1:10 PM, Pavel Machek <pavel@suse.cz> wrote:
> 
> >
> > Hmm, or some other hardware... I ve seen machines where video ram was
> > not refreshed. If that piece of hw is critical enough, it will break
> > resume.
> >
> > You could try with minimal system, with as little drivers as
> > possible... use acpi_sleep=s3_beep to determine where it fails.
> 
> I don't have ready access to 2.6.26, but with 2.6.24 s3_beep produces
> a (endless, loud) tone if I resume immediately after suspend, and
> nothing at all if I wait 10 seconds first.

Hmm, okay, that confirms your theory :-(. Contacting BIOS vendor and
looking in DSDT for something strange turning off autorefresh is
something you could try...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
