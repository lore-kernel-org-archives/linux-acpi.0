From: Len Brown <lenb@kernel.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Fri, 22 Feb 2008 19:06:28 -0500
Message-ID: <200802221906.28353.lenb@kernel.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <200802210341.13809.lenb@kernel.org> <200802211641.22920.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38958 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbYBWAG5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 19:06:57 -0500
In-Reply-To: <200802211641.22920.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thursday 21 February 2008 10:41, Thomas Renninger wrote:
> On Thursday 21 February 2008 09:41:13 you wrote:
> > Thomas,
> > Thanks for the note.
> > Please read the messages on linux-acpi with "dmi" in the subject
> > for some background.

> Can you be a bit more specific. Grepping for "dmi" is a bit verbose on the 
> linux-acpi list.

Sure, search messages from me in the last two months with "dmi" in the subject.

BTW. here is an example of OSI(Linux) breaking Linux:
http://bugzilla.kernel.org/show_bug.cgi?id=7787

> > yes, OSI(Linux) was enabled by default through 2.6.22
> > and was disabled by default starting in 2.6.23.
> >
> > The reason it has come up recently is because
> > it got into a reference BIOS -- and I'm sorry
> > to admit that I was a party to that -- I
> > wasn't thinking.
> >
> > Tomas Carnecky's reply is 100% correct.
> > We can't support OSI(Linux) any more than we
> > could support _OS="Linux", or Microsoft
> > could support OSI(Windows) -- particularly
> > on an OS that changes as fast as Linux does.
> > To do so would in some cases put Linux at
> > a permanent disadvantage to competing operating systems.

> No, not providing an interface at all is a disadvantage, a permanent one.
> 
> You all look at this too much from the kernel point of view:
> You are a vendor and you want to provide a BIOS update, because on the model 
> you sold with Linux on it, there is a bug. For some reason Linux is not 100% 
> compatible to Windows and the bug does only exist on Linux.
> But you still have to support Windows on that machine and unfortunately this 
> machine got sold with Windows 10x more often than with Linux.
> The bug is rather complicated to fix/workaround through the OS (E.g. suspend 
> reordering, AML bug, you simply misread the ACPI spec and it did work for 
> Windows (the ACPI kernel maintainer likes to add the "compatibility" hack, 
> but it's just too intrusive to backport into your stable kernel release you 
> support), ...). But a modification in the DSDT is a one-liner and an obvious 
> fix.
> You desperately search for a flag to be able to make sure you do not risk to 
> break Windows...
> Now they have to ignore the bug. Bad for the vendor, bad for the customer, bad 
> for us (yet another complex "Windows compatibility" hack).
>
> > Yes, we are attempting to close Pandora's box.
> Too late and IMO there is nothing bad about it.

Not only is there something bad about it,
the size and duration of the badnessa are both unbounded.

We went through this before when we changed
ACPI_OS_NAME to "Microsoft Windows NT" from "Linux".

We need to learn from history.

> > I think we'll be successful, though we have to handle the
> > Dell and Lenovo systems which actually use OSI(Linux)
> > on purpose.
> > Everybody else appears to be using it 
> > by mistake, sometimes with no effect,
> > sometimes with negative effect.
> Are you sure, they use it by mistake?
> Again, think from a vendor's point of view...
> What I expect happened here:
> Vendors thought about better Linux support. Some already chose a distribution 
> which (most common should be Ubuntu here, It's Dell, already Acer? and 
> others?) They pre-load it with a specific, probably a rather stable release 
> and sell their laptops with it. And they have to provide support for it, at 
> least for the release they sold it with.
> 
> I expect the first thing they did when thinking about Linux support is that 
> they added something similar like:
> Name (Linx, 0)
> ...
> if (_OSI("Linux"))
>    Store(1, Linx)
> 
> to their BIOSes, the same they do for Windows'es they have to support.
> They even may have verified it working... the "NOP".
> Now if there pop up problems, they can and will use this to provide Linux 
> specific BIOS fixes with code that is only processed on Linux, because they 
> cannot risk to break Windows.
> 
> If you rip this out now you will see:
>   - white/black listed NOPs that break after a BIOS update with later
>     kernels
>   - No BIOS updates for Linux at all in this area (and this is what I mean
>     with permanent disadvantage)

Outside of the development community, "BIOS update" is virtually an oxymoron.

> > No, the DMI list is not large,
> It is very confusing.
>
> > it is mostly comments and it is __init.
> That is not really important.

If there is a problem with the blacklist,
please bring it to my attention.

> > I _strongly_ urge you to not fork from
> > the .stable and mainline kernel in this area.

> Matthew's arguments are quite interesting.
> I still disagree with:
>   - simply ripping it out (at least do it soft)
>   - Remove all possibilities for vendors who want support Linux
>     to provide safe, only Linux affecting BIOS updates, just for
>     the sake of "being Windows compatible"
> 
> The strongest argument: I agree that they of course should contribute their 
> code and start working on the kernel, provide software updates etc.
> But those guys do not have to share much, anyway:
> (Some guessing now): Asus, Acer, Lenovo, Dell,...: have to make sure that they 
> buy and put hardware into their machines from companies that work on Linux 
> now. This is where we will see most advantages. They do not manufacture most 
> HW components themselves (network/wlan/sound/... cards). They manufacture or 
> at least have direct control over their BIOS, though. So this kind of hot-fix 
> is most convenient for them (or may be the only possibility for them).
>
> > OEMs that really want to modify the BIOS to recognize
> > OS interfaces that are in Linux should propose
> > new OSI strings that specify interfaces, not broad
> > categories of operating sytems; and in Linux we
> > shoudl use, or not use, those strings, as appropriate.
> > I've recently been in discussion with OEMs on exactly
> > this topic -- I'm sorry it didn't happen a year ago.

> So you mean "SLED 10 SP2", "UBUNTU supported version XY" strings?

No, I mean "Extended Address Space Descriptor"

> While this would be helpful for vendors on shortterm, they would realize soon, 
> that their customers get angry after updating to an unsupported, brand-new 
> kernel/distribution. This is exactly what we do not want to have (and what 
> could happen soon).
> 
> IMO osi=linux should stay (must stay now!).
> Your concerns that the vendors are messing up their BIOSes, so that this has 
> to be workarounded in later kernels etc. is utopistic.
> Vendors who are using such flags in their BIOSes want their machines to run 
> fine on Linux forever. They do not add ugly stuff in there on purpose. 
> Explain them how to use it. They should stick to the specifications, ask on 
> acpi list if in doubt. We should make up a documentation: "Guide for Linux 
> ACPI BIOS updates", ...
>
> The whole problem here is that those guys who are affected have never been 
> asked...
> Shouldn't there be some Dell activity on some Linux/Ubuntu lists now? I bet 
> every vendor will tell you that he wants to have such a thing. Find out some 
> people who are in charge for Linux and invite them for a discussion.
> A general Linux flag is the way to start, everything more specific will/can 
> get embedded into this flag later if it makes sense (without any risk for the 
> vendors to break Windows). There are (I expect most) cases where embedding 
> stuff into if(linux) makes a lot sense. But Henrique and others are probably 
> right that we need something more fine grained later (in rare cases, e.g. the 
> in-kernel graphics driver issues).

If you are having discussions with vendor BIOS writers,
please be encouraged to put them in direct contact with me.
I'm in touch with several, and they generally prefer
private communication versus open discussion on the list.

thanks,
-Len
