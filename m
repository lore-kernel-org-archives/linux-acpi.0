From: Len Brown <lenb@kernel.org>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 21:19:45 -0500
Message-ID: <200701232119.45779.lenb@kernel.org>
References: <20070123104010.GB7135@fscked.org> <200701231625.39684.lenb@kernel.org> <20070124003342.GB8644@fscked.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55614 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965615AbXAXCVG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 21:21:06 -0500
In-Reply-To: <20070124003342.GB8644@fscked.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Perry <mikepery@fscked.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 23 January 2007 19:33, Mike Perry wrote:
> Thus spake Len Brown (lenb@kernel.org):
> 
> > On Tuesday 23 January 2007 16:00, Henrique de Moraes Holschuh wrote:
> > > On Tue, 23 Jan 2007, Mike Perry wrote:
> > > > Is there currently any way to disable busmastering or C3 transitions
> > > > (without recompilation)? Or better: is it possible to make the system
> > > > less eager to transition into C3 or otherwise reduce the frequency of
> > > > these transitions? If I could just get the frequency of transitions to
> > > > get out of the audible range, my life would be a lot better.
> > > 
> > > Read http://thinkwiki.org/wiki/Problem_with_high_pitch_noises, it may have
> > > the answers.
> > 
> > Pretty good write-up.  It is correct, you should try max_cstate.
> > 
> > for n starting at 3 and decreasing until the stound stops:
> > # echo n > /sys/module/processor/parameters/max_cstate
> 
> Ahh, very nice. The whine stops at n=2, which is consistent with my
> hack of manually disabling busmastering (which kills C3). At least now
> I have the option of peace and quiet vs longer battery life+annoying
> whine. Probably a tolerable option for plane flights :)
> 
> > BTW. what model Thinkpad do you have?
> 
> I actually have a Compaq Presario V6000T (Intel version). I was afraid
> to mention it because Compaqs are historically pretty junky and I
> figured someone would just say "that's what you get for buying junk" :)
> But aside from the whine the machine is really nice (slim form
> factor, very light yet durable, standard components, etc). ACPI
> suspend to RAM and such is also fully functional (at least with the
> Fedora kernels).
>
> > On some older systems, this pops all the way to C0, and on newer
> > systems it transparently pops to C2 and returns to C3 w/o waking the
> > OS.  You can get rid of it by disabling USB.  But it sounds like in
> > the full-on case you've got an issue even with USB disabled.  Or
> > sometimes you can bias the system to simply not enter C3 if it sees
> > bus master traffic with
> > 
> > # echo 0xFFFFFFFF > /sys/module/processor/parameters/bm_history
> 
> Yeah, unfortunately this has no effect, even if I enable CONFIG_HZ=100
> and CONFIG_HZ_100. What about that suspicious threshold structure in
> the acpi_processor_cx struct? Is there any reasoning behind these
> magic numbers in there for each state?

doesn't matter -- this code is being re-written anyway to handle dynticks.
Further, even a very broken C-state promotion algorithm quickly finds
its way to the deepest available C-state on a completely idle system.
 
> > Another thing to try building the kernel with CONFIG_HZ=100 -- which
> > is what a kernel for most laptops should be using in the first place.
> 
> As an aside, maybe this config option should be moved to a boot
> parameter? I don't think you're going to see distros shipping laptop
> kernels vs desktop kernels anytime soon.. But it doesn't seem to make
> any difference for me either way.

There actually was patch for boot-time "dynamic hz" a while ago,
but it didn't make it upstream -- instead the compile time static HZ did.

Unfortunately, FC6 chose to move to 1000 HZ from 250 HZ --
which is pretty much the opposite of what you want to do for
battery life.  Though honestly, for many models it will not make
a significant difference -- including the one I used for an example
battery life system here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2006-bltk-paper.pdf

Also, other major distros, such as OS 10.2, are still available with HZ 250,

Further, as Henrique says, we should be cutting over to dynticks soon anyway.
(though we've been saying that for 6 months)

cheers,
-Len
