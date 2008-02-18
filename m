From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 18 Feb 2008 16:17:29 -0300
Message-ID: <20080218191729.GB9724@khazad-dum.debian.net>
References: <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <20080120194919.GE19295@khazad-dum.debian.net> <1203353902.6019.119.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34778 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000AbYBRTRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 14:17:39 -0500
Content-Disposition: inline
In-Reply-To: <1203353902.6019.119.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 18 Feb 2008, Thomas Renninger wrote:
> The problem is that OSI is used by Windows to pass the exact Windows
> (not OS) version they are running, this function should be called WOSI.
> We of course want to run on the latest fix-ups here and should pass
> "Windows 2006" (or whatever latest string there exists).
> 
> IMO we need the same for Linux.
> We even have the advantage, that the string in LOSI(String) makes some
> sense, e.g. 2.6.24, so why not use LOSI(int, int, int)
> How the exact interface might look like I am not sure, just an idea.

Looks quite a bad idea IMO.  2.6.24 means what?  SuSE's?  Mainline's?
Debian's?  At what patch level?  With which user patches tacked on top?  And
at what level of userspace support (X.org can make a LOT of difference
here)?

No, if you are going to go about that, use OSI to ask about specific support
you need, like Len said.  Yes, this might mean a lot of OSI strings.

> A)
> Vendors *must* have a flag for Linux to be able to provide proper
> support for multiple kernels and to be able to provide easy and riskless
> fixes for Linux at all.

You need it to be more fine-grained than that, a LOT more fine-grained.

> I expect we now have this problem because nobody (including myself)
> never dreamed of that it could ever happen that a vendor adds Linux
> specific AML code.

Then WTF did we start shipping an OSI(Linux) string in the first place?
Don't tell me it was done just for the heck of it.

> But now that it happens we should react quickly and come up with a
> robust interface for the future...

Len already explained what is needed, and I added how to do it in a way that
it would be accepted from my experience with vendors.

Basically, it needs to be fine-grained and function-specific, AND it must be
allow for near-perfect backward and forward compatibility or it will be a
lot more difficult to see it get any use.

> > Now, the real test will be if we ask for something that would require
> > changing their Windows drivers.  I sure hope they would do it, but...
> Yep nobody would ever do this.

I have some doubts about the "nobody", but you'd have to present a heck of a
good case.

BTW, I am perfectly happy with OSI(Linux) being used to disable crap that is
only relevant to work around *bugs* in windows drivers.  But that's not how
most vendors use it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
