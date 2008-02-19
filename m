From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Mon, 18 Feb 2008 19:26:57 -0500
Message-ID: <20080219002657.GO25098@mit.edu>
References: <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <20080120194919.GE19295@khazad-dum.debian.net> <1203353902.6019.119.camel@queen.suse.de> <20080218191729.GB9724@khazad-dum.debian.net> <1203379259.3971.90.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.org ([69.25.196.31]:43646 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750889AbYBSA1r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Feb 2008 19:27:47 -0500
Content-Disposition: inline
In-Reply-To: <1203379259.3971.90.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, Feb 19, 2008 at 01:00:59AM +0100, Thomas Renninger wrote:
> 
> Most stuff that gets fixed by these workarounds would make no sense to
> backport, because backports are much too intrusive, e.g.:

Many of the workarounds really aren't that hard to backport, and the
reality is after the distro locks down their kernel version in stone,
and people start complaining about buggy support for the X300 laptop,
or some such, the temptation will be *very* high to put in special
hacks in the thinkpad_acpi driver for some bleeding edge new laptop by
backporting code from a newer kernel, or grabbing a patch which is
being discussed on the linux-thinkpad list, etc.

So I don't think it's a good idea to assume that a single kernel
version string such as 2.6.25 will have any reliability whatsoever
about identifying what sort of driver workarounds might or might not
be present given a particular distribution or custom kernel compiled
by a user.  (I normally pull in the acpi test tree into my kernels, so
often my "2.6.25" kernel will have stuff that might not show up until
2.6.26.)

Regards,

						- Ted
