From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Mon, 14 Jul 2008 22:09:53 +0200
Message-ID: <200807142209.54841.rjw@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <487A67C3.50000@zytor.com> <487AD37A.2050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45903 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756319AbYGNUH5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 16:07:57 -0400
In-Reply-To: <487AD37A.2050903@zytor.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andy Lutomirski <luto@myrealbox.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ingo Molnar <mingo@elte.hu>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

On Monday, 14 of July 2008, H. Peter Anvin wrote:
> H. Peter Anvin wrote:
> > 
> > The most likely explanation for this is that the VESA BIOS expects to be 
> > entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real 
> > Mode.  Here is a completely untested patch which changes the segment 
> > descriptors to Big Real Mode instead.  It would be worth testing out.
> > 
> 
> ... and here is one that actually has a prayer of actually working.

It works on my box and if that's the same as the one you attached to the
Bugzilla entry, it has also been reported to work on an X61s.

Thanks,
Rafael
