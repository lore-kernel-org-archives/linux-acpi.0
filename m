From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 13:33:04 -0200
Message-ID: <20080119153304.GA27060@khazad-dum.debian.net>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40544 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760744AbYASPdK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 10:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20080119141727.GJ28387@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Sat, 19 Jan 2008, Theodore Tso wrote:
> On Sat, Jan 19, 2008 at 10:08:30AM -0200, Henrique de Moraes Holschuh wrote:
> > Actually, that only depends on us.  If you drop support for people using
> > known-bad BIOS versions that give you greif, they have no choice but to go
> > away, or to upgrade.  And so far, I have never had anyone complain that they
> > had to update their thinkpad BIOS and just go away.
> > 
> > Of course, I am terribly nice about it when I ask someone to upgrade their
> > BIOS, but still...
> > 
> > On the thinkpad-specific case, I don't actually mind tracking down the
> > last-known-sane BIOS version for every thinkpad model and bitching like a
> > madman on thinkpad-acpi telling people to update because it is known buggy
> > and unsupported if their BIOS is too old.  We already sort of track every
> > important BIOS version of every model anyway in ThinkWiki...
> 
> More importantly, what worries me is exactly the issue which Len
> raised; what if OSI(Linux) enables some things that we desperately
> want, and at the same time, enables some things that we don't want?

That worries me as well.  On the ThinkPad case, that means we need to move
*fast* and reach an agreement with Lenovo, while they are still actively
developing the current crop of BIOSes.

Which means we need to agree among ourselves on a course of action,
*document it* properly, check with Lenovo and any other vendor which is
reasonably Linux-friendly if it is something they can agree to use, and get
it into the firmware kit.

> Tradeoffs either way!

Yes.  This is no easy problem asking for a quick hack as a solution.  It is
not impossible to solve, but it will definately require more than hacks on
our side to get it done properly.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
