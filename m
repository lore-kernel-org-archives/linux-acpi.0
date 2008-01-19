From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 10:08:30 -0200
Message-ID: <20080119120830.GA16308@khazad-dum.debian.net>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60753 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551AbYASMIh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 07:08:37 -0500
Content-Disposition: inline
In-Reply-To: <200801190240.45718.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Sat, 19 Jan 2008, Len Brown wrote:
> and if they did, nobody updates their bios anyway.

Actually, that only depends on us.  If you drop support for people using
known-bad BIOS versions that give you greif, they have no choice but to go
away, or to upgrade.  And so far, I have never had anyone complain that they
had to update their thinkpad BIOS and just go away.

Of course, I am terribly nice about it when I ask someone to upgrade their
BIOS, but still...

On the thinkpad-specific case, I don't actually mind tracking down the
last-known-sane BIOS version for every thinkpad model and bitching like a
madman on thinkpad-acpi telling people to update because it is known buggy
and unsupported if their BIOS is too old.  We already sort of track every
important BIOS version of every model anyway in ThinkWiki...

I can easily see the T61 and X61 as prime candidates for a "upgrade the BIOS
before reporting any bugs" printk.

> > Perhaps if there was a well documented, "this is what we want" from
> > the Linux community, which can then get communicated to Lenovo, HP,
> > Dell, etc.?  This document could include a request that Laptop vendors
> > document how various things work when they do vendor-specific things,
> > and also documenting what Linux is doing today because we believe it's
> > what is the Windows-compatible behaviour.
> 
> vendors who care about Linux run this:
> 
> http://linuxfirmwarekit.org/
> 
> So I think if shout there, then it we'll be heard.

Indeed.  But are we allowed to drop support on any BIOS that fails those
checks as soon as there is a new version of that BIOS that doesn't?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
