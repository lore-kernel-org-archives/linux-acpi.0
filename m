From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HP Compaq nc6320 Suspend / Resume (changes in behaviour)
Date: Tue, 22 May 2007 21:27:32 +0200
Message-ID: <200705222127.32713.rjw@sisk.pl>
References: <1179859741.27532.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57819 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbXEVTW0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 15:22:26 -0400
In-Reply-To: <1179859741.27532.8.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

Hi,

On Tuesday, 22 May 2007 20:49, Peter Clifton wrote:
> Hi,
> 
> I just updated my bios to HP's latest, and have recently been upgraded
> to Ubuntu Gutsy kernel version:
> 
> Linux version 2.6.22-1-generic (buildd@palmer) (gcc version 4.1.3
> 20070423 (prerelease) (Ubuntu 4.1.2-3ubuntu3)) #1 SMP Mon Apr 30
> 10:49:22 GMT 2007
> 
> For the first time ever, suspend to ram works!

That's a good news.

> Unfortunately, hibernation has broken. This happened somewhere between
> Feisty's 2.6.20 kernel and the one I'm using now. (Although it could
> have been an update released in Feisty which broke things).
> 
> I can hibernate, but after a short while being booted back up (and
> perhaps accessing some ACPI related thing, e.g. cpu scaling, unplugging
> AC etc.. it will crash (and due to being in X11 at the time, I've got no
> useful debug output to go on).
> 
> Does anyone know specifically if something changed to fix suspend, (with
> SATA drives no less!), or anything which may have broken hibernate.
> (Which was broken before I updated from bios F.06 to the latest today)

Well, threre's a couple of such things.  You may try the kernel.org kernel
2.6.22-rc2 with the hibernation and suspend patchset available from
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc2/patches .

> After resume from suspend, I see:
> 
> dmesg  | grep ACPI | grep Error
> [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> [ 4763.428000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C241] (Node df94c9dc), AE_AML_PACKAGE_LIMIT
> [ 6417.528000] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C002.C0DC.C349._STM] (Node df94fba8), AE_AML_PACKAGE_LIMIT
> 
> Is this anything to worry about - should I post a dsdt for the new bios?

This means we are unable to set the IDE controller transfer timings after the
resume.  I don't know how serious this is in practice, though.

Greetings,
Rafael
