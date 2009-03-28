From: Norbert Preining <preining@logic.at>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 09:33:15 +0100
Message-ID: <20090328083315.GF9057@gamma.logic.tuwien.ac.at>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:58093 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbZC1Idi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 04:33:38 -0400
Content-Disposition: inline
In-Reply-To: <20090328013832.GA4778@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, sony-vaio-z-series@lists.launchpad.net, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sa, 28 M=E4r 2009, Matthew Garrett wrote:
> > What about the speed/stamina stuff -- is anybody testing it?
>=20
> The speed/stamina stuff isn't Sony specific. I'm working on an extern=
al=20
> module to handle that.

I am testing that, but we are far from having a working thingy,
currently on the sony z11 the nvidia (the second, the speed card) is no=
t
working without acpi/dsdt tricks (but Matthias might correct me).

Matthew, if you have something to test I am, as usual open for any
tests, but I am aways 2 weeks. In these 2 weeks I hope I get back my
z11, it broke the SECOND time in 6 months, harddisc bad sector errors.
I am wondering if SATA link management, laptop tools, etc etc could
interfere with that.

Just a warning for all the Sony guys with Z11, make decent backups,
waiting for ddrescue is a pain. 2 times in 6 month sudden death of hard
disk.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Te=
chnology
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
The main reception foyer was almost empty but Ford
nevertheless weaved his way through it.
                 --- Ford making his way out of Milliways whilst under =
the
                 --- influence of enough alchol to make a rhino sing.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
