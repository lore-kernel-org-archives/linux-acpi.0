From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 22 Jan 2008 00:37:53 -0500
Message-ID: <200801220037.53381.lenb@kernel.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <20080121190041.GD29792@mit.edu> <20080121193755.GA11492@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43976 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbYAVFig (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2008 00:38:36 -0500
In-Reply-To: <20080121193755.GA11492@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Theodore Tso <tytso@mit.edu>, Tomas Carnecky <tom@dbservice.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Monday 21 January 2008 14:37, Matthew Garrett wrote:
> On Mon, Jan 21, 2008 at 02:00:41PM -0500, Theodore Tso wrote:
> 
> > Well, unless until Video card vendors give us their secret interfaves
> > to reinitialize their cards, we're never going to figure it out,
> > right?  
> 
> There's (not yet mainline) code to do this on Intel, and it looks like 
> AtomBios based ATIs (some r400s, all r500s and later) should be trivial. 
> The work the Nouveau people have been doing is also very promising, and 
> I suspect we can do cold boot there before too long. I was going to do 
> some work on this this week, but my ATI machine got stolen...
> 
> > At least for vendors like Lenovo, where some laptops will be
> > shipping with Intel cards where we will eventually be able do our own
> > video reinit after suspend, and some with Nvidia chipsets where it
> > doesn't seem terribly likely until someone at Nvidia has a change of
> > heart, the BIOS won't be able to use the "please reinit video" as a
> > general "Linux" indicator, since they will need to support laptops
> > with Good as well as Evil graphics chipsets.  :-)
>  
> The problem is that we don't inherently know if we can support 
> reinitialising video natively until the video driver is loaded, and 
> there's a high probability that that's going to come from a module. 
> We're already executing ACPI by then, so the firmware's had the 
> opportunity to stash an incorrect value and can blow everything up later 
> on. 

Right, if we go down this path, we'd have to do it as a boot parameter
in order to enable/disable the hook before any platform AML
gets a chance to see it.

note that acpi_osi=string and acpi_osi=!string
are available starting in 2.6.23.  You get to add
up to 1 string, and you get to remove as many pre-existing
strings as you like.

of course, this trick would require the distro installer
to know tha a native-video driver were present, and
modify the bootparms accordingly.

> If vendors want their laptops to work on Linux, then the best thing  
> they can do is help us get our drivers working properly.

True.  For Intel graphics, Intel/OTC is working on getting this fixed.
It has not been a quick fix -- the pipeline is long...

Maybe the quick fix is to enhance the workarounds
in s2ram and simply deal with it that way until native video
drivers are available?

> Now, stuff like a standardised entrypoint into ACPI that reinitialises 
> the video - that would be helpful, since we could choose whether to call 
> it or not which means whether or not something gets screwed up is 
> determined by us and not the vendor.

Even if we (Linux) proposed this and it got added to the spec,
it wouldn't have any real effect b/c windows doesn't need it,
so most machines wouldn't implement it.  Smarter native video
drivers is clearly the preferred path.

-Len

