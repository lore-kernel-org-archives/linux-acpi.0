From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Fri, 23 Apr 2010 23:01:13 -0300
Message-ID: <20100424020113.GB8755@khazad-dum.debian.net>
References: <1272062884.1594.73.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50231 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751763Ab0DXCLR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Apr 2010 22:11:17 -0400
Content-Disposition: inline
In-Reply-To: <1272062884.1594.73.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 23 Apr 2010, Jerone Young wrote:
> This patch fixes that mute keys for X & R & W series Thinkpads. For
> these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
> switch the functionality of the mute key to send a mute key press to the
> OS. These machines will not be getting any bios updates in the future.

Lenovo is getting really cheap those days if they now kill a BIOS that
isn't even two years old.

> All of these Thinkpads do not have a little light that would indicate
> the mute is on. So having them send the mute key to the OS makes a
> better user experience and also will match behavior of newer Thinkpads.
> These all have the same quirk the T400 & T500 have.

Depends on how the key behaves.  Does the EC change from mute always
mutes (and vol up/down unmutes) mode to mute does nothing (and thus you
can dumb it down into a toggle) depending on OSI(Linux) ?

Also, should I scrap any support for Lenovo mute-only hardware mixers?
OSI(Linux) seems to break it badly (but I'd appreciate some extensive
testing of this, if you can do it... regular users often can't get
userspace to quiet down enough to test it without external influences
and I get mixed reports).  Bit 6 of EC register 0x30 should control
speaker muting.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
