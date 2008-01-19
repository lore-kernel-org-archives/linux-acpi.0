From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 09:17:27 -0500
Message-ID: <20080119141727.GJ28387@mit.edu>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35348 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752278AbYASOSw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 09:18:52 -0500
Content-Disposition: inline
In-Reply-To: <20080119120830.GA16308@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Sat, Jan 19, 2008 at 10:08:30AM -0200, Henrique de Moraes Holschuh wrote:
> 
> Actually, that only depends on us.  If you drop support for people using
> known-bad BIOS versions that give you greif, they have no choice but to go
> away, or to upgrade.  And so far, I have never had anyone complain that they
> had to update their thinkpad BIOS and just go away.
> 
> Of course, I am terribly nice about it when I ask someone to upgrade their
> BIOS, but still...
> 
> On the thinkpad-specific case, I don't actually mind tracking down the
> last-known-sane BIOS version for every thinkpad model and bitching like a
> madman on thinkpad-acpi telling people to update because it is known buggy
> and unsupported if their BIOS is too old.  We already sort of track every
> important BIOS version of every model anyway in ThinkWiki...

More importantly, what worries me is exactly the issue which Len
raised; what if OSI(Linux) enables some things that we desperately
want, and at the same time, enables some things that we don't want?
Maybe it's OK for now to have lots of model specific workarounds
regarding whether we throw the Big Binary Switch of OSIL(Linux), but
what if in the future that's not enough. 

It may be hard to make vendors change designs mid-course, yes, but it
may be even harder in the future, and even more of a disaster.  Maybe
the answer is we don't use OSI(Linux) in the future, but we use a
series of OS compatibility OSI switches.  Even then, we'll need to
know when we should use OSI(Linux), and when we don't, which means
we'll have to track BIOS versions.  I almost wonder if we're better
not putting any model-specific versions at all, and then work really
hard to influence the vendors, as opposed to a "half-way pregnant"
approach where we whitelist individual models, but not BIOS
versions....

Tradeoffs either way!

> > vendors who care about Linux run this:
> > 
> > http://linuxfirmwarekit.org/
> > 
> > So I think if shout there, then it we'll be heard.

Sure --- do we have the right language in linuxfirmwarekit.org to talk
about issues such as Windows- and Linux- specific behaviours and how to
handle OSI(<foo>) issues?

							- Ted
