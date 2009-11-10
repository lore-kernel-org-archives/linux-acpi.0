From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ltp] Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 07:24:18 -0200
Message-ID: <20091110092418.GC1872@khazad-dum.debian.net>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
 <20091109165420.GA28672@srcf.ucam.org>
 <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
 <20091109175416.GA29887@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44231 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbZKJJYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2009 04:24:16 -0500
Content-Disposition: inline
In-Reply-To: <20091109175416.GA29887@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 09 Nov 2009, Matthew Garrett wrote:
> When you hit the mixer button, does the ACPI interrupt count increase? 
> If so, we're certainly in a position to do something with it.

It is supposed to go over the KDC.  But I would be _really_ interested on
any events related to volume key presses on the X200s.  I expect it is
issuing one of the ACPI volume notification events with OSI(Linux), and none
without.

> But it does nothing to solve the underlying issue, and then we get to 
> apply the same patch again for the next Thinkpad product cycle. If we 
> fix it properly, we don't need to bother.

If I get a full description of behaviour, etc.  I can simply ask Lenovo
about it.

AFAIK, the native volume control through windows is being done in a
different way, nowadays.  I'd need to know, without OSI(Linux), where the
events are going.  That'd be enough to know when to read EC 0x30 and check
if it is now mute/unmute.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
