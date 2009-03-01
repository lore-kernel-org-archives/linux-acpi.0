From: Charles@Schwieters.org
Subject: Re: experimental patch for toshiba_acpi
Date: Sun, 01 Mar 2009 05:31:08 -0500
Message-ID: <E1Ldiwu-0001ag-8r@oaf.wireless>
References: <200902280015.17286.arvidjaar@mail.ru> <200902280913.45040.arvidjaar@mail.ru> <E1LdTUB-0007ck-1n@oaf.wireless> <200903011000.23872.arvidjaar@mail.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:59955 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751634AbZCAKcR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Mar 2009 05:32:17 -0500
In-reply-to: <200903011000.23872.arvidjaar@mail.ru> 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> On 28 ??????? 2009 21:00:26 Charles@schwieters.org wrote:
> >
> > > But then I do not understand why you need this in toshiba_acpi in
> > > the first place. We already have in-kernel module (toshiba) that
> > > provides raw user space HCI access to those who need it. Why is it
> > > necessary to duplicate this functionality in toshiba_acpi in the
> > > first place?
> >
> > I did have reports of some machines like yours. This is the result on
> > a portege r100 (with unpatched toshiba_acpi:
> >
> > % lsmod | grep tosh
> > toshiba_acpi            5336  0
> > toshiba                 4152  0
> > % fan
> > fan: laptop does not have cooling fan or kernel module not installed.
> >
> > Behavior on most machines (and all three of mine) seems to be the
> > same.
> >
> 
> Sorry for dumb question but are you doing it as root?

actually, I get the same result whether running root or not.

Charles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJqmPrPK2zrJwS/lYRAu38AJ9+NmkjhTr/AZH7HMZ6wthlPrnVSACcD9TU
zVBe/SjEYAZLlRpsoXDrbNA=
=HrY/
-----END PGP SIGNATURE-----
