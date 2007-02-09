From: Len Brown <lenb@kernel.org>
Subject: Re: CoreDuo Bus-Master-Activity on Core1 ffffffff when idle, no C3
Date: Fri, 9 Feb 2007 01:54:02 -0500
Message-ID: <200702090154.02351.lenb@kernel.org>
References: <1170989226.4546.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53111 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946160AbXBIGzV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 01:55:21 -0500
In-Reply-To: <1170989226.4546.17.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sascha Heid <saschaheid@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 08 February 2007 21:47, Sascha Heid wrote:
> Hi List!
> 
> 
> i recently got a Lenovo X60T, installed Gentoo Linux, and since then i
> am trying to figure out why i miss 2h of battery-life compared to
> Windows-Users. After a while i noticed that the Bus-Master-Activity on
> CPU1 is ffffffff when its idle and only drops if i give it some work to
> do (like a kernel compile with make -j3)
> When i put some load on both cores the Bus Master Activity of CPU1 is
> normalizing itself and varies according to the load. 
> When i leave the Laptop idle for a while it gets actually hotter (60C)
> then when i use it (44C).
> The CPU is not able to stay in C3, it tries but comes back to C2 within
> the second, i assume that is because of the high Bus Master Activity of
> CPU1?
> 
> I have already looked for help about this on various forums and mailing
> lists and i talked to other people with CoreDuo's and they do not have
> this issue with the Bus Master Activity.
> 
> I tried alot of different kernels (2.6.19 and 2.6.20) and setups or used
> preconfigured Kernels or even Live-Distros.
> I also booted a *very* minimal Gentoo-Linux setup, no WLAN, no USB, no X
> etc., and played with the BIOS-Settings (disabling as much as possible),
> and now i am at a point where i really dont know what to do anymore and
> i fear that im not getting any answers anywhere.
> 
> If anyone has any advice, information or would like to see some logs or
> configs, i would be very gratefull.
> 
> Greetings from Germany,
> Sascha

Try disconnecting usb devices until lsusb shows nothing.

cheers from Boston,
-Len

