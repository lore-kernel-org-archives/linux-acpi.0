From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Tue, 22 May 2007 22:08:19 +0200
Message-ID: <200705222208.20215.rjw@sisk.pl>
References: <1179859741.27532.8.camel@localhost> <200705222127.32713.rjw@sisk.pl> <1179867447.15226.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57973 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650AbXEVUCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 16:02:47 -0400
In-Reply-To: <1179867447.15226.1.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Tuesday, 22 May 2007 22:57, Peter Clifton wrote:
> On Tue, 2007-05-22 at 21:27 +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Tuesday, 22 May 2007 20:49, Peter Clifton wrote:
> > > Hi,
> > > 
> > > I just updated my bios to HP's latest, and have recently been
> upgraded
> > > to Ubuntu Gutsy kernel version:
> > > 
> > > Linux version 2.6.22-1-generic (buildd@palmer) (gcc version 4.1.3
> > > 20070423 (prerelease) (Ubuntu 4.1.2-3ubuntu3)) #1 SMP Mon Apr 30
> > > 10:49:22 GMT 2007
> 
> [snip]
> 
> > Well, threre's a couple of such things.  You may try the kernel.org
> kernel
> > 2.6.22-rc2 with the hibernation and suspend patchset available from
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc2/patches .
> 
> I wonder if those are included in Ubuntu's kernel (I'm being dumb today,
> but I couldn't work out if the debian build was adding patches or not,
> nor which exact version they started from.
> 
> (The source filename is linux-source-2.6.22_2.6.22-5.11.tar.gz)
> 
> Just FYI, the link you posted has a file with funny permissions on it:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc2/patches/16-usb-use-freezable-workqueue.patch
> 
> Gives me a 403 error.

Fixed now, sorry for the inconvenience.

Greetings,
Rafael
