From: Len Brown <lenb@kernel.org>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 16:25:29 -0500
Message-ID: <200701231625.39684.lenb@kernel.org>
References: <20070123104010.GB7135@fscked.org> <20070123194509.GA8644@fscked.org> <20070123210042.GE32032@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50430 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965465AbXAWVc0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 16:32:26 -0500
In-Reply-To: <20070123210042.GE32032@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Mike Perry <mikepery@fscked.org>, linux-acpi@vger.kernel.org

On Tuesday 23 January 2007 16:00, Henrique de Moraes Holschuh wrote:
> On Tue, 23 Jan 2007, Mike Perry wrote:
> > Is there currently any way to disable busmastering or C3 transitions
> > (without recompilation)? Or better: is it possible to make the system
> > less eager to transition into C3 or otherwise reduce the frequency of
> > these transitions? If I could just get the frequency of transitions to
> > get out of the audible range, my life would be a lot better.
> 
> Read http://thinkwiki.org/wiki/Problem_with_high_pitch_noises, it may have
> the answers.

Pretty good write-up.  It is correct, you should try max_cstate.

for n starting at 3 and decreasing until the stound stops:
# echo n > /sys/module/processor/parameters/max_cstate

BTW. what model Thinkpad do you have?

The USB dependency is probably due to USB bus mastering causing
the system to "pop" out of C3 to snoop the USB DMA traffic.

On some older systems, this pops all the way to C0, and on newer
systems it transparently pops to C2 and returns to C3 w/o waking the OS.
You can get rid of it by disabling USB.  But it sounds like in the full-on case
you've got an issue even with USB disabled.  Or sometimes you can
bias the system to simply not enter C3 if it sees bus master traffic with

# echo 0xFFFFFFFF > /sys/module/processor/parameters/bm_history

Another thing to try building the kernel with CONFIG_HZ=100 -- which
is what a kernel for most laptops should be using in the first place.

cheers,
-Len


