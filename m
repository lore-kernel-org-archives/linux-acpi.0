From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Tue, 17 Jun 2008 12:53:15 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806171234040.7277@localhost.localdomain>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>
 <485799B6.2010302@diamondcut.com.br>
 <alpine.LFD.1.10.0806171224130.7277@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:43405 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbYFQQxl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 12:53:41 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2M00LEL9KUD4P7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 17 Jun 2008 11:53:20 -0500 (CDT)
In-reply-to: <alpine.LFD.1.10.0806171224130.7277@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Renato S. Yamane" <yamane@diamondcut.com.br>
Cc: Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, jonathan@buzzard.org.uk



> > >> Toshiba have a 'link' between Linux Developers and Head Company, that is:
> > >> <http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>
> > >>
> > >> If someone need documentation to develop Linux drivers, contact
> > >> linux@toshiba-dme.co.jp
> > > 
> > > Are there any known drivers for Toshiba hardware that you need for Linux
> > > that we should be contacting them about?
> > 
> > Greg, in my Toshiba M45-S355, multimedia keys (play, pause, stop, etc)
> > and Fn+Fx keys don't work.
> > 
> > With no Fn keys, I can't change brightness of monitor (Fn+F6/F7) and
> > change output video from LCD to VGA (Fn+F5).
> > 
> > I try use "xev" to capture key press, but Fn and Multimedia Keys is not
> > recognized.
> > 
> > And other problem is with battery charge, as we can see here:
> > <http://bugzilla.kernel.org/show_bug.cgi?id=10797>

I'm glad to see Toshiba hosting a Linux page, even if it seems
to be missing most of its links at this time, it is a step
in the right direction.

Toshiba specific support in upstream Linux is very weak.
There are two toshiba specific drivers, and ACPI based one,
and an SMM based one.  As far as I can tell, neither has
had any benefit of any support or documentation from Toshiba.
Neither has seen any significant development over the last 3 years.

TOSHIBA ACPI EXTRAS DRIVER
P:      John Belmonte
M:      toshiba_acpi@memebeam.org
W:      http://memebeam.org/toys/ToshibaAcpiDriver
S:      Maintained

TOSHIBA SMM DRIVER
P:      Jonathan Buzzard
M:      jonathan@buzzard.org.uk
L:      tlinux-users@tce.toshiba-dme.co.jp
W:      http://www.buzzard.org.uk/toshiba/
S:      Maintained

More public documentation is a great first step.
But Toshiba could make a huge improvement in Linux support by hiring
just a couple of programmers to help develop and support platform specific
drivers for Toshiba systems in upstream Linux.

-Len

