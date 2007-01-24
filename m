From: Mike Perry <mikepery@fscked.org>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 18:33:42 -0600
Message-ID: <20070124003342.GB8644@fscked.org>
References: <20070123104010.GB7135@fscked.org> <20070123194509.GA8644@fscked.org> <20070123210042.GE32032@khazad-dum.debian.net> <200701231625.39684.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sparky.fscked.org ([69.12.145.164]:56519 "EHLO fscked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933157AbXAXAeU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 19:34:20 -0500
Received: from mikepery by fscked.org with local (Exim 4.43)
	id 1H9W58-0004RC-LJ
	for linux-acpi@vger.kernel.org; Tue, 23 Jan 2007 18:33:42 -0600
Content-Disposition: inline
In-Reply-To: <200701231625.39684.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thus spake Len Brown (lenb@kernel.org):

> On Tuesday 23 January 2007 16:00, Henrique de Moraes Holschuh wrote:
> > On Tue, 23 Jan 2007, Mike Perry wrote:
> > > Is there currently any way to disable busmastering or C3 transitions
> > > (without recompilation)? Or better: is it possible to make the system
> > > less eager to transition into C3 or otherwise reduce the frequency of
> > > these transitions? If I could just get the frequency of transitions to
> > > get out of the audible range, my life would be a lot better.
> > 
> > Read http://thinkwiki.org/wiki/Problem_with_high_pitch_noises, it may have
> > the answers.
> 
> Pretty good write-up.  It is correct, you should try max_cstate.
> 
> for n starting at 3 and decreasing until the stound stops:
> # echo n > /sys/module/processor/parameters/max_cstate

Ahh, very nice. The whine stops at n=2, which is consistent with my
hack of manually disabling busmastering (which kills C3). At least now
I have the option of peace and quiet vs longer battery life+annoying
whine. Probably a tolerable option for plane flights :)

> BTW. what model Thinkpad do you have?

I actually have a Compaq Presario V6000T (Intel version). I was afraid
to mention it because Compaqs are historically pretty junky and I
figured someone would just say "that's what you get for buying junk" :)
But aside from the whine the machine is really nice (slim form
factor, very light yet durable, standard components, etc). ACPI
suspend to RAM and such is also fully functional (at least with the
Fedora kernels).

> On some older systems, this pops all the way to C0, and on newer
> systems it transparently pops to C2 and returns to C3 w/o waking the
> OS.  You can get rid of it by disabling USB.  But it sounds like in
> the full-on case you've got an issue even with USB disabled.  Or
> sometimes you can bias the system to simply not enter C3 if it sees
> bus master traffic with
> 
> # echo 0xFFFFFFFF > /sys/module/processor/parameters/bm_history

Yeah, unfortunately this has no effect, even if I enable CONFIG_HZ=100
and CONFIG_HZ_100. What about that suspicious threshold structure in
the acpi_processor_cx struct? Is there any reasoning behind these
magic numbers in there for each state?

> Another thing to try building the kernel with CONFIG_HZ=100 -- which
> is what a kernel for most laptops should be using in the first place.

As an aside, maybe this config option should be moved to a boot
parameter? I don't think you're going to see distros shipping laptop
kernels vs desktop kernels anytime soon.. But it doesn't seem to make
any difference for me either way.



-- 
Mike Perry
Mad Computer Scientist
fscked.org evil labs
