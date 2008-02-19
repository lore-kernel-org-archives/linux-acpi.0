From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 07:34:24 +0100
Message-ID: <1203402864.2870.18.camel@linux-2bdv.site>
References: <200801190240.45718.lenb@kernel.org>
	 <20080119120830.GA16308@khazad-dum.debian.net>
	 <20080119141727.GJ28387@mit.edu>
	 <20080119153304.GA27060@khazad-dum.debian.net>
	 <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
	 <20080120194919.GE19295@khazad-dum.debian.net>
	 <1203353902.6019.119.camel@queen.suse.de>
	 <20080218191729.GB9724@khazad-dum.debian.net>
	 <1203379259.3971.90.camel@linux-2bdv.site> <20080219002657.GO25098@mit.edu>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:45887 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbYBSGe2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 01:34:28 -0500
In-Reply-To: <20080219002657.GO25098@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>


On Mon, 2008-02-18 at 19:26 -0500, Theodore Tso wrote:
> On Tue, Feb 19, 2008 at 01:00:59AM +0100, Thomas Renninger wrote:
> >=20
> > Most stuff that gets fixed by these workarounds would make no sense=
 to
> > backport, because backports are much too intrusive, e.g.:
>=20
> Many of the workarounds really aren't that hard to backport,
It's not about how hard, it is about the risk.
And you never want to backport e.g. AML fixes in the very heart of the
interpreter. Even Intel run it through all their verification suites it
will break the one or other certified machine.

If instead a small junk of AML code can be written and the vendor embed=
s
it, in a for him safe "if(linux)" environment... that would be cool.
=46or the vendor and for the distributions, not needing another
quirk/blacklist whatever ugly hack.
>  and the
> reality is after the distro locks down their kernel version in stone,
> and people start complaining about buggy support for the X300 laptop,
> or some such, the temptation will be *very* high to put in special
> hacks in the thinkpad_acpi driver for some bleeding edge new laptop b=
y
> backporting code from a newer kernel, or grabbing a patch which is
> being discussed on the linux-thinkpad list, etc.
This is about support, right? The thing Len is always propagating which
is so important for distributions...

The ThinkPad drivers backports are huge.
I didn't take the backports because of this.
The thinkpad driver is not that important..., newer models should work
and it only affects the thinkpad driver, the some thousand line changes
will break some machines for sure and regressions is the worst thing to
have after a product came out.
But maybe this is even doable for e.g. 10.3.
A backport of AML fixes affecting every machine is impossible to do in
an update for RedHat or SUSE =EF=BB=BFEnterprise products or whatever r=
eally
stable release is impossible to do.

Next point:
E.g. evaluation of whether to take 7 or 15 brightness levels is a dirty
hack. In fact most of the Thinkpad driver is a dirty hack. Now that
vendors care about supporting the systems, why not moving dirty hacks
into the BIOS?

> So I don't think it's a good idea to assume that a single kernel
> version string such as 2.6.25 will have any reliability whatsoever
> about identifying what sort of driver workarounds might or might not
> be present given a particular distribution or custom kernel compiled
> by a user.  (I normally pull in the acpi test tree into my kernels, s=
o
> often my "2.6.25" kernel will have stuff that might not show up until
> 2.6.26.)
A vendor sells a machine pre-loaded with a specific product which is
bound to a specific kernel!

Do you pay money if your kernel breaks machines at least for
regressions?
Ok you at least take customer calls or better mails :)
=2E..

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
