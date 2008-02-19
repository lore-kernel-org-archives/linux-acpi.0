From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 11:26:23 +0100
Message-ID: <1203416783.2764.14.camel@linux-2bdv.site>
References: <200801171504.26361.lenb@kernel.org>
	 <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org>
	 <20080119120830.GA16308@khazad-dum.debian.net>
	 <20080119141727.GJ28387@mit.edu>
	 <20080119153304.GA27060@khazad-dum.debian.net>
	 <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu>
	 <20080120194919.GE19295@khazad-dum.debian.net>
	 <1203353902.6019.119.camel@queen.suse.de>
	 <20080218191729.GB9724@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:59522 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbYBSK00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 05:26:26 -0500
In-Reply-To: <20080218191729.GB9724@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Theodore Tso <tytso@MIT.EDU>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>


On Mon, 2008-02-18 at 16:17 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 18 Feb 2008, Thomas Renninger wrote:
> > The problem is that OSI is used by Windows to pass the exact Window=
s
> > (not OS) version they are running, this function should be called W=
OSI.
> > We of course want to run on the latest fix-ups here and should pass
> > "Windows 2006" (or whatever latest string there exists).
> >=20
> > IMO we need the same for Linux.
> > We even have the advantage, that the string in LOSI(String) makes s=
ome
> > sense, e.g. 2.6.24, so why not use LOSI(int, int, int)
> > How the exact interface might look like I am not sure, just an idea=
=2E
>=20
> Looks quite a bad idea IMO.  2.6.24 means what?  SuSE's?  Mainline's?
> Debian's?  At what patch level?  With which user patches tacked on to=
p?  And
> at what level of userspace support (X.org can make a LOT of differenc=
e
> here)?

So you think on next Lenovo pre-load we should compile a "SLED10 SP2"
into our kernel and let Lenovo BIOS fixups use it? E.g. we could use th=
e
default BCM/BQC/BCL brightness interface easily then, just a small
if(SLED10_SP2) in the BIOS. A one-liner, it can only effect the very
specific Lenovo models that are effected. This is much more appropriate
then adding a backport, better say "most dirty hack of the
month" (That's not your fault Henrique and by no means meant as an
offence..., we both know about the ugliness of these BIOS workarounds)
of ibm_acpi to 2.6.16! guessing brightness levels which has high risk t=
o
break other ThinkPads and even if not, you move all the QA (not much to
do if embedded into such Linux/SUSE/kern_ver condition), and dirty hack=
s
to the vendor...).

Please let us not end up with hacks like =EF=BB=BF"SLED10 SP2", "FEISTY=
" or
whatever weirdness and this will come if we ignore osi=3Dlinux or do no=
t
provide something else.
We should make up something more robust and more Linux kernel
appropriate and propagate it to the vendors.

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
