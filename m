From: Charles@Schwieters.org
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 28 Feb 2009 13:00:26 -0500
Message-ID: <E1LdTUB-0007ck-1n@oaf.wireless>
References: <200902280015.17286.arvidjaar@mail.ru> <E1LdAJL-0003Jk-EQ@tan.cit.nih.gov> <200902280913.45040.arvidjaar@mail.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:44893 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753050AbZB1SBe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Feb 2009 13:01:34 -0500
In-reply-to: <200902280913.45040.arvidjaar@mail.ru> 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> On 28 ??????? 2009 00:31:59 Charles@schwieters.org wrote:
> > Hello Andrey--
> >
> > > >This patch comes from
> > > > http://memebeam.org/free-software/toshiba_acpi/. With this patch,
> > > > the module conflicts with the toshiba module (which works only on
> > > > non-acpi-enabled kernels).
> > >
> > > Could you please elaborate? Because (Portege 4000):
> > >
> > > {pts/2}% lsmod | grep tosh
> > > toshiba                 4012  0
> > > toshiba_acpi            7540  0
> > > rfkill                 10480  1 toshiba_acpi
> > > backlight               4560  2 toshiba_acpi,video
> > > input_polldev           4012  1 toshiba_acpi
> > > {pts/2}% sudo fan
> > > Fan is on.
> >
> > My understanding is that with the experimental patch, both toshiba
> > and toshiba_acpi use /dev/toshiba. Do you have the experimental patch
> > applied? Does fan work if you remove the toshiba module?
> >
> 
> May be I misunderstood you then; do you mean that *if* this patch is 
> applied module toshiba works on non-ACPI kernels only? That would be the 
> case then.

that's right.

> 
> But then I do not understand why you need this in toshiba_acpi in the 
> first place. We already have in-kernel module (toshiba) that provides 
> raw user space HCI access to those who need it. Why is it necessary to 
> duplicate this functionality in toshiba_acpi in the first place?

I did have reports of some machines like yours. This is the result on a
portege r100 (with unpatched toshiba_acpi:

% lsmod | grep tosh
toshiba_acpi            5336  0 
toshiba                 4152  0 
% fan
fan: laptop does not have cooling fan or kernel module not installed.

Behavior on most machines (and all three of mine) seems to be the same.

Charles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJqXu6PK2zrJwS/lYRArFkAJ4mUzyCekXST4fIKn3Uhw2srNdcdACZAVSo
Pis83ewju56RXMqPUdv+A0M=
=KU7l
-----END PGP SIGNATURE-----
