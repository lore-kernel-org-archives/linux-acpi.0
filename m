From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ibm-acpi bay and acpi generic bay convergence
Date: Sat, 17 Mar 2007 16:24:29 -0300
Message-ID: <20070317192429.GA6508@khazad-dum.debian.net>
References: <20070315220414.GC15572@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59305 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789AbXCQTYh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Mar 2007 15:24:37 -0400
Content-Disposition: inline
In-Reply-To: <20070315220414.GC15572@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007, Henrique de Moraes Holschuh wrote:
> 3. is_ejectable_bay is too simple-minded.  It could work for batteries, if it
> didn't try so hard to detect only sata/ata devices as bays.  Maybe it can be
> changed to try to detect anything that can be ejected and which is not a
> dock?  It would find thinkpad batteries, then.
> 
> Alternatively, I can use the API I asked for (2) to register the battery bay
> handler.  But that looks less optimal, right now.
> 
> 
> I need to do some tests to check what happens in a thinkpad when you swap an
> ATAPI device with a battery, let's hope IBM did the right thing re. the
> event sources since they have two bay handles that belong to the same bay,
> and that Lenovo didn't break it.

Well, I have done the tests.  A quick hack to is_ejectable_bay so that it
registers anything that is not a dock lets ACPI_BAY handle thinkpad bay
batteries almost perfectly in a T43.  It is that simple.

So the first step is to improve is_ejectable_bay.  What reason did you have
to limit it only to devices where is_ata returns true?  Is there a reason
why anything that is not a dock and is ejectable should not be handled as a
bay ?

Back to thinkpad bay batteries:  The ACPI firmware in a T43 knows what you
inserted in the bay (even before you press the lever!), and directs *all*
bay events to either the BAT1 node or the relevant IDE0 node.  I don't know
if the other thinkpad firmwares are also this fine, but if they are, it will
just work.

ThinkPad bay events:  *IF* you have not ejected the device, you get one
event when the bay release lever is unlocked (eject request), and one when
the device is pulled off (and phisically disconnected) (hotunplug
notification).  If you eject the device, you receive no further eject
events.

You receive one event when the lever is inserted if there is something
inside the bay (hotplug).

The only drawback is that the user gets two bays (bay.0/bay.1) which are
actually the same thing.  Ejecting either will eject the device, which may
cause issues if the _EJ0 ACPI firmware is different... you really should
eject them using the correct handler for the device inside the bay.

_STA is decoupled, and will report 1 only for the node with the correct
device type, which is nice.  This CAN be used to mask off eject requests on
bays that have nothing inside, but I don't know if that is desired as a
general setup.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
