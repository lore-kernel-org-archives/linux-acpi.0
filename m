From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 13:27:30 +0000
Message-ID: <1235654850.4770.139.camel@penguin.lifesci.dundee.ac.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
	 <20090225152409.GA4015@srcf.ucam.org>
	 <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225165152.GA5981@srcf.ucam.org>
	 <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225172835.GA7152@srcf.ucam.org>
	 <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk>
	 <20090225175923.GB7836@srcf.ucam.org>  <49A5E0C5.8090700@buzzard.me.uk>
	 <1235637570.3802.20.camel@hughsie-work.lan>
	 <1235644477.4770.118.camel@penguin.lifesci.dundee.ac.uk>
	 <1235652739.3802.72.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:56815 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751819AbZBZN1l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Feb 2009 08:27:41 -0500
In-Reply-To: <1235652739.3802.72.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net


On Thu, 2009-02-26 at 12:52 +0000, Richard Hughes wrote:
> On Thu, 2009-02-26 at 10:34 +0000, Jonathan Buzzard wrote:
> > Yes. You really don't understand the Toshiba Hardware Configuration
> > Interface. It is like making a old style BIOS INT 13 call. There are
> > potentially 2^16 possible calls, and there is no way to determine what
> > calls are valid on what laptop models other than a large lookup table.
> 
> You mean there's no way of using dmi matching to do subsets of models?
> Is the A20 very much different from the A10?

Potentially. Sometimes yes sometimes no. Let's face it the same model
can have optional Bluetooth, and HCI calls have been known to brick a
laptop.

> > You explain to an end user then that they cannot use their new Toshiba
> > laptop with their favourite Linux distribution without doing their own
> > kernel module, as the lookup table for what HCI calls are valid on their
> > laptop is not implemented in the kernel their distribution comes with. 
> > 
> > Is that the road you are proposing to go down? Because it is completely
> > divorced from reality and totally impractical.
> 
> So your view of reality is to tell the user to install a userspace
> library, and perhaps another daemon, and then patch all the userspace
> tools to use your library as well as the kernel interfaces? I don't
> think so.

No because the patch provides a generic interface to the Toshiba HCI.
They may need to install a *single* user space program that works with
the generic kernel mode interface.

> > Why would I put code into the kernel code for changing the ownerstring
> > on my laptop. Something I might do a couple of times in the lifetime of
> > the laptop?
> 
> Why would you want to do that? That's focusing on the couple of people
> on the planet using a laptop that know what an ownerstring is.

Well I want to change my ownerstring on my laptop from Linux, and
without the patch in question I have to put a whole bunch of code into
the  kernel.

> 
> > What other models of computers have Linux kernel drivers to change the
> > BIOS boot order, or any other random model specific BIOS setting?
> 
> Leave that to the BIOS. Just because it can be done, doesn't mean it
> should be done.

Now you are dodging the issue. Besides a whole bunch of the settings
take effect after a suspend, why should I have to reboot?

> 
> > How do you propose to deal with the dozens of HCI calls and the hundreds
> > of models of laptops, with not all HCI calls being valid on all models,
> > and with the potential for a HCI call on the wrong laptop to brick it
> > and yes this *DOES* happen?
> 
> How many different HCI calls are there to increase the backlight
> brightness up by one unit?

Several, depends on the model in question. But we are not talking about
the backlight, we are talking about all the other methods that you
clearly know nothing about.

> > Why if I install a distribution of Linux on my new Toshiba laptop should
> > I have to install a new kernel module and keep it updated to make some
> > change because the table specifying which HCI calls can be made is not
> > up to date in my distro's kernel?
> 
> Dude, that happens all the time with other kernel modules. You see a
> patch on LKML saying "add product ID for foobuzz" and then it gets
> picked up by downstream as a patch until a new version is released.

Yes and it is sub optimal.

You also failed to explain how the supervisor, and user password setting
was going to work from a kernel mode proc interface.


> > > > I would be interested in what on earth makes you thing putting hundreds 
> > > > of lines of code into a "proper" kernel driver as you put it is better 
> > > > as it is simply not the Unix way.
> > > 
> > > If the UNIX way is to expose raw devices /proc/toshiba and /dev/toshiba
> > > and then use userspace tools to poke random values in them, then get me
> > > back to Linux real quick.
> > 
> > It is not the Unix or Linux way to put huge quantities of code like this
> > into the kernel. It is not necessary or desirable, you *will* create
> > local privilege escalation bugs if you attempt it.
> 
> Will I?

You write perfect bug free C code first time every time? You don't so
you will introduce bugs.

> > > The way to do this in the Linux kernel is to
> > > use the existing kernel abstractions like backlight and power_supply
> > > using a proper kernel driver.
> > 
> > The problem is your failing to understand the shear depth of possible
> > calls to the HCI interface. I am quite sure that a 10,000+ line kernel
> > module to implement all the HCI methods would be rejected upstream.
> > Somewhere I have an email from Alan Cox from a decade ago telling me
> > just that. That is why the current method was developed.
> 
> You don't need all of them. You need backlight control, fan control,
> battery and maybe a few others. You don't need to interact with the EC
> in all possible ways.

You miss entirely the point of Toshiba's HCI. We are not talking about
backlight control here. We are talking about a bunch of other stuff.

Besides since when did you get to decide what *I* want to do? You don't.
So because I have a perfectly legitimate reason to change the
ownerstring on my laptop, rather than burdening the kernel with a whole
bunch of string handling code for the rare occasions I want to do that
we expose the generic interface that lets me change this and bunch of
other stuff to user space.


> > Finally actual code wins. If you want all this in kernel space then stop
> > winging and implement it. The fact that nobody has in the last five
> > years clearly indicates that there is little will to do so.
> 
> Well, I think the onus is on you to provide a proper kernel patch,
> rather than just exposing userspace to /dev/toshiba, afterall, that was
> the thing that's prompted my mail

We have a proper kernel patch, the use of /dev/toshiba was excepted
upstream a decade ago. There is a range of software that supports this
interface. The patch extends this to modern Toshiba hardware. It is a no
brainer to anyone with any practical sense.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

