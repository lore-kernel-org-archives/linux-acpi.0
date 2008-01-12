From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Lenovo ThinkPads need acpi_osi="Linux"
Date: Sat, 12 Jan 2008 18:23:58 -0200
Message-ID: <20080112202358.GC13376@khazad-dum.debian.net>
References: <20080112022348.GC27524@khazad-dum.debian.net> <200801120416.08631.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57999 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761069AbYALUYE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 15:24:04 -0500
Content-Disposition: inline
In-Reply-To: <200801120416.08631.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 12 Jan 2008, Len Brown wrote:
> > Lenovo has been attempting to make things a bit easier for Linux on their
> > ThinkPads, by disabling the more obnoxious behaviours of the firmware (used
> > by their Windows drivers) when in Linux.  It looks like they used the OSI
> > string for that.

[...]

> > The most concrete example I have right now of changed behaviour is the Mute
> > key on the T61, which just plain disappears if acpi_osi="!Linux" (2.6.23
> > default).

[...]

> I discussed this with Lenovo a few months ago
> and made it clear that Linux will unlikely
> default to answer yes to OSI(Linux) in the future --
> for all the reasons I stated when I disabled it.
> 
> However, they told me they wanted to use OSI(Linux)
> to enable the backlight (via video re-post) on S3 resume,
> and the problem at hand was a distro kernel which still
> had OSI(Linux), so that is what they did.
> 
> I was unaware that they're using it for anything else,
> and the fact that they are lends further support to
> the case that as an OS interface string "Linux"
> is too vague to be meaningful.
> 
> They seemed open to looking for another string, say
> "Needs S3 video re-post".  However, we didn't
> agree on such a string, and so it isn't in Linux
> or the Lenovo BIOS.
> 
> I think until we have native Linux graphics driver for (fast)
> backlight restore, we need to add a DMI to enable OSI(Linux)
> for the offending Lenovo models.   We'll need to have
> some coordination with the graphics guys so that they
> can turn this off from user-space when they don't need it.

Unless we get them to lay off using OSI(Linux) altogether, that won't work
well.  You'd stop the slow POST on S3 resume, but you'd also change the
behaviour of the firmware somewhere else too (not to mention it is useless
to change the OSI string in most AML code I've seen after you ran the _INI
stuff).

It would have been way easier if ACPI had a more complete and thought-out
video control API.  There should be a way to request a BIOS re-post of the
video hardware through an optional ACPI call.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
