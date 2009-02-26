From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 15:49:13 +0000
Message-ID: <1235663354.4770.193.camel@penguin.lifesci.dundee.ac.uk>
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
	 <1235656742.3802.82.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lifesci.dundee.ac.uk ([134.36.67.240]:50554 "EHLO
	frigg.compbio.dundee.ac.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752211AbZBZPt0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Feb 2009 10:49:26 -0500
In-Reply-To: <1235656742.3802.82.camel@hughsie-work.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org


On Thu, 2009-02-26 at 13:59 +0000, Richard Hughes wrote:
> On Thu, 2009-02-26 at 13:27 +0000, Jonathan Buzzard wrote:
> > On Thu, 2009-02-26 at 12:52 +0000, Richard Hughes wrote:
> > > On Thu, 2009-02-26 at 10:34 +0000, Jonathan Buzzard wrote:
> > > > Yes. You really don't understand the Toshiba Hardware Configuration
> > > > Interface. It is like making a old style BIOS INT 13 call. There are
> > > > potentially 2^16 possible calls, and there is no way to determine what
> > > > calls are valid on what laptop models other than a large lookup table.
> > > 
> > > You mean there's no way of using dmi matching to do subsets of models?
> > > Is the A20 very much different from the A10?
> > 
> > Potentially. Sometimes yes sometimes no. Let's face it the same model
> > can have optional Bluetooth, and HCI calls have been known to brick a
> > laptop.
> 
> So if I do an HCI that enables bluetooth on a model without bluetooth,
> that will brick it? Sounds implausible to me.
> 

Possibly. The Toshiba provided Windows user space programs go to some
length to establish what models they are running on before attempting
any funny business. Over the years a number of users have tried randomly
poking the HCI without knowing what they are doing and bricked their
laptops. If you understood how the HCI really works under the hood, you
would understand. The error checking in it last time I looked is
virtually none existent.


> > > Leave that to the BIOS. Just because it can be done, doesn't mean it
> > > should be done.
> > 
> > Now you are dodging the issue. Besides a whole bunch of the settings
> > take effect after a suspend, why should I have to reboot?
> 
> Re-read my reply again.

Who the hell are you to decide that? If for example I want to change my
pointer from internal to external and go through a suspend cycle rather
than a reboot to get it, that is my business not yours.

> 
> > > > How do you propose to deal with the dozens of HCI calls and the hundreds
> > > > of models of laptops, with not all HCI calls being valid on all models,
> > > > and with the potential for a HCI call on the wrong laptop to brick it
> > > > and yes this *DOES* happen?
> > > 
> > > How many different HCI calls are there to increase the backlight
> > > brightness up by one unit?
> > 
> > Several, depends on the model in question. But we are not talking about
> > the backlight, we are talking about all the other methods that you
> > clearly know nothing about.
> 
> No, we're talking about sensible abstractions, rather than poking bits
> of memory in a device file that happen to do stuff on specific models.
> 

There are no sensible abstractions. If you had any knowledge of the HCI
you would understand that. However you don't and are arguing about
things you do not know about.


> > > > Why if I install a distribution of Linux on my new Toshiba laptop should
> > > > I have to install a new kernel module and keep it updated to make some
> > > > change because the table specifying which HCI calls can be made is not
> > > > up to date in my distro's kernel?
> > > 
> > > Dude, that happens all the time with other kernel modules. You see a
> > > patch on LKML saying "add product ID for foobuzz" and then it gets
> > > picked up by downstream as a patch until a new version is released.
> > 
> > Yes and it is sub optimal.
> 
> If there's new Toshiba hardware created, I have to update your client
> program. I don't see how it's any different to updating the kernel
> module.

Then you don't live in the real world. Let's say I run Debian (but it
could be any Linux distribution), lets say that Debian is running a
version of the Linux kernel that has the relevant patch for the Toshiba
HCI in the toshiba_acpi module.

I buy my brand new Toshiba laptop which has some fancy new feature that
is controlled by the HCI (say like the transflective screen on the
Portage R500 and R600). I spend an bit of time in Windows working out
what the HCI calls are, and write a small user space program to do the
same under Linux. That's it, I am now home free no need to do any work
going forward.

Your method I write and debug a kernel module. Quite possibly hard
locking laptop in the process. I run a genuine risk of bricking the
laptop as well in the meantime. Then Debian release a security update,
so I need to compile the kernel module again. Maybe patches to the
kernel module don't make it in time for the next release of the
distribution so I am on a kernel module compile treadmill for years.

It also means I have to run the latest version of the kernel anyway to
develop the module. Maybe I run RHEL/CentOS, I can hardly use a
RHEL/CentOS kernel to develop a kernel module can I. So I have to break
my distribution to do this rather than get on with more important
things.

Too need this explaining beggars belief. In addition it is just feasible
to get an end user to download a program to /usr/local/bin and run it.
Getting them involved in a constant cycle of kernel module compiling is
just not going to happen.

> > You also failed to explain how the supervisor, and user password setting
> > was going to work from a kernel mode proc interface.
> 
> Can't you do this from the BIOS?
> 

Do you even own a "pucker" Toshiba laptop??? The short answer is no,
there are a whole bunch of things that you can set with the HCI that can
be set *NO* other way.

> > You miss entirely the point of Toshiba's HCI. We are not talking
> about
> > backlight control here. We are talking about a bunch of other stuff.
> 
> "Bunch of other stuff". Could we not decide on a proper framework for
> this functionality?
> 

The proper framework is the HCI interface. What you can do with the HCI
is extremely wide ranging. While much of the pre ACPI, HCI commands (and
the complete Software Configuration Interface SCI) have been absorbed in
ACPI much of it has not. If the authors of the ACPI specification, and
manufactures of the laptop cannot come up with a consistent way of doing
this what makes you think you can?

> > > Well, I think the onus is on you to provide a proper kernel patch,
> > > rather than just exposing userspace to /dev/toshiba, afterall, that was
> > > the thing that's prompted my mail
> > 
> > We have a proper kernel patch, the use of /dev/toshiba was excepted
> > upstream a decade ago.
> 
> As was /proc/apm, /dev/pmu and all the other _obsolete_ interfaces. They
> were bad then, and they would be bad now. Userspace and the kernel have
> moved on from a decade ago.

These describe specified interfaces. Something that the Toshiba HCI is
not. It can do literally *anything* on your laptop. If you look in the
toshiba driver you will see some of the calls are deliberately blocked
for this reason.

> >  There is a range of software that supports this
> > interface. The patch extends this to modern Toshiba hardware. It is a no
> > brainer to anyone with any practical sense.
> 
> Maybe I have no brain.
> 

Clearly not.

In the meantime actual code trumps.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.

