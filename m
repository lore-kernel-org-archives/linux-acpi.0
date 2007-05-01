From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21.1 problems during suspend-to-ram
Date: Tue, 1 May 2007 15:06:12 +0200
Message-ID: <200705011506.12351.rjw@sisk.pl>
References: <200704292348.33869.marv@der-marv.de> <200704302201.15586.rjw@sisk.pl> <200705011433.12748.marv@der-marv.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45301 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031211AbXEANBz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 May 2007 09:01:55 -0400
In-Reply-To: <200705011433.12748.marv@der-marv.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marvin Stark <marv@der-marv.de>
Cc: linux-acpi@vger.kernel.org

On Tuesday, 1 May 2007 14:33, Marvin Stark wrote:
> On Monday 30 April 2007 22:01, Rafael J. Wysocki wrote:
> > On Monday, 30 April 2007 20:27, Marvin Stark wrote:
> > > On Monday 30 April 2007 19:43, Matthew Garrett wrote:
> > > > On Mon, Apr 30, 2007 at 07:31:11PM +0200, Marvin Stark wrote:
> > > > > On Monday 30 April 2007 00:32, Matthew Garrett wrote:
> > > > > > On Sun, Apr 29, 2007 at 11:48:29PM +0200, Marvin Stark wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm trying to suspend my MacBook2,1 to ram and always get
> > > > > > > following error during suspend:
> > > > > > >
> > > > > > > ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
> > > > > >
> > > > > > That's not an error - what problems do you think it's causing?
> > > > >
> > > > > I realy dont know... Maybe you can give me some hints?
> > > > > Is there a way to get more debug info except enable debugging in the
> > > > > kernel?
> > > >
> > > > Well, uh, to start with it might help if you actually told us what the
> > > > problem is.
> > >
> > > Main problem is, that the maschine is not shutting down (suspend
> > > consoles). I tried s2ram and s2disk with both programs I'm not able to
> > > suspend my maschine. All devices (nic, firewire, usb etc) except hdd were
> > > suspended without any problems. After that the maschine freezes, showing
> > > this message:
> > >
> > > ------- 8< -------
> > > ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
> > > ------- 8< -------
> > >
> > > As 00:1f.2 is my S-ATA controller, I think my harddisk will not get
> > > suspended...
> > >
> > > ------- 8< -------
> > > 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
> > > Serial ATA Storage Controller IDE (rev 02)
> > > ------- 8< -------
> > >
> > > The only possibly way to suspend my system to disk is using sysfs.
> > > But this also only works when I set /sys/power/disk to "shutdown".
> > > If it's set to "platform" my system will not suspend.
> > >
> > > So there must be a problem with ACPI. Am I right with this suspicion?
> >
> > Probably, but the stack trace that you have quoted is likely unrelated to
> > this problem.
> >
> > Please try the appended patch and see if you can suspend to disk in the
> > platform mode with it.
> 
> I applied this patch but suspend to disk still doesn't work in platform mode.
> Any other ideas? Do you have a clue whats going wrong here?

No, I don't.

> If you need more infos or data please tell me.

I think more information will be necessary to resolve this problem, but at the
moment I don't know which information will be relevant.

Could you please file a bug report at http://bugzilla.kernel.org, in the
ACPI->Power-Sleep-Wake category and add my address to the CC list?

Greetings,
Rafael


> 
> >
> > Greetings,
> > Rafael
> 
> 
> [...]
> 
> Thanks,

-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
