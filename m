From: Richard Hughes <hughsient@gmail.com>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 08:39:30 +0000
Message-ID: <1235637570.3802.20.camel@hughsie-work.lan>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225172835.GA7152@srcf.ucam.org>
	 <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225175923.GB7836@srcf.ucam.org>  <49A5E0C5.8090700@buzzard.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:11923 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZBZIkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 03:40:25 -0500
Received: by qw-out-2122.google.com with SMTP id 5so797291qwi.37
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2009 00:40:23 -0800 (PST)
In-Reply-To: <49A5E0C5.8090700@buzzard.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

On Thu, 2009-02-26 at 00:22 +0000, Jonathan Buzzard wrote:
> Matthew Garrett wrote:
> > On Wed, Feb 25, 2009 at 05:53:39PM +0000, Jonathan Buzzard wrote:
> >> On Wed, 2009-02-25 at 17:28 +0000, Matthew Garrett wrote:
> >>> The same argument encourages us to put rfkill and brightness control 
> >>> support in a userland tool, despite the existing kernel interfaces for 
> >>> controlling them. We could replace almost every driver in platform/x86 
> >>> with a generic driver that allowed arbitrary ACPI methods to be called 
> >>> and gave access to EC bits. The reason we haven't done this is because 
> >>> that's what the kernel is there for.
> >> Quite correct they should be removed. The first step of which is to
> >> provide a generic interface to the HCI.
> > 
> > Yeah. No.
> 
> Yeah, yes

No.

> > 
> >> You do it, test it then maintain it then. To claim that maintaining this
> >> in kernel space is as easy as users space is patently ludicrous.
> > 
> > How so? C is C. Whether you do it in userspace or kernel space, all you 
> > have to do is make a function call with the appropriate arguments.
> >
> 
> No it is not. C that is running in kernel space is not the same as C 
> that is runing in user space. The potential for a bug to have security 
> implications is *far* higher. If you start pushing hundreds of lines of 
> string parsing into the kernel that just got a whole lot more likely.

Then you don't do string parsing, or if you do it, you do it very
carefully. You have to be just as careful with code running as root in
userspace.

> Then one has to go through the whole rigmarole of submitting patches to 
> various kernel developers and hoping that it gets in the next kernel.

Welcome to kernel development. It's really not that hard, even I can
manage to get patches upstream, and I consider myself a userspace
hacker.

> As 
> opposed to releasing your own user land code, that might not even be in 
> C, it could be C++, Perl, Python whatever takes your fancy when ever it 
> takes your fancy.

And that is the problem. You're doing low level hardware stuff in
userspace in odd languages. If you stuck this in the kernel then we can
use standard classes like rfkill, backlight and power_supply to control
things. Then userspace "just works" without odd access libraries and
yet-another-daemon.

> I would be interested in what on earth makes you thing putting hundreds 
> of lines of code into a "proper" kernel driver as you put it is better 
> as it is simply not the Unix way.

If the UNIX way is to expose raw devices /proc/toshiba and /dev/toshiba
and then use userspace tools to poke random values in them, then get me
back to Linux real quick. The way to do this in the Linux kernel is to
use the existing kernel abstractions like backlight and power_supply
using a proper kernel driver. This means that Linux userspace can do
simply echo values into known locations and change the state no matter
what the hardware.

We've spent a lot of time removing insane kernel bodges like exposing
hotkeys through a polled semi-interface, and instead using the input
layer properly, and I don't want to regress on that work now.

Thanks,

Richard.


