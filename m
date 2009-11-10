From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ltp] Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 12:42:42 +0000
Message-ID: <20091110124242.GB18631@srcf.ucam.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com> <20091109165420.GA28672@srcf.ucam.org> <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com> <20091109175416.GA29887@srcf.ucam.org> <20091110092418.GC1872@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49002 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbZKJMmr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 07:42:47 -0500
Content-Disposition: inline
In-Reply-To: <20091110092418.GC1872@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Nov 10, 2009 at 07:24:18AM -0200, Henrique de Moraes Holschuh wrote:

> It is supposed to go over the KDC.  But I would be _really_ interested on
> any events related to volume key presses on the X200s.  I expect it is
> issuing one of the ACPI volume notification events with OSI(Linux), and none
> without.

It appears over the KDC when OSI(Linux) is passed, and doesn't 
otherwise.

> AFAIK, the native volume control through windows is being done in a
> different way, nowadays.  I'd need to know, without OSI(Linux), where the
> events are going.  That'd be enough to know when to read EC 0x30 and check
> if it is now mute/unmute.

Yeah. There's clearly some way to hook this (given that it works in 
Windows when the Thinkpad-specific driver is installed) - I'll try to 
find a recent machine to test.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
