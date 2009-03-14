From: Charles@Schwieters.org
Subject: Re: experimental patch for toshiba_acpi
Date: Fri, 13 Mar 2009 20:37:57 -0400
Message-ID: <E1LiHt0-0002m2-2l@oaf.wireless>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com> <1235657022.3802.86.camel@hughsie-work.lan> <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk> <1235753349.5444.53.camel@localhost.localdomain> <20090228151933.GC17541@khazad-dum.debian.net> <alpine.LFD.2.00.0903122102490.24376@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:38330 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761605AbZCNAjx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Mar 2009 20:39:53 -0400
In-reply-to: <alpine.LFD.2.00.0903122102490.24376@localhost.localdomain> 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Jonathan Buzzard <jonathan@buzzard.me.uk>, John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Len Brown <lenb@kernel.org> wrote:

> However, I'm not excited about extending toshiba_acpi to
> include /dev/toshiba SMM interface that is already
> provided by the toshiba driver.
> 
> I'd rather see the 'toshiba' driver (perhaps renamed to be toshiba_smm)
> extended so that it is the only driver to provide this interface.
> 

no objection here. I'd just like to have a working solution.

> BTW. I notice that both toshiba_acpi and toshiba ship in Fedora
> and can load on my satellite pro.  However, fedora doesn't ship
> toshset -- is toshiba and /dev/toshiba useful without it?

toshiba_acpi does provide support for a few of the bios settings through
entries in /proc/acpi/toshiba.

> 
> Are new machines still using this interface, or it is going away over 
> time?
> 

It seems that most laptops in the Tecra and Portege lines have this
interface. Many (most?) of the recent Satellites have a Phoenix
Bios which do not support this interface. Most recently, it seems that
some toshiba machines have Insyde BIOS.

Charles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJuvxlPK2zrJwS/lYRAtEGAJsEMSCMZvVe6FiFUF7QW2Zc2Y3I1ACfV3c0
bjBVX77ycCHz0qC6SF4wwhU=
=cx50
-----END PGP SIGNATURE-----
