From: Richard Hughes <hughsient@gmail.com>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 13:59:02 +0000
Message-ID: <1235656742.3802.82.camel@hughsie-work.lan>
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
	 <1235654850.4770.139.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:50778 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811AbZBZN76 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 08:59:58 -0500
Received: by wf-out-1314.google.com with SMTP id 28so639040wfa.4
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2009 05:59:56 -0800 (PST)
In-Reply-To: <1235654850.4770.139.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

On Thu, 2009-02-26 at 13:27 +0000, Jonathan Buzzard wrote:
> On Thu, 2009-02-26 at 12:52 +0000, Richard Hughes wrote:
> > On Thu, 2009-02-26 at 10:34 +0000, Jonathan Buzzard wrote:
> > > Yes. You really don't understand the Toshiba Hardware Configuration
> > > Interface. It is like making a old style BIOS INT 13 call. There are
> > > potentially 2^16 possible calls, and there is no way to determine what
> > > calls are valid on what laptop models other than a large lookup table.
> > 
> > You mean there's no way of using dmi matching to do subsets of models?
> > Is the A20 very much different from the A10?
> 
> Potentially. Sometimes yes sometimes no. Let's face it the same model
> can have optional Bluetooth, and HCI calls have been known to brick a
> laptop.

So if I do an HCI that enables bluetooth on a model without bluetooth,
that will brick it? Sounds implausible to me.

> > Leave that to the BIOS. Just because it can be done, doesn't mean it
> > should be done.
> 
> Now you are dodging the issue. Besides a whole bunch of the settings
> take effect after a suspend, why should I have to reboot?

Re-read my reply again.

> > > How do you propose to deal with the dozens of HCI calls and the hundreds
> > > of models of laptops, with not all HCI calls being valid on all models,
> > > and with the potential for a HCI call on the wrong laptop to brick it
> > > and yes this *DOES* happen?
> > 
> > How many different HCI calls are there to increase the backlight
> > brightness up by one unit?
> 
> Several, depends on the model in question. But we are not talking about
> the backlight, we are talking about all the other methods that you
> clearly know nothing about.

No, we're talking about sensible abstractions, rather than poking bits
of memory in a device file that happen to do stuff on specific models.

> > > Why if I install a distribution of Linux on my new Toshiba laptop should
> > > I have to install a new kernel module and keep it updated to make some
> > > change because the table specifying which HCI calls can be made is not
> > > up to date in my distro's kernel?
> > 
> > Dude, that happens all the time with other kernel modules. You see a
> > patch on LKML saying "add product ID for foobuzz" and then it gets
> > picked up by downstream as a patch until a new version is released.
> 
> Yes and it is sub optimal.

If there's new Toshiba hardware created, I have to update your client
program. I don't see how it's any different to updating the kernel
module.

> You also failed to explain how the supervisor, and user password setting
> was going to work from a kernel mode proc interface.

Can't you do this from the BIOS?

> > Will I?
> 
> You write perfect bug free C code first time every time? You don't so
> you will introduce bugs.

No, you said "you *will* create local privilege escalation bugs" which
is very different to "introducing bugs".

> You miss entirely the point of Toshiba's HCI. We are not talking about
> backlight control here. We are talking about a bunch of other stuff.

"Bunch of other stuff". Could we not decide on a proper framework for
this functionality?

> > Well, I think the onus is on you to provide a proper kernel patch,
> > rather than just exposing userspace to /dev/toshiba, afterall, that was
> > the thing that's prompted my mail
> 
> We have a proper kernel patch, the use of /dev/toshiba was excepted
> upstream a decade ago.

As was /proc/apm, /dev/pmu and all the other _obsolete_ interfaces. They
were bad then, and they would be bad now. Userspace and the kernel have
moved on from a decade ago.

>  There is a range of software that supports this
> interface. The patch extends this to modern Toshiba hardware. It is a no
> brainer to anyone with any practical sense.

Maybe I have no brain.

Richard.


