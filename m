From: Luca Capello <luca@pca.it>
Subject: Re: Critical temp shutdowns on ThinkPad X60 1706-GMG
Date: Thu, 31 Jul 2008 15:28:51 +0200
Message-ID: <87od4etc6k.fsf@gismo.pca.it>
References: <200807301556.01815.trenn@suse.de>
 <20080730175227.GA13850@khazad-dum.debian.net>
 <87zlnyv14h.fsf_-_@gismo.pca.it> <200807311439.46393.trenn@suse.de>
 <871w1aurwc.fsf@gismo.pca.it> <20080731131512.GI5347@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.unige.ch ([129.194.9.224]:50325 "EHLO victor.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738AbYGaN24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 09:28:56 -0400
Received: from gismo.pca.it ([129.194.56.110])
 by victor.unige.ch (Sun Java(tm) System Messaging Server 6.3-5.02 (built Oct
 12 2007; 32bit)) with ESMTPSA id <0K4V00L1LHG7NO00@victor.unige.ch> for
 linux-acpi@vger.kernel.org; Thu, 31 Jul 2008 15:28:55 +0200 (MEST)
In-reply-to: <20080731131512.GI5347@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ak@linux.intel.com, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

--=-=-=

Hi Ted!

On Thu, 31 Jul 2008 15:15:12 +0200, Theodore Tso wrote:
> On Thu, Jul 31, 2008 at 03:04:03PM +0200, Luca Capello wrote:
>> I read the list, thanks.  I was so surprised that no one reported this
>> issue before and I've already planned to deal with it during
>> DebCamp8/DebConf8 (starting on Sunday, Aug 3rd [2]).
>
> One possibility is that it's a hardware problem; for example, it could
> be that your heat sink on the CPU or GPU didn't have enough thermal
> compound installed, or some such.

In that case I'd try to have it repaired ;-)

> I have an X61s, which has a different BIOS series and a low-voltage
> CPU chip, so it's not directly comparable, but I can say that I've not
> had any problems even when I've loaded the CPU significantly.

OK, if you want to give a try to my test case:

  $ [install darcs]
  $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript.upstream/
  $ darcs get http://alioth.debian.org/~gismo/darcs-pull-bug/parenscript/
  $ cd parenscript
  $ darcs pull ../parenscript.upstream/
    [choose to apply only the first patch]

At that point, darcs takes 100% of the CPU and temperature starts to
rise :-(

FWIW, the same process on a PIII-500 is running for more than 5819
*hours* and it haven't finished nor spotted an error, yet.

> Of course, I also use mainline kernels and not Debian kernels.  One
> thing that you might try to do while you are at DebConf is to see if
> you can find other people with the same laptop model and see if they
> can duplicate the problem on their machine, so you can try varying
> both the Debian/non-debian kernel, as well as trying to see if you can
> reproduce the problem on multiple laptops.

This was exactly my idea: I already know that at least another X60
Debian Developer will be at DebConf8, this is another reason I waited.

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkiRvhMACgkQZwOMsWhEDTPxwgP+KEB0/XnqWEambjtUlO27Z2CG
UbrhZyO85xw48n1DMhVYSwmuB9bOnyJI3u53Y/6IUUuknIK3BDPbhh8v8TIGUEsA
WmhWLkyQpZWGzEw7sYxdzpU5qPJF5JecpcjpW429nZAoDEpNDI/jQiQ96YXvPRXN
5Liou23A4pXc3PInvzQ=
=JRo9
-----END PGP SIGNATURE-----
--=-=-=--
