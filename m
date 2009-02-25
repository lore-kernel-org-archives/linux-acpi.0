From: Charles@schwieters.org
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 15:18:30 -0500
Message-ID: <E1LcQD8-0005G4-JZ@tan.cit.nih.gov>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk> <20090225172835.GA7152@srcf.ucam.org> <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk> <20090225175923.GB7836@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailfwd.nih.gov ([128.231.90.107]:6860 "EHLO
	nihrelayxway2.hub.nih.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442AbZBYUSf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 15:18:35 -0500
In-reply-to: <20090225175923.GB7836@srcf.ucam.org> 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Buzzard <jonathan@buzzard.me.uk>, Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> 
> > A "proper" kernel driver as you put it is is completely inappropriate.
> > You want to unnecessarily pollute the kernel with hundreds of lines of
> > code for no actual gain in functionality.
> 
> Yes. I want a proper kernel driver.
> 

I can definitely see reasons for putting it in the kernel, and I welcome
anyone who implements this solution. However, I don't think it will
happen. I no longer have time for this sort of work, and no one else has
stepped up in the past five years. I am willing to live with the
half-ass out-of-tree solution, so it sounds like that will be the way
things stay.

bummer--

Charles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJpaeWPK2zrJwS/lYRAnhDAJ9yb8ecbgm8LcvQF6oEBPR4fEZ1jgCfYb3U
0QOkmdwb/NRoM5niqNOBJlA=
=wd7q
-----END PGP SIGNATURE-----
