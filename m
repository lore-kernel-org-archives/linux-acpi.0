From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: suspend kills serial wacom tablet
Date: Mon, 16 Apr 2007 15:10:18 -0600
Message-ID: <200704161510.18246.bjorn.helgaas@hp.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org> <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com> <4623D585.5010005@metm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:53547 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316AbXDPVK0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Apr 2007 17:10:26 -0400
In-Reply-To: <4623D585.5010005@metm.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marco <marco@metm.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org

On Monday 16 April 2007 13:59, marco wrote:
> ...  It is still a problem which renders the 
> pen unusable after a suspend.
> I am happy to run any tests you need.
> Attatched are a dmesg right after a reboot when the pen is working 
> dmesg.wpen and another dmesg after I suspend the laptop and the pen no 
> longer works.

Here's your trackpoint device:

  [17179584.620000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
  [17179584.640000] input: TPPS/2 IBM TrackPoint as /class/input/input2

After resume, it looks like it's associated with a different input device:

  [17179770.968000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
  [17179770.984000] input: TPPS/2 IBM TrackPoint as /class/input/input4

I'm sure that alone would be enough to confuse X.  It seems a bit
strange that the device is associated differently after resume, but
I don't know enough about input drivers to know whether that's by
design or not.

And I can't figure out what device that really is.  For some reason, I
thought it was ttyS0, but you seem to be using drivers/input/mouse/trackpoint.c,
which looks like PS/2 stuff, not serial.  And the wiki you referenced
mentions /dev/wacom.  I have no idea how that's wrapped up with this,
although drivers/usb/input/wacom* is all USB stuff, and I assume your
trackpoint is not a USB device (or is it?)

I should probably shut up right now before I ask more stupid questions.
But fools rush in where angels fear to tread, so:

  - Does it make any difference if you stop X before suspending and
    restart it afterwards?

  - Can you grub around in /sys and find the trackpoint device?  Maybe
    start with:

        $ grep . /sys/bus/pnp/devices/*/id
        $ ls -l /sys/bus/pnp/devices/*/driver
        $ ls -l /sys/class/input/*

  - Are you using a wacom module?  Maybe an "lsmod" would be useful.

  - What's in your Xorg config?  Does it mention /dev/wacom, /dev/ttyS0,
    /dev/input/..., etc?

Bjorn
