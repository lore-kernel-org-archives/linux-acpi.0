From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Mon, 16 Apr 2007 16:28:47 -0600
Message-ID: <200704161628.47707.bjorn.helgaas@hp.com>
References: <45D5EA88.7090300@redhat.com> <200704151857.03115.bjorn.helgaas@hp.com> <20070416211411.GA16150@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:39692 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705AbXDPW25 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Apr 2007 18:28:57 -0400
In-Reply-To: <20070416211411.GA16150@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>

On Monday 16 April 2007 15:14, Luca Tettamanti wrote:
> It seems that Asus exposes monitorining data using "ATK0110" (enumerated
> in DSDT); I see it both on my P5B-E motherboard and on my notebook (L3D)
> (they have different methods though). Another motherboard with the same
> device may actually call it "FOOBAR123" or "WTFISTHIS".

Yup, we have the same problem with other devices.  See the long list
of PNP IDs in 8250_pnp.c :-)

> Problem is that ACPI methods are not documented at all (how am I
> supposed to know that "G6T6" is the reading of the 12V rail?) while the
> datasheet of hw monitoring chips (w83627ehf in my case) are public (more
> or less).

Yes, I see that it's attractive to use a single w83627ehf.c driver.
For an ACPI driver, we'd have to build a list of PNP IDs, and possibly
information about which methods read which information.  That's
certainly more work.

On the other hand, the ACPI driver would avoid the synchronization
issues that started this whole thread.  That's a pretty compelling
advantage.

> Furthermore, sensor driver exposes all the reading of the chip
> (e.g. in the DSDT I can't find the VSB or battery voltage).

Maybe Asus didn't hook up those readings on the board.  I would
guess that PC Probe doesn't expose the VSB or battery voltage either.

I'm sure you've seen these:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/014050.html
  http://www.lm-sensors.org/wiki/AsusFormulaHacking

Looks like nobody took up the challenge, though :-)  It looks fun
to play with, if only I had the time and hardware.

Bjorn
