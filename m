From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 21 Jan 2008 19:37:55 +0000
Message-ID: <20080121193755.GA11492@srcf.ucam.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801192313.10296.lenb@kernel.org> <47933886.7050401@dbservice.com> <200801201331.59478.lenb@kernel.org> <20080121015238.GA8105@mit.edu> <20080121095000.GA2785@srcf.ucam.org> <20080121190041.GD29792@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43022 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYAUTiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 14:38:16 -0500
Content-Disposition: inline
In-Reply-To: <20080121190041.GD29792@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Len Brown <lenb@kernel.org>, Tomas Carnecky <tom@dbservice.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Mon, Jan 21, 2008 at 02:00:41PM -0500, Theodore Tso wrote:

> Well, unless until Video card vendors give us their secret interfaves
> to reinitialize their cards, we're never going to figure it out,
> right?  

There's (not yet mainline) code to do this on Intel, and it looks like 
AtomBios based ATIs (some r400s, all r500s and later) should be trivial. 
The work the Nouveau people have been doing is also very promising, and 
I suspect we can do cold boot there before too long. I was going to do 
some work on this this week, but my ATI machine got stolen...

> At least for vendors like Lenovo, where some laptops will be
> shipping with Intel cards where we will eventually be able do our own
> video reinit after suspend, and some with Nvidia chipsets where it
> doesn't seem terribly likely until someone at Nvidia has a change of
> heart, the BIOS won't be able to use the "please reinit video" as a
> general "Linux" indicator, since they will need to support laptops
> with Good as well as Evil graphics chipsets.  :-)
 
The problem is that we don't inherently know if we can support 
reinitialising video natively until the video driver is loaded, and 
there's a high probability that that's going to come from a module. 
We're already executing ACPI by then, so the firmware's had the 
opportunity to stash an incorrect value and can blow everything up later 
on. If vendors want their laptops to work on Linux, then the best thing 
they can do is help us get our drivers working properly.

Another disadvantage is that there's no real chance that Linux will be 
tested in the "No, really, I can handle my graphics myself" case. 
Relying on their firmware guys to get this right is inviting the fuckup 
fairy to come and start nesting - Lenovo have already shown us what 
happens when we let vendors try to be clever.

Now, stuff like a standardised entrypoint into ACPI that reinitialises 
the video - that would be helpful, since we could choose whether to call 
it or not which means whether or not something gets screwed up is 
determined by us and not the vendor.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
