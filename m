From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 10:15:08 -0300
Message-ID: <20070809131508.GD3113@khazad-dum.debian.net>
References: <20070809123943.GD3939@ngolde.de> <20070809125431.GC3113@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49281 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S938678AbXHINPN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Aug 2007 09:15:13 -0400
Content-Disposition: inline
In-Reply-To: <20070809125431.GC3113@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nico Golde <nion@gmx.net>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

(here's the email I sent Nico but which didn't arrive anywhere. CCs/BCCs
added to resend it to everyone)

On Mon, 06 Aug 2007, Nico Golde wrote:
> I recently implemented libacpi (http://www.ngolde.de/libacpi.html)
> to have some kind of provider for all these acpi applets out 
> there. What makes me wonder is that people using this lib 
> and ibm-acpi complain about broken fan support.

Well, this is all going to be handled by libsensors quite soon, because
AFAIK all of the fan and thermal monitoring in the kernel is going to switch
to the hwmon class as fast as we can manage.

Thinkpad-acpi and most other laptop drivers have already made the move, and
the ACPI subsystem itself is also doing it.

For thinkpad-acpi, use of procfs for thermal and fan monitoring and control
is heavily deprecated and will go away as soon as I possible can get away
with it.  I would be very happy to see it gone, the thinkpad-acpi procfs
code has been nothing but grief to me to maintain, so far.

I won't hate you for using thinkpad-acpi procfs in your library, but I don't
want to hear of crap like the one some applets out there pulled on ibm-acpi
ever again.  So, please either don't use procfs to talk to thinkpad-acpi, or
do it right.

That happens because thinkpad-acpi's procfs interface is, frankly, a piece
of crap that can be a lot of hassle to work with from an userspace
application's point-of-view.  You'll need to parse its key: value records
into data structures, and find out the one you need.  You will have to look
at the kernel code (or ask me) to know all possible return values of a given
key, etc.  If you go the easy way like gnome sensors-applet did, for
example, it *will* *break* sooner or later.

In fact, just to make it clear, I am asking you to please *not* support
/proc/acpi/ibm in your libacpi. 

You are welcome to use the new sysfs interfaces from thinkpad-acpi, which is
much better documented and easier to use.  That said, IMO your efforts would
be much better spent helping libsensors, as any lib interfacing to
thinkpad-acpi to get fan and thermal data is just duplicating the effort of
libsensors.  HAL is probably in the picture as well, since your target
demographics seems to be desktop environment applets.

> If looking at their /proc/acpi it looks like /proc/acpi/fan 
> is empty and the fan information can be found in a seperated 
> ibm directory.

Yeah. /proc/acpi/fan is for the ACPI subsystem generic ACPI fan support.  No
other driver will mess with it, and it has its own syntax that is in no way
tied to whatever thinkpad-acpi uses in its procfs interface, for example.

> Now this makes it very hard to support ibm-acpi and I guess 
> it is the same for asus4acpi. Why does the kernel create an 
> empty directory instead of none here? And why doesn't 
> ibm-acpi extend the original /proc/acpi structure apart from 
> ibm specific feature stuff?

Well, apparently you require more up-to-date knowledge on how these things
connect together to do a good job.  May I suggest you go over the linux-acpi
mailinglist archives for 2007?  And also the lm-sensors developer
mailinglist archives, so that you get to know hwmon and libsensors better?
And also reading all the kernel 2.6.22 and 2.6.23-rc* ACPI documentation?
That will give you a better picture of what is happening.

Unfortunately, there is no easy, complete documentation for this.  As usual,
it is in the code and the mailing-lists.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
