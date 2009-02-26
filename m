From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 10:34:37 +0000
Message-ID: <1235644477.4770.118.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225172835.GA7152@srcf.ucam.org>
	 <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225175923.GB7836@srcf.ucam.org>  <49A5E0C5.8090700@buzzard.me.uk>
	 <1235637570.3802.20.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:54155 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753385AbZBZKer (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Feb 2009 05:34:47 -0500
In-Reply-To: <1235637570.3802.20.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net


On Thu, 2009-02-26 at 08:39 +0000, Richard Hughes wrote:
> On Thu, 2009-02-26 at 00:22 +0000, Jonathan Buzzard wrote:
> > Matthew Garrett wrote:
> > > On Wed, Feb 25, 2009 at 05:53:39PM +0000, Jonathan Buzzard wrote:
> > >> On Wed, 2009-02-25 at 17:28 +0000, Matthew Garrett wrote:
> > >>> The same argument encourages us to put rfkill and brightness control 
> > >>> support in a userland tool, despite the existing kernel interfaces for 
> > >>> controlling them. We could replace almost every driver in platform/x86 
> > >>> with a generic driver that allowed arbitrary ACPI methods to be called 
> > >>> and gave access to EC bits. The reason we haven't done this is because 
> > >>> that's what the kernel is there for.
> > >> Quite correct they should be removed. The first step of which is to
> > >> provide a generic interface to the HCI.
> > > 
> > > Yeah. No.
> > 
> > Yeah, yes
> 
> No.

Yes. You really don't understand the Toshiba Hardware Configuration
Interface. It is like making a old style BIOS INT 13 call. There are
potentially 2^16 possible calls, and there is no way to determine what
calls are valid on what laptop models other than a large lookup table. I
know of several dozen HCI calls, and there are hundreds of models, with
new models coming out all the time.

You proposal requires embedding this logic in kernel space, and it is
simply not appropriate.

> 
> > > 
> > >> You do it, test it then maintain it then. To claim that maintaining this
> > >> in kernel space is as easy as users space is patently ludicrous.
> > > 
> > > How so? C is C. Whether you do it in userspace or kernel space, all you 
> > > have to do is make a function call with the appropriate arguments.
> > >
> > 
> > No it is not. C that is running in kernel space is not the same as C 
> > that is runing in user space. The potential for a bug to have security 
> > implications is *far* higher. If you start pushing hundreds of lines of 
> > string parsing into the kernel that just got a whole lot more likely.
> 
> Then you don't do string parsing, or if you do it, you do it very
> carefully. You have to be just as careful with code running as root in
> userspace.

Bad news to implement *ALL* HCI methods you will, and worse besides.
That is the reason I ditched this approach ten years ago.

> 
> > Then one has to go through the whole rigmarole of submitting patches to 
> > various kernel developers and hoping that it gets in the next kernel.
> 
> Welcome to kernel development. It's really not that hard, even I can
> manage to get patches upstream, and I consider myself a userspace
> hacker.

You explain to an end user then that they cannot use their new Toshiba
laptop with their favourite Linux distribution without doing their own
kernel module, as the lookup table for what HCI calls are valid on their
laptop is not implemented in the kernel their distribution comes with. 

Is that the road you are proposing to go down? Because it is completely
divorced from reality and totally impractical.

> > As 
> > opposed to releasing your own user land code, that might not even be in 
> > C, it could be C++, Perl, Python whatever takes your fancy when ever it 
> > takes your fancy.
> 
> And that is the problem. You're doing low level hardware stuff in
> userspace in odd languages. If you stuck this in the kernel then we can
> use standard classes like rfkill, backlight and power_supply to control
> things. Then userspace "just works" without odd access libraries and
> yet-another-daemon.

Why would I put code into the kernel code for changing the ownerstring
on my laptop. Something I might do a couple of times in the lifetime of
the laptop?

What other models of computers have Linux kernel drivers to change the
BIOS boot order, or any other random model specific BIOS setting?

How do you propose to deal with the dozens of HCI calls and the hundreds
of models of laptops, with not all HCI calls being valid on all models,
and with the potential for a HCI call on the wrong laptop to brick it
and yes this *DOES* happen?

How do you propose echoing a password string for say the supervisor
password is going to translate that to the BIOS scan codes of the
relevant keys on that laptop, dealing with all the possible keyboard
layouts that might be in play? Why is this appropriate in a kernel
driver anyway for the half dozen times I might change it on a laptop?

Why if I install a distribution of Linux on my new Toshiba laptop should
I have to install a new kernel module and keep it updated to make some
change because the table specifying which HCI calls can be made is not
up to date in my distro's kernel?

> 
> > I would be interested in what on earth makes you thing putting hundreds 
> > of lines of code into a "proper" kernel driver as you put it is better 
> > as it is simply not the Unix way.
> 
> If the UNIX way is to expose raw devices /proc/toshiba and /dev/toshiba
> and then use userspace tools to poke random values in them, then get me
> back to Linux real quick.

It is not the Unix or Linux way to put huge quantities of code like this
into the kernel. It is not necessary or desirable, you *will* create
local privilege escalation bugs if you attempt it.

> The way to do this in the Linux kernel is to
> use the existing kernel abstractions like backlight and power_supply
> using a proper kernel driver.

The problem is your failing to understand the shear depth of possible
calls to the HCI interface. I am quite sure that a 10,000+ line kernel
module to implement all the HCI methods would be rejected upstream.
Somewhere I have an email from Alan Cox from a decade ago telling me
just that. That is why the current method was developed.

Finally actual code wins. If you want all this in kernel space then stop
winging and implement it. The fact that nobody has in the last five
years clearly indicates that there is little will to do so.

Exposing all the HCI calls through a /proc interface is just plain
stupid.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

